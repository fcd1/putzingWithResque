class ImportsController < ApplicationController

  def queue_import_processing doi_id

    # @record = Record.find(record_id)
    # Resque.enqueue(JobTypeB, @record)
    Resque.enqueue(JobTypeC, doi_id)

  end

end
