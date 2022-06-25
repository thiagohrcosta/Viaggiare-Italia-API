class Product < ApplicationRecord
  belongs_to :destination
  belongs_to :category
end
