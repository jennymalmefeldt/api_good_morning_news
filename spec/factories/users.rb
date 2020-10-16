FactoryBot.define do
  factory :user do
    email { "user#{rand(0..999)}@mail.com" }
    password { "password" }
    password_confirmation { "password" }
    role { "registered" }
  end
end
