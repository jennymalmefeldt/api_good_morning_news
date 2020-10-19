Stripe.plan :gold_subscription do |plan|
  plan.name = "Good Morning News"

  plan.amount = 10000

  plan.currency = "sek"

  plan.interval = "month"

  plan.interval_count = 1
end
