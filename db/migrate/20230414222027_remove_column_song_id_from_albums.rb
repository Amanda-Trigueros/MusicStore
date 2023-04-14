class RemoveColumnSongIdFromAlbums < ActiveRecord::Migration[7.0]
  def change
    remove_column :albums, :song_id, :index
  end
end
