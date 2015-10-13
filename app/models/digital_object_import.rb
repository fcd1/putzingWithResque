class DigitalObjectImport < ActiveRecord::Base

  enum status: {pending: 0, success: 1, failure: 2}
  after_initialize :default_values
  belongs_to :import_job, required: true
  
  private

  def default_values

    pending! unless (success? || failure?)

  end

end
