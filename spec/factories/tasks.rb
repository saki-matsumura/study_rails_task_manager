FactoryBot.define do
  factory :task do
    title { "test_title" }
    summary { "test_summary" }
    deadline { "002023-11-01" }
  end
  factory :second_task, class: Task do
    title { "test_titl2" }
    summary { "test_summary2" }
    summary { "test_summary2" }
    deadline { "002023-11-01" }
  end
end
