FactoryBot.define do
  factory :task do
    title { "test_title" }
    summary { "test_summary" }
    deadline { "002023-11-01" }
    after(:create) do |task|
      create_list(:labeling, 1, task: task, label: create(:label))
    end
  end

  factory :second_task, class: Task do
    title { "test_titl2" }
    summary { "test_summary2" }
    deadline { "002023-11-01" }
    after(:create) do |task|
      create_list(:labeling, 2, task: task, label: create(:label))
    end
  end
end
