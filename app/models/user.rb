class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :downcase_email
  has_many :links
  validates :name , presence: true , length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email , presence: true , length: { maximum: 255 } , format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_many :comments do

    def today
      where(:created_at => (Time.zone.now.beginning_of_day..Time.zone.now))
    end
  end
  private
  def downcase_email
    self.email = email.downcase
  end
end
