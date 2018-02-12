class Cat < ApplicationRecord
  has_many :naps, -> { where('0 = 0') }
  validates_presence_of :name
end
