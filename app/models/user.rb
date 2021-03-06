class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates_presence_of :name # required
  has_many :orders
  has_many :addresses
  has_one :store
  has_one :coupon
  has_many :rates
  has_many :reviews
  has_one_attached :avatar
  after_create :send_admin_mail
    def send_admin_mail
      UserMailer.send_welcome_email(self).deliver_later
    end

  def get_orders(user)
    Order.where(user_id: user.id).size
  end
end
