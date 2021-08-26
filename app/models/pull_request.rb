class PullRequest < ActiveRecord::Base
  belongs_to :user

  scope :author, ->(username) { where(user: User.where(username: username)) }

  acts_as_taggable

  validates :title, presence: true, allow_blank: false
  validates :url, presence: true, allow_blank: false
  validates :status, presence: true, allow_blank: false
end
