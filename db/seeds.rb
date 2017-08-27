# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

n=1
while n<=5
  provider = ""
  password = "password"
  User.create!(
               user_name: Faker::Internet.user_name,
               uid: Faker::Number.number(10),
               provider: provider,
               email: Faker::Internet.email,
               password: password,
               id: n,
               )
               n=n+1
end

n=1
while n<=5
  Topic.create!(
    title: "あいうえお",
    content: "かきくけこ",
    user_id: n,
    id: n,
  )
  n=n+1
end

n=1
m=1
while n<=5
  while m<=5
  Comment.create!(
    content: "たちつてと",
    user_id: m,
    topic_id: n,
  )
  m = m+1
 end
  m=1
  n = n+1
end
