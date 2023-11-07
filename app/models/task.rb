class Task < ApplicationRecord
  validates :title, presence: true
  validates :summary, presence: true

  # ソート
  scope :default, -> { order(created_at: :desc) }
  scope :deadline, -> { order(deadline: :desc) }

  # フィルター
  scope :title_like, -> (query) { where("title LIKE ?", '%' + query + '%' ) }
  scope :status, -> (query){ where(status: query) }

  enum status: {
    untouched: 0,    # 未対応
    in_progress: 1,  # 進行中
    done: 2          # 完了
  }
end
