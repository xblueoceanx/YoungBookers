class Review < ApplicationRecord

  belongs_to :reviewer

  validates :title, presence: true, length: {maximum: 50 }
  validates :book_review, presence: true, length: {maximum: 500 }

  has_many :favorites, dependent: :destroy

  def favorited_by?(reviewer)
    favorites.where(reviewer_id: reviewer.id).exists?
  end

end
