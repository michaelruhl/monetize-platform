class MembershipsController < ApplicationController
    before_action :authenticate_user!

    def create
            newsletter = Newsletter.find(membership_params[:newsletter_id])
            checkout_session = Stripe::Checkout::Session.create(
                customer: current_user.stripe_customer_id,
                mode: 'subscription',
                line_items: [
                    {
                        quantity: 1,
                        price_data: {
                            currency: 'usd',
                            unit_amount: 2000,
                            product_data: {
                                name: newsletter.title,
                            },
                            recurring: {
                                interval: 'month',
                        }
                            
                        },
                    }
                ],
                subscription_data: {
                    transfer_data: {
                        destination: newsletter.author.stripe_account_id,
                        amount_percent: 95,
                    }
                },
                success_url: newsletter_url(newsletter) + "?session_id={CHECKOUT_SESSION_ID}",
                cancel_url: newsletter_url(newsletter)
            )



        @membership = current_user.memberships.new(
            membership_params.merge(
                stripe_checkout_session_id: checkout_session.id
            )
        )

        if @membership.save
            flash[:notice] = "Successfully created membership"
            redirect_to checkout_session.url, allow_other_host: true
        else
            render :new
        end
    end

    private
    
    def membership_params
        params.require(:membership).permit(
            :newsletter_id
            
        )
    end

end
