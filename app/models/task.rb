class Task < ApplicationRecord
  belongs_to :user
  has_many :labelings, dependent: :destroy, foreign_key: 'task_id'
  has_many :labels, through: :labelings, source: :label

  validates :title, presence: true
  validates :summary, presence: true

  # ソート
  scope :default, -> { order(created_at: :desc) }
  scope :deadline, -> { order(deadline: :desc) }
  scope :priority, -> { order(priority: :desc) }

  # フィルター
  scope :my_task, -> (query){ where(user_id: query)}
  scope :title_like, -> (query) { where("title LIKE ?", '%' + query + '%' ) }
  scope :status, -> (query){ where(status: query) }
  scope :label_id, -> (query){ 
    joins(:labels).where('labels.id = ?', query) 
  }

  enum status: {
    untouched: 0,    # 未対応
    in_progress: 1,  # 進行中
    done: 2          # 完了
  }
  enum priority: {
    row: 0,     # 低
    normal: 1,  # 中
    high: 2     # 高
  }
end
