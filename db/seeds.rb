# カテゴリーデータ
Category.create(name: 'シューティングゲーム(STG)')
Category.create(name: 'アクションゲーム(ACT)')
Category.create(name: 'ロールプレイングゲーム(RPG)')
Category.create(name: 'パズルゲーム(PZL)')
Category.create(name: 'レースゲーム(RCG)')
Category.create(name: 'シミュレーションゲーム(SLG)')
Category.create(name: 'スポーツゲーム')
Category.create(name: '音楽ゲーム')
Category.create(name: 'ボードゲーム')

# 使用機器
Console.create(name: 'スマホ')
Console.create(name: 'PS4')
Console.create(name: 'Switch')
Console.create(name: 'PC')
Console.create(name: 'PS5')
Console.create(name: 'Xbox')

# ゲーム
Game.create(name: 'APEX')
Game.create(name: 'Fortnite')
Game.create(name: 'PLAYERUNKNOWN’S BATTLEGROUNDS')
Game.create(name: 'Rainbow Six Sige')
Game.create(name: 'THE KING OF FIGHTERS XIV STEAM EDITION')
Game.create(name: 'STREET FIGHTER V')
Game.create(name: 'Monster Hunter:World')
Game.create(name: 'CoD')
Game.create(name: 'Minecraft')
Game.create(name: 'Dead by Daylight')

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