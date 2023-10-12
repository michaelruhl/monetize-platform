class WebhooksController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
        @event = Event.create!(
            data: params.to_json,
            source: params[:source],
            status: :pending
        )
        EventJob.perform_later(@event)
        render json: { status: :ok }
    end
end
