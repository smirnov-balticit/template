FactoryGirl.define do

  factory :feedback do
    email   { Faker::Internet.email }
    message { Faker::HipsterIpsum.paragraph }
  end

end
