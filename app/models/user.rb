class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :articles, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :username, uniqueness: { case_sensitive: true },
                       format: { with: /\A[a-zA-Z0-9]+\z/ },
                       presence: true,
                       allow_blank: false

  def generate_jwt
    JWT.encode({ id: id,
                 exp: 60.days.from_now.to_i },
               Rails.application.secrets.secret_key_base)
  end

  def favorite(article)
    favorites.find_or_create_by(article: article)
  end

  def unfavorite(article)
    favorites.where(article: article).destroy_all

    article.reload
  end

  def favorited?(article)
    favorites.find_by(article_id: article.id).present?
  end
end
