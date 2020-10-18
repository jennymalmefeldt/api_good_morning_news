class Api::V1::SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    begin
      customer_id = get_customer(params[:stripeToken])
      # when we have the subscriber we can create the subscription
      subscription = Stripe::Subscription.create({ customer: customer_id, plan: "gold_subscription" })
      # now we have to check if the invoice was created and the payment is done
      test_env?(customer_id, subscription)
      status = Stripe::Invoice.retrieve(subscription.latest_invoice).paid
      # .paid is true or false

      if status === true
        current_user.update_attribute(:role, "subscriber")
        render json: { message: "Subscription succesfully created!" }, status: :created
      else
        # it's still a possibility to reach this part
        render_stripe_error("Insufficient balance")
      end
    rescue => error
      # if begin or get_customer brakes will always come here and not to else
      render_stripe_error(error.message)
    end
  end

  private

  def test_env?(customer, subscription)
    if Rails.env.test?
      invoice = Stripe::Invoice.create({ customer: customer, subscription: subscription.id, paid: true })
      subscription.latest_invoice = invoice.id
    end
  end

  def get_customer(stripe_token)
    customer = Stripe::Customer.list(email: current_user.email).data.first
    customer ||= Stripe::Customer.create({ email: current_user.email, source: stripe_token, currency: "sek" })
    customer.id
    # we are asking if the user exists. Run the line 15 and if it could not find anything, continue with the next line. || is an OR. In this line create a new customer. In the next return the customer id
  end

  def render_stripe_error(error)
    render json: { message: "The subscription was not made. #{error}" }, status: 422
  end
end
