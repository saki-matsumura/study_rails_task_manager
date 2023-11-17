FactoryBot.define do
  factory :label do
    sequence(:title) { |n| "label-#{n}" }
  end
  factory :label_system_spec, class: Label do
    title { "system-label" } 
  end
end
