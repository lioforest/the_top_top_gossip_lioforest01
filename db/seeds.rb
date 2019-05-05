# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
City.destroy_all
User.destroy_all
Gossip.destroy_all
Tag.destroy_all
TagGossipLink.destroy_all
Comment.destroy_all
PrivateMessage.destroy_all
RecipientToPmLink.destroy_all

puts "------Seed table city"
10.times do
  city = City.create!(name: Faker::Address.city, zip_code: rand(10000..95000))
end
puts "Ok 10 cities ont été créées"

puts "------Seed table user"
10.times do
  user = User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.sentence, email: Faker::Internet.email, age: rand(15..99),city: City.all.sample)
end
puts "Ok 10 users ont été créés"

puts "------Seed table gossip"
20.times do
  gossip = Gossip.create!(title: Faker::GreekPhilosophers.name , content: Faker::GreekPhilosophers.quote ,user: User.all.sample)
end
puts "Ok 20 gossips ont été créés"

puts "------Seed table tag"
10.times do
  Tag.create(title: "#" + Faker::Book.genre.gsub(/ /, "_"))
end
puts "Ok 10 tags ont été créés"

puts "------Seed table TagGossipLink 3 tag minimum pour chaque Gossip"
#on ajoute entre 3 et 6 tag a chaque gossip
Gossip.all.each do |gossip|
	rand(3..6).times do	
  		TagGossipLink.create(gossip: gossip, tag: Tag.all.sample)
	end
end
puts "Ok entre 3 et 6 tags ont été créés pour chaque Gossip"


puts "------Seed table Comment"

20.times do
  comment = Comment.create!(content: Faker::Lorem.paragraph, user: User.all.sample, gossip: Gossip.all.sample )

end
puts "Ok 20 comments ont été créés"


puts "------Seed table PrivateMessage"

rand(20..40).times do
  pm = PrivateMessage.create(
    sender: User.all.sample,
    content: "\"#{Faker::Games::WorldOfWarcraft.quote}\" dixit #{Faker::Games::WorldOfWarcraft.hero}\n\"#{Faker::Games::Fallout.quote}\" answered #{Faker::Games::Fallout.character}"
  )
  recipients = Array.new

  rand(1..10).times do
    while true
      recipient = User.all.sample
      break unless recipients.include?(recipient)
    end
    recipients << recipient
    RecipientToPmLink.create(
      received_message: pm,
      recipient: recipient
    )
  end
end
