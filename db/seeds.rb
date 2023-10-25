# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
case Rails.env
when "development"
   # create villa data
   50.times do
    Villa.create({name: Faker::Name.unique.name})
   end

   #create calender data
   start_d = Date.civil(2023, 1, 1)
   end_d = Date.civil(2023, 1, 3)
   Villa.find_each do |villa|
    calender = Calender.new(villa_id: villa.id, start_date: start_d.strftime('%d/%m/%Y'), end_date: end_d.strftime('%d/%m/%Y'), rate_per_night: Faker::Number.between(from: 30000, to: 50000))
    if calender.save
      start_d = calender.start_date+10
      end_d =  calender.end_date+10
    end
   end

when "production"
end