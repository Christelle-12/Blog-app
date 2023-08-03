FactoryBot.define do
  factory :comment do
    text { 'Default comment text' }
    association :post
    association :author, factory: :user
  end
end
