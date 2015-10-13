class RecordsController < ApplicationController

  def queue_record_change recrd_num

    # @record = Record.find(record_id)
    # Resque.enqueue(JobTypeB, @record)
    Resque.enqueue(JobTypeB, recrd_num)

  end

end
