class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :pull_request

  validates :body, presence: true, allow_blank: false
end
