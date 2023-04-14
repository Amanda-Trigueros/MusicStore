require 'faker'

puts "Clear database"
AlbumsOrder.destroy_all
Album.destroy_all
Order.destroy_all
Artist.destroy_all
Song.destroy_all
Customer.destroy_all

# Restaurar los id's de la base de datos
ActiveRecord::Base.connection.reset_pk_sequence!('albums')
ActiveRecord::Base.connection.reset_pk_sequence!('albums_orders')
ActiveRecord::Base.connection.reset_pk_sequence!('artists')
ActiveRecord::Base.connection.reset_pk_sequence!('costumers')
ActiveRecord::Base.connection.reset_pk_sequence!('orders')
ActiveRecord::Base.connection.reset_pk_sequence!('songs')

puts "Create new artist"
10.times do |number|
  artist = Artist.create(
    name: Faker::Music.unique.band,
    nationality: Faker::Nation.nationality,
    birth_date: Faker::Date.between(from: '1950-01-01', to: '1990-01-01'),
    death_date: Faker::Date.in_date_period,
    biography: Faker::Quote.famous_last_words,
  )

  if artist.save
    print "."
  else
    puts ""
    puts "F"
    puts artist.errors.full_messages.join(", ")
  end
end

puts "Create new song"
  60.times do |number|
    song = Song.create(
      name: Faker::Music::RockBand.song,
      duration: rand(140...200),
    )
  
    if song.save
      print "."
    else
      puts ""
      puts "F"
      puts song.errors.full_messages.join(", ")
    end
  end


puts "Create new album"
Artist.all.each do |artist|
  rand(2..6).times do |number|
    song_ids = Song.all.sample(rand(4..10)).pluck(:id)
    album = Album.new(
      name: Faker::Music.album,
      price: Faker::Alphanumeric.alphanumeric(number: 4, min_numeric: 4),
      duration: 500,
      song_id: song_ids,
      artist_id: artist.id,
    )
  
    if album.save
      print "."
    else
      puts ""
      puts "F"
      puts album.errors.full_messages.join(", ")
    end

  end
end




puts "\nEnd of seeding process"