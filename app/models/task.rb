class Task < ApplicationRecord
  # バリデーションを作ったら一度コミットする。
  validates :title, presence: true
  validates :summary, presence: true
end
