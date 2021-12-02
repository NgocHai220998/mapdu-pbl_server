FactoryBot.define do
  factory :todo do
    title { Faker::Internet.name }
    description { Faker::Lorem.sentence }
    priority { "LOW" }
    status { "DONE" }
    work_space_id { 1 }
  end
end
