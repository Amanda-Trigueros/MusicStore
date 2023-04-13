class AlbumOrder < ApplicationRecord
  belongs_to :order
  belongs_to :album
end
