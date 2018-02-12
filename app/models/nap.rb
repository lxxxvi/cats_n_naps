class Nap < ApplicationRecord
  belongs_to :cat
  validates_presence_of :title
end
