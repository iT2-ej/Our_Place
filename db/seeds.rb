# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = Admin.find_or_create_by(email: "admin@test.com")
admin.update!(password: "password")

 

(1..10).each do |i|
  user = User.find_or_create_by(user_name: "user#{i}", 
                                email: "user#{i}@test.com",
                                last_name: "姓_#{i}",
                                first_name: "名_#{i}",
                                last_name_kana: "セイ_#{i}",
                                first_name_kana: "メイ_#{i}"
                                )
  user.update!(password: "password")
  #rand(1..3).times do |n|
  #  customer.posts.create!(content: "test" * (rend(30..40)))
  #end
end