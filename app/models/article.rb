class Article < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :article_relationships
  has_many :members, through: :article_relationships, source: :user
  validates :title, presence: true
  validates :content, presence: true
end
