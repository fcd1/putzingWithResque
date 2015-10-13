require 'rails_helper'

RSpec.describe RecordsController, type: :controller do

  before(:context) do

    #record = Record.new id: 1966
    #record.test_string = "Fred"

  end

  context "#run_test_job" do

    # testManageJobsController = ManageJobsController.new

    testRecordsController = RecordsController.new

    it "returns the argument surrounded by the test string" do

      @record = Record.create! id: 1966, test_string: 'Fred'

      expected_result = "Testing!!! -- " + @record.test_string + " -- Testing!!!"

      testRecordsController.run_test_job @record.id

      sleep 5

      @record.reload

      expect(@record.test_string).to eq(expected_result)

    end

  end

end
