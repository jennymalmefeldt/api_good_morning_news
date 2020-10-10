FactoryBot.define do
  factory :article do
    title { 'MyString' }
    teaser { 'MyText' }
    content { 'MyContent' }
    category { 'sports' }
  end
end
