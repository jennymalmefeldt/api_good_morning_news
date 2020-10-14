FactoryBot.define do
  factory :article do
    title { 'MyString' }
    teaser { 'MyText' }
    content { 'MyContent' }
    category { 'sports' }
    association :journalist, factory: :user
  end
end
