FactoryGirl.define do

  factory :post do
    user
    title { Faker::Lorem.sentence }
    body  { Faker::Lorem.sentence(3) }
  end
end