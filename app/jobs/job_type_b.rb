class JobTypeB

  @queue = :job_type_b_queue

  def self.perform(params)

    puts "Processed a Type B Job with params:"
    puts params

  end

end
