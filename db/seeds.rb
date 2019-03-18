# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
 trips = []
 user = User.find(1)

 10.times do
   trip = {
      city: "porto",
      mood: "test",
      user: user
   }
   trips.push(trip)
end

Trip.create(trips)
p 'Created trips'