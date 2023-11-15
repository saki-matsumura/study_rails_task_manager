# README

## テーブルスキーマ
### model
task
| カラム名 | データ型 |
----|----
| title | text |
| summary | text |
| deadline | date |
| status | integer |
| priority | integer |
| user_id | bigint |

user
| カラム名 | データ型 |
----|----
| name | string |
| email | string |
| password | string |
| roll | integer |

## デプロイ方法
- Herokuのバージョンを20へ切り替える
    - heroku stack:set heroku-20
- プラットフォームを追加
    - bundle lock --add-platform x86_64-linux
- package.jsonファイルに以下の内容を追記
    - "engines":{
        "node": "16.x"
    }
- 上記を設定した上で、Step2のバージョンをデプロイ
    - git push heroku step2:master


## 使用したgem
- net-smtp
- net-imap
- net-pop
- enum_help
- kaminari