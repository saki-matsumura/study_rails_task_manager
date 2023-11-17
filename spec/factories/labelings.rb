FactoryBot.define do
  factory :labeling do
    association :task
    association :label
  end
end
