FactoryBot.define do
  factory :article do
    title { 'MyString' }
    teaser { 'MyText' }
    content { 'MyContent' }
    category { 'MyCategory' }
  end
end
