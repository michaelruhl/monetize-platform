class BillingsController < ApplicationController
    before_action :authenticate_user!

    def show
        # Redirect to the Stripe Customer portal
        customer_portal = Stripe::BillingPortal::Session.create(
            customer: current_user.stripe_customer_id,
            return_url: dashboard_url
        )
        redirect_to customer_portal.url, allow_other_host: true
    end

end
