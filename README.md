# self-directed training

Spring Boot + Terraformで構築する株管理Webアプリです。

## 主な機能
- 株情報の一覧表示・検索
- 登録・編集・削除
- AWSインフラはTerraformで管理

## ディレクトリ構成
```
/
├─ app/             # アプリ本体（Spring Bootなど）
├─ infra/           # Terraformモジュール・設定ファイル
│    ├─ main.tf
│    ├─ variables.tf
│    └─ ...
├─ docs/            # 設計・運用ドキュメント
├─ .github/         # CI/CDワークフロー
├─ .gitignore
├─ README.md
├─ LICENSE
```

## 開発環境
- Java / Spring Boot
- MySQL（AWS RDS）
- Terraform v1.x
- Docker（必要に応じて）
- CI: GitHub Actionsで自動テスト・Terraformのplan/validate

## インフラ構築手順
1. `cd infra`
2. `terraform init`
3. `terraform plan`
4. `terraform apply`

## コントリビューション
- Issue/Pull Request歓迎
- Terraformはinfra/ディレクトリに配置