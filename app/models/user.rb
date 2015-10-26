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
  has_many :api_tokens

  before_save :parameterize_userkey

  scope :like, ->(q) { where("UPPER(username) LIKE UPPER('%#{q}%') OR UPPER(userkey) LIKE UPPER('%#{q}%') OR UPPER(firstname) LIKE UPPER('%#{q}%') OR UPPER(lastname) LIKE UPPER('%#{q}%') OR UPPER(email) LIKE UPPER('%#{q}%')")}

  private

  def parameterize_userkey
      self.userkey = self.userkey.parameterize
  end
end