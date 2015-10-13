require 'rails_helper'

RSpec.describe ImportJob, :type => :model do

  let(:test_id) { i = 77 }
  let(:test_id_2) { i = 78 }

  before(:context) do

    # @test_user = User.find_by_first_name('Test')
    @test_user = User.create!(id: 1966, name:'Test User')
    @test_import_job = ImportJob.create!(id: 1966, name: 'Test Import Job', user: @test_user)
    @test_digital_object_import_1 = DigitalObjectImport.create!(id: 1966, import_job: @test_import_job)
    @test_digital_object_import_2 = DigitalObjectImport.create!(id: 1967, import_job: @test_import_job)
    @test_digital_object_import_3 = DigitalObjectImport.create!(id: 1968, import_job: @test_import_job)

  end

  after(:context) do

    @test_digital_object_import_1.destroy
    @test_digital_object_import_2.destroy
    @test_digital_object_import_3.destroy
    @test_import_job.destroy
    @test_user.destroy

      
  end

  before(:example) do

    @test_import_job.digital_object_imports.each do |import|

      import.pending!

    end

  end

  context "test has_many DigitalObjectImport association" do

    it "dependent: :destroy modifier on has_many association with DigitalObjectImport" do

      association = ImportJob.reflect_on_association(:digital_object_imports)
      expect(association.options[:dependent]).to eq(:destroy)
      
    end

  end

  context "#new:" do

    it "value of belongs_to User matches User instance passed at creation" do

      local_user = @test_import_job.user
      expect(local_user).to eq(@test_user)

    end

    it "instance is valid if required name arg is given" do

      new_import_job = ImportJob.new(id: 1967, name: 'New Import Job', user: @test_user)
      expect(new_import_job.valid?).to eq(true)

    end

    it "instance is invalid if required name arg is missing" do

      new_import_job = ImportJob.new(id: 1968, user: @test_user)
      expect(new_import_job.invalid?).to eq(true)

    end

    it "instance is invalid if required User arg is missing" do

      new_import_job = ImportJob.new(id: 1969, name: 'New Import Job')
      expect(new_import_job.invalid?).to eq(true)

    end

    it "instance has 3 DigitalObjectImports instances associated with it" do

      num_of_digital_object_import = @test_import_job.digital_object_imports.size
      expect(num_of_digital_object_import).to eq(3)

    end

    it "instance can access all 3 DigitalObjectImports instances associated with it at their creation" do

      digital_object_imports = DigitalObjectImport.where(import_job: @test_import_job)
      expect(digital_object_imports).to eq(@test_import_job.digital_object_imports.all)

    end

  end  

  context "#success?: " do

    it "returns false for the newly created ImportJob containing 3 DigitalObjectImports" do

      expect(@test_import_job.success?).to eq(false)

    end
 
    it "returns true if all DigitalObjectimports belonging to it were successful" do

      @test_import_job.digital_object_imports.each do |digital_object_import|

        digital_object_import.success!
        
      end

      expect(@test_import_job.success?).to eq(true)

    end

    it "returns false if all imports for the job were successful expect one (a failure)" do

      @test_import_job.digital_object_imports.each do |digital_object_import|

        digital_object_import.success!
        
      end

      # change the first on to a failure
      @test_import_job.digital_object_imports.first.failure!

      expect(@test_import_job.success?).to eq(false)
      
    end

  end

  context "#return_pending_digital_object_imports" do

    it "one failure: returns the correct instance of DigitalObjectImport" do

      @test_import_job.digital_object_imports.second.failure!
      expect(@test_import_job.return_pending_digital_object_imports).to eq([@test_import_job.digital_object_imports.first,
                                                                           @test_import_job.digital_object_imports.last])

    end

  end

  context "#return_success_digital_object_imports" do

    it "one failure: returns the correct instance of DigitalObjectImport" do

      @test_import_job.digital_object_imports.second.success!
      expect(@test_import_job.return_successful_digital_object_imports).to eq([@test_import_job.digital_object_imports.second])

    end

  end

  context "#return_failed_digital_object_imports" do

    it "one failure: returns the correct instance of DigitalObjectImport" do

      @test_import_job.digital_object_imports.second.failure!
      expect(@test_import_job.return_failed_digital_object_imports).to eq([@test_import_job.digital_object_imports.second])

    end

  end

end
