FactoryBot.define do
  factory :work_space do
    name { Faker::Internet.name }
    description { Faker::Lorem.sentence }
    user_id { 1 }
  end
end
