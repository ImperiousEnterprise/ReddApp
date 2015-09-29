class Comment < ActiveRecord::Base
  acts_as_tree order: 'created_at DESC'
  belongs_to :user
  belongs_to :link
  validates :body , presence: true , length: {maximum: 10000}
  #validate :user_quota, :on => :create
  private
    def user_quota
      if user.comments.today.count >= 5
        errors.add(:base,"Exceeds daily limit")
      end
    end
end
