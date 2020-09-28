class Review < ApplicationRecord

  belongs_to :reviewer

  validates :title, presence: true
  validates :book_review, presence: true,length: {maximum: 200 }

end
