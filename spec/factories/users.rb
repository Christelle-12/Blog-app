# spec/factories/user.rb

FactoryBot.define do
    factory :user do
      name { Faker::Name.name }
      photo { Faker::Avatar.image }
      # Add other attributes as needed
    end
  end
  