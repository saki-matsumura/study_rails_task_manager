FactoryBot.define do
  factory :user do
    name { "user_name1" }
    email { "user1@xmail.com" }
    password { "MyString" }
    roll { 0 }
  end
end
