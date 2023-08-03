FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    photo { Faker::Avatar.image }
  end
end
