User.create!(name:  "Doan Chi Nhat",
             email: "doan.chi.nhat@framgia.com",
             password:              "chinhat1515",
             password_confirmation: "chinhat1515",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@framgia.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
# Entries
users = User.order(:created_at).take(6)
50.times do
	title = Faker::Lorem.sentence(7)
  content = Faker::Lorem.sentence(7)
  users.each { |user| user.entries.create!(content: content,title: title) }
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
