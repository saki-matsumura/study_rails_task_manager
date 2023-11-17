FactoryBot.define do
  factory :labeling do
    # task
    # label
    # task { nil }
    # label { nil }
    association :task
    association :label
  end
end
