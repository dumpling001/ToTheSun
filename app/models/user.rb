class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :articles
  has_many :comments

  has_many :article_relationships
  has_many :participated_articles, :through => :article_relationships, :source => :article

  def is_member_of?(article)
    participated_articles.include?(article)
  end

  def join!(article)
    participated_articles << article
  end

  def quit!(article)
    participated_articles.delete(article)
  end
end
