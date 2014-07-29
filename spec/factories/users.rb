FactoryGirl.define do

  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { "#{first_name}#{last_name}@gmail.com" }
    password '123456' 
    password_confirmation '123456'
  end
  
end