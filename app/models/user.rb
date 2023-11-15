class User < ApplicationRecord

  before_create :overwrite_roll_admin
  before_update :reject_update
  before_destroy :reject_destroy

  has_many :tasks, dependent: :destroy
  accepts_nested_attributes_for :tasks,
   allow_destroy: true

  validates :name, presence: true, length: { maximum: 30 }
  before_validation { email.downcase! }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :email, uniqueness: true
  has_secure_password
  validates :password, length: { minimum: 6 }, on: :create

  enum roll: {
    general: 0,  # 一般
    admin: 1,    # 管理者
  }

  private

  def overwrite_roll_admin
    self.roll = 'admin' if User.where(roll: 'admin').count.zero?
  end

  def reject_update
    throw(:abort) if self.roll_change_to_be_saved == ['admin', 'general'] && User.where(roll: 'admin').count == 1
  end
  
  def reject_destroy
    throw(:abort) if self.roll == 'admin' && User.where(roll: 'admin').count == 1
  end
end
