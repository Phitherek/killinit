class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :timeoutable
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :userkey, presence: true, uniqueness: true
  has_many :killin_its_from, class_name: "KillinIt", foreign_key: :from_user_id
  has_many :killin_its_to, class_name: "KillinIt", foreign_key: :to_user_id

  before_save :parameterize_userkey

  private

  def parameterize_userkey
      self.userkey = self.userkey.parameterize
  end
end