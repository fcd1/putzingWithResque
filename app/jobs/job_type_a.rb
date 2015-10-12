class JobTypeA

  @queue = :job_type_a_queue

  def self.perform(params)

    puts "Processed a Type A Job with params:"
    puts params

  end

end
