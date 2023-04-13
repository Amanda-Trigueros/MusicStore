class AlbumsOrder < ApplicationRecord
  belongs_to :order
  belongs_to :album
end
