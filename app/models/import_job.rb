class ImportJob < ActiveRecord::Base

  # the name attribute will be the csv filename, and thus may not be unique
  validates :name, presence: true
  has_many :digital_object_imports, dependent: :destroy
  belongs_to :user, required: true


  def success?

    # DigitalObjectImport.where(import_job: self).each do |import|
    digital_object_imports.each do |import|

      # puts 'Here is the DigitalObjectImport inside the where:' +  import.inspect
      return false if (import.pending? || import.failure?)

    end

    # if got here, the all imports were successfull
    true

  end

  def return_pending_digital_object_imports

    results = Array.new

    # DigitalObjectImport.where(import_job: self).each do |import|
    self.digital_object_imports.each do |import|

      results << import if import.pending?

    end

    results

  end

  def return_successful_digital_object_imports

    results = Array.new

    # DigitalObjectImport.where(import_job: self).each do |import|
    self.digital_object_imports.each do |import|

      results << import if import.success?

    end

    results

  end

  def return_failed_digital_object_imports

    results = Array.new

    # DigitalObjectImport.where(import_job: self).each do |import|
    self.digital_object_imports.each do |import|

      results << import if import.failure?

    end

    results

  end

end
