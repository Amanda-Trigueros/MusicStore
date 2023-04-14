class AddColumnAlbumIdToSongs < ActiveRecord::Migration[7.0]
  def change
    add_reference :songs, :album, foreign_key: true , null: false
  end
end
