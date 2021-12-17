require 'active_support/testing/time_helpers'
include ActiveSupport::Testing::TimeHelpers
# ユーザー
User.create!(name:  "Example User",
    email: "example@railstutorial.org",
    password:              "foobar",
    password_confirmation: "foobar",
    admin:     true,
    activated: true,
    activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
        email: email,
        password:              password,
        password_confirmation: password,
        activated: true,
        activated_at: Time.zone.now)
end

# マイクロポスト
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end

# 以下のリレーションシップを作成する
users = User.all
user  = users.first
user.create_notice('初回ログインありがとうございます。', 'first_login')
following = users[2..50]

followers = users[3..14]
followers2 = users[15..19]
followers3 = users[20..36]
followers4 = users[37..40]

following.each do |followed|
  user.follow(followed)
end

followers.each do |follower|
  follower.follow(user)
end

travel_to 5.minutes.after do
  followers2.each do |follower|
    follower.follow(user)
  end
end

travel_to 15.minutes.after do
  followers3.each do |follower|
    follower.follow(user)
  end
end

travel_to 20.minutes.after do
  followers4.each do |follower|
    follower.follow(user)
  end
end
