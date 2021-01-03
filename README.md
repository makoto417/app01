# (アプリ名)

# アプリケーション概要

ゲームに関する情報の共有や一緒に遊ぶフレンドを募集することができるアプリです。


- ユーザー登録することで掲示板の作成とコメントができる
- ユーザー間のコミュニケーションを促すために、フォロー・DM機能を実装

# アプリケーションURL
- 

# 機能一覧

- ユーザー機能
- 投稿機能
- コメント機能
- フォロー機能
- ダイレクトメッセージ機能
- ページネーション機能
- 検索機能

# 機能詳細

## ユーザー機能

- deviseを使用
- 新規登録、ログイン、ログアウト、編集機能

## 掲示板機能

- 掲示板のタイトルと関連のタグを登録できる
- 作成された掲示板にコメントを投稿できる

## 投稿機能

- 一緒に遊ぶフレンドを募集する内容を投稿

## フォロー機能

- 気になったユーザーをフォローできる(Ajaxを用いた非同期処理)

## ダイレクトメッセージ機能

- チャットルームでメッセージを送信できる(Ajaxを用いた非同期処理)

## ページネーション機能

- gem 'kaminari' を使用して実装

## 検索機能

- gem 'ransack' を使用して実装


# 実装予定の機能
- レスポンシブデザイン
- タグ検索機能
- 通知機能

# データベース設計

## usersテーブル

|Column             |Type    |Options     |
|-------------------|--------|------------|
|nickname           |string  |null: false | 
|email              |string  |null: false |
|encrypted_password |string  |null: false |
|profile            |text    |            |

## Association

- has_many :boards
- has_many :comments
- has_many :consoles
- has_many :categories
- has_many :direct_messages
- has_many :posts

## categoriesテーブル

|Column  |Type       |Options |
|--------|-----------|--------|
|name    |string     |        |

## Association

- has_many :users
- has_many :boards
- has_many :posts

## consolesテーブル

|Column  |Type       |Options |
|--------|-----------|--------|
|name    |string     |        |

## Association

- has_many :users
- has_many :boards
- has_many :posts

## gamesテーブル

|Column  |Type       |Options |
|------  |-----------|--------|
|name    |string     |        |

## Association

- has_many :boards
- has_many :posts

## boardsテーブル

|Column  |Type       |Options           |
|--------|-----------|------------------|
|title   |string     |null: false       |
|user    |references |foreign_key: true |
|game    |references |foreign_key: true |

## Association

- belongs_to :user
- belongs_to :game
- has_many :comments
- has_many :consoles
- has_many :categories

## commentsテーブル

|Column  |Type       |Options           |
|--------|-----------|------------------|
|content |text       |null: false       |
|user    |references |foreign_key: true |
|board   |references |foreign_key: true |

## Association

- belongs_to :user
- belongs_to :board

## postsテーブル

|Column  |Type       |Options           |
|------  |-----------|------------------|
|message |text       |null: false       |
|user    |references |foreign_key: true |
|game    |references |foreign_key: true |

## Association

- belongs_to :user
- belongs_to :board
- belongs_to :game
- has_many :consoles
- has_many :categories

## roomsテーブル

|Column  |Type    |Options |
|--------|--------|--------|
|id      |integer |        |

## Association

- belongs_to :user
- belongs_to :room

## direct_messagesテーブル

|Column  |Type       |Options           |
|--------|-----------|------------------|
|message |text       |null: false       |
|user    |references |foreign_key: true |
|room    |references |foreign_key: true |

## Association

- belongs_to :user
- belongs_to :room

## direct_messagesテーブル

|Column      |Type    |Options |
|------------|--------|--------|
|follower_id |integer |        |
|followed_id |integer |        |

## Association

- belongs_to :follower, class_name: 'User'
- belongs_to :followed, class_name: 'User'

# ER図

<img src="public/images/er.png">


# 開発環境

- フロントエンド:HTML5/CSS(Sass)/JavaScript
- バックエンド:Ruby on Rails(6.0.3.4)/Ruby(2.6.5)
- テスト:RSpec
- Linter:Rubocop
- CI/CD:GitHub
- データベース:MySQL(5.6)
- インフラ:AWS
- Webサーバー:Nginx
- アプリケーションサーバ:Unicorn