FactoryBot.define do
  factory :comment do
    course { nil }
    author { "MyString" }
    content { "MyText" }
    reported_count { 1 }
  end
end
