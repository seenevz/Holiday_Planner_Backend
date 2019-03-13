class Place < ApplicationRecord
  belongs_to :day
  has_many :categories
end
