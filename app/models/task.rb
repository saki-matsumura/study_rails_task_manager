class Task < ApplicationRecord
  validates :title, presence: true
  validates :summary, presence: true

  scope :default, -> { order(created_at: :desc) }
  scope :deadline, -> { order(deadline: :desc) }

  enum status: {
    untouched: 0,     # 未対応
    in_progress: 1,  # 進行中
    done: 2   # 完了
  }
end
