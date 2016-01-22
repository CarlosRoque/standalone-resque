class App
  def async_message(message)
    Resque.enqueue(Job,message)
  end
end
