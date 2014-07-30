FactoryGirl.define do
  factory :user do
    email "example2@example.com"
    password 'PAssword'
    password_confirmation 'PAssword'
    
    factory :admin_user do
      admin true
    end
  end
end