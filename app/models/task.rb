class Task < ApplicationRecord
  validates :title, presence: true
  validates :summary, presence: true

  # ソート
  scope :default, -> { order(created_at: :desc) }
  scope :deadline, -> { order(deadline: :desc) }

  # フィルター
  # scope :task_title_like, -> title {}

  enum status: {
    untouched: 0,    # 未対応
    in_progress: 1,  # 進行中
    done: 2          # 完了
  }
end
