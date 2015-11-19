Cat.create!(name: "Fido", color: "B", sex: "M", birth_date: "1980-11-01", description: "Good kitty!", user_id: 1)
Cat.create!(name: "Spot", color: "G", sex: "M", birth_date: "1908-12-01", description: "Bad kitty!", user_id: 1)
Cat.create!(name: "Mr. Kitty", color: "R", sex: "M", birth_date: "1988-3-01", description: "Good doggie!", user_id: 1)
Cat.create!(name: "Nalla", color: "I", sex: "F", birth_date: "1998-04-01", description: "Average kitty!", user_id: 1)
Cat.create!(name: "Buster", color: "Y", sex: "M", birth_date: "2010-08-01", description: "Broken kitty!", user_id: 1)
Cat.create!(name: "Winnie", color: "B", sex: "F", birth_date: "1992-08-10", description: "Crazy kitty!", user_id: 1)

CatRentalRequest.create!(cat_id: 6, user_id: 2, start_date: "2015-11-11", end_date: "2015-11-15")
CatRentalRequest.create!(cat_id: 6, user_id: 2, start_date: "2015-10-20", end_date: "2015-10-30", status: "APPROVED")
CatRentalRequest.create!(cat_id: 1, user_id: 2, start_date: "2014-3-20", end_date: "2014-3-30", status: "APPROVED")
CatRentalRequest.create!(cat_id: 3, user_id: 2, start_date: "2013-1-5", end_date: "2013-2-5", status: "DENIED")

user1 = User.new(username: "owner@test.com")
user1.password = "password"
user1.save!

user2 = User.new(username: "renter@test.com")
user2.password = "password"
user2.save!
