class EventJob < ApplicationJob
  queue_as :default

  def perform(event)
    # Do something later
    puts "EventJob: #{event.inspect}"
  end
end
