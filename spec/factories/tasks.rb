FactoryBot.define do
  factory :task do
    title { "test_title" }
    summary { "test_summary" }
  end
  factory :second_task, class: Task do
    title { "test_titl2" }
    summary { "test_summary2" }
  end
end
