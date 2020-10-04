class Favorite < ApplicationRecord

  belongs_to :reviewer
  belongs_to :review

end
