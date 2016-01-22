
class Job
  @queue = :test
  def self.perform(message)
    sleep rand(1..10)
    open('myfile.out', 'a') { |f|
      f.puts message
    }
  end
end
