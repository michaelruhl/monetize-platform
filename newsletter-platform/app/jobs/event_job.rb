class EventJob < ApplicationJob
  queue_as :default

  def perform(event)
    # Do something later
    
    if event.source == 'stripe'
      puts "Handling Stripe event: #{event.inspect}" 
      handle_stripe_event(event)
    end
  end

  def handle_stripe_event(raw_event)
    event = Stripe::Event.construct_from(JSON.parse(raw_event.Data))
    case event.type
    when 'account.updated'
      handle_account_updated(event)
    end
  end

  def handle_account_updated(event)
    account = Account.find_by(stripe_account_id: event.account)
    account.update(
      charges_enabled: event.data.object.charges_enabled,
      transfers_enabled: event.data.object.payouts_enabled,
      details_submitted: event.data.object.details_submitted
    )
  end

end
