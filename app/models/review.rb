class Review < ApplicationRecord

  belongs_to :reviewer

  validates :title, presence: true
  validates :book_review, presence: true,length: {maximum: 200 }

  has_many :favorites, dependent: :destroy

  def favorited_by?(reviewer)
    favorites.where(reviewer_id: reviewer.id).exists?
  end

end
