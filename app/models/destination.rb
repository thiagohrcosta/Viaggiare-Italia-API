class Destination < ApplicationRecord

  has_one_attached :photo
  has_one_attached :banner
end
