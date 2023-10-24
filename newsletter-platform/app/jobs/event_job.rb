class EventJob < ApplicationJob
  queue_as :default

  def perform(event)
    event.update(
      status: :processing,

    )
    # Do something later
    
    if event.source == "stripe"
      puts "Handling Stripe event: #{event.inspect}" 
      handle_stripe_event(event)
    end
    
    event.update(
      status: :processed
    )
  rescue => e
    event.update(
      processing_errors: e.to_s,
      status: :failed
    )

  end

  def handle_stripe_event(raw_event)
    event = Stripe::Event.construct_from(JSON.parse(raw_event.data))
    case event.type
    when 'account.updated'
      handle_account_updated(event)
    when 'checkout.session.completed'
      checkout_session = event.data.object
      handle_checkout_session_completed(checkout_session)

    when 'customer.subscription.updated', 'customer.subscription.deleted'
      handle_subscription_updated(event)
    
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

  def handle_checkout_session_completed(checkout_session)
    membership = Membership.find_by(stripe_checkout_session_id: checkout_session.id)
    subscription = Stripe::Subscription.retrieve(checkout_session.subscription)
    membership.update!(
      stripe_subscription_id: checkout_session.subscription,
      status: subscription.status
    )
  
  end

  def handle_subscription_updated(event)
    subscription = event.data.object
    membership = Membership.find_by(stripe_subscription_id: subscription.id)
    if subscription.status == 'canceled'
      membership.destroy!
    else
    membership.update!(
      status: subscription.status
    )
    end
  end

end
