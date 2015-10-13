class JobTypeB

  @queue = :job_type_b_queue

  def self.perform(record_id)

    puts "Pickles! Processed a Type B Job with Record param:"
    puts "Reallyu"

    record = Record.find(record_id)

    puts record.inspect
    
    original_text = record.test_string

    puts original_text

    record.test_string = 'Hi, Fred!' + Time.new.to_s

    puts record.inspect

    # record.test_string = "Testing!!! -- " + original_text + " -- Testing!!!"

    record.save

    puts "Done Processing"

  end

end
