class JobTypeC

  @queue = :job_type_c_queue

  def self.perform(doi_id)

    puts "About to process a Type C Job that retrieves DigitalObjectImport instance"
    puts "using the passed-in id. Id is " + doi_id.to_s + '.'

    # Retrieve DigitalObjectImport instance from table

    digital_object_import = DigitalObjectImport.find(doi_id)

    puts digital_object_import.inspect

    # for now, just change the status to success
    digital_object_import.success!

    puts digital_object_import.inspect

    puts "Done Processing"

  end

end
