class EventJob < ApplicationJob
  queue_as :default

  def perform(event)
    # Do something later
    puts "EventJob: #{event.inspect}"
    if event.source == 'stripe'
      puts "Handling Stripe event: #{event.inspect}" 
      handle_stripe_event(event)
    end
  end

  def handle_stripe_event(event)
  end
end
