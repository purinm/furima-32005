# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_furigana     | string | null: false               |
| last_furigana      | string | null: false               |
| birthday           | date   | null: false               |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column          | Type       | Options                         |
| --------------- | ---------- | ------------------------------- |
| user            | references | null: false , foreign_key: true |
| name            | string     | null: false                     |
| description     | text       | null: false                     |
| category_id     | integer    | null: false                     |
| condition_id    | integer    | null: false                     |
| delivery_fee_id | integer    | null: false                     |
| days_to_sip_id  | integer    | null: false                     |
| prefecture_id   | integer    | null: false                     |
| cost            | integer    | null: false                     |

### Association

- belongs_to :user
- has_one :purchase
- belongs_to_active_hash :category
- belongs_to_active_hash :condition
- belongs_to_active_hash :delivery_fee
- belongs_to_active_hash :days_to_sip
- belongs_to_active_hash :prefectures

## purchases テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :address
- belongs_to :item

## addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| purchase      | references | null: false, foreign_key: true |
| zip_code      | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| street        | string     | null: false                    |
| building      | string     |                                |
| phone_number  | string     | null: false                    |

### Association

- belongs_to :purchase
- has_one_active_hash :prefecture
