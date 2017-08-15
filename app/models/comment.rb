class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article

  scope :recent, -> { order("created_at DESC")}
end
