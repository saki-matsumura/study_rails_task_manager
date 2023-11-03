class Task < ApplicationRecord
  validates :title, presence: true
  validates :summary, presence: true

  # scope :deadline, -> { order(deadline: :desc) }
  scope :default, -> { order(created_at: :desc) }
  scope :deadline, -> { order(deadline: :desc) }
end
