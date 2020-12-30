# テストユーザー
100.times do |u|
  nickname = "テストユーザー#{u+1}"
  email = "user#{u+1}@test.com"
  password = "000000"
  profile = Faker::Lorem.paragraph_by_chars
  User.create!(
    nickname: nickname,
    email: email,
    password: password,
    profile: profile
  )
end

# ユーザーとの関連付け
100.times do
  user_id = Faker::Number.between(from:1, to:100)
  category_id = Faker::Number.between(from:1, to:9)
  console_id = Faker::Number.between(from:1, to:6)
  UserCategoryRelation.create!(
    user_id: user_id,
    category_id: category_id
  )
  UserConsoleRelation.create!(
    user_id: user_id,
    console_id: console_id
  )
end

# 掲示板
100.times do |n|
  user_id = Faker::Number.between(from:1, to:100)
  game_id = Faker::Number.between(from:1, to:10)
  title = "スレッドタイトル#{n+1}"
  Board.create!(
    title: title,
    user_id: user_id,
    game_id: game_id
  )
end

# 掲示板と関連付け
100.times do
  board_id = Faker::Number.between(from:1, to:100)
  category_id = Faker::Number.between(from:1, to:9)
  console_id = Faker::Number.between(from:1, to:6)
  BoardCategoryRelation.create!(
    board_id: board_id,
    category_id: category_id
  )
  BoardConsoleRelation.create!(
    board_id: board_id,
    console_id: console_id
  )
end

# コメント
200.times do
  user_id = Faker::Number.between(from:1, to:100)
  board_id = Faker::Number.between(from:1, to:100)
  content = Faker::Lorem.paragraph_by_chars
  Comment.create!(
    user_id: user_id,
    board_id: board_id,
    content: content
  )
end