class Album < ApplicationRecord
  belongs_to :song
  belongs_to :artist

  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }
end
