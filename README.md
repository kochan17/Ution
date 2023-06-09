# データベース設計

## Usersテーブル

| Column      | Type   | Options     |
| ----------- | ------ | ----------- |
| id          | bigint | primary key |
| username    | string | null: false |
| password    | string | null: false |
| email       | string | null: false |

## Botsテーブル

| Column      | Type   | Options     |
| ----------- | ------ | ----------- |
| id          | bigint | primary key |
| botname     | string | null: false |
| description | text   | null: false |

## Conversationsテーブル

| Column      | Type   | Options                        |
| ----------- | ------ | ------------------------------ |
| id          | bigint | primary key                    |
| user_id     | bigint | null: false, foreign key (Users) |
| bot_id      | bigint | null: false, foreign key (Bots) |
| content     | text   | null: false                    |
| created_at  | datetime | null: false                  |
