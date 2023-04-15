require 'faker'

puts "Clear database"
Song.destroy_all
AlbumsOrder.destroy_all
Album.destroy_all
Order.destroy_all
Artist.destroy_all
Customer.destroy_all

# Restaurar los id's de la base de datos
ActiveRecord::Base.connection.reset_pk_sequence!('albums')
ActiveRecord::Base.connection.reset_pk_sequence!('albums_orders')
ActiveRecord::Base.connection.reset_pk_sequence!('artists')
ActiveRecord::Base.connection.reset_pk_sequence!('customers')
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

puts "\nCreate new Customer"
15.times do |number|
  customer = Customer.create(
    username: Faker::FunnyName.unique.name,
    email: Faker::Internet.email,
    password: Faker::Alphanumeric.alphanumeric(number: 6, min_numeric: 1),
    name: Faker::Name.unique.name,
    active_flag: Faker::Boolean.boolean(true_ratio: 0.8),
  )

  if customer.save
    print "."
  else
    puts ""
    puts "F"
    puts customer.errors.full_messages.join(", ")
  end
end

puts "\nCreate new album"
Artist.all.each do |artist|
  rand(2..6).times do |number|
    albums = Album.new(
      name: Faker::Music.album,
      price: Faker::Alphanumeric.alphanumeric(number: 4, min_numeric: 4),
      artist_id: artist.id,
    )
  
    if albums.save
      print "."
    else
      puts ""
      puts "F"
      puts albums.errors.full_messages.join(", ")
    end

  end
end

puts "\nCreate new song"
Album.all.each do |album|
  rand(4..10).times do |number|
    song = Song.new(
      name: Faker::Music::RockBand.song,
      duration: rand(140...200),
      album_id: album.id,
    )

    if song.save
      print "."
    else
      puts ""
      puts "F"
      puts song.errors.full_messages.join(", ")
    end

  end

  album_duration = Song.where(album_id: album.id).sum(:duration)
  album.update(duration: album_duration)
end

puts "\nCreate new order"
Customer.all.each do |customer|
  rand(1..5).times do |number|
    order = Order.new(
      date: Faker::Date.between(from: '2023-01-01', to: 1.days.ago),
      total: 500,
      customer_id: customer.id,
    )

    if order.save
      print "."
    else
      puts ""
      puts "F"
      puts order.errors.full_messages.join(", ")
    end

  end

end

puts "\nCreate new albums_orders"
Order.all.each do |order|
  rand(1..4).times do |number|
    albums_orders = AlbumsOrder.new(
      order_id: order.id,
      album_id: Album.all.sample.id,
      album_copies: rand(1..3),
    )
    
    if albums_orders.save
      print "."
    else
      puts ""
      puts "F"
      puts albums_orders.errors.full_messages.join(", ")
    end
  end
end

puts "\nEnd of seeding process"