# 要件定義・初期設計

## アプリ概要
Spring Bootを使った株管理Webアプリケーション。  
TerraformでAWS等のインフラをコード管理・自動構築。

## 主な機能
- 株情報一覧表示
- 新規登録/編集/削除
- 検索・絞込
- インフラ構成: AWS（EC2, RDS, S3, VPC など）

## 技術構成
- バックエンド: Spring Boot (Java)
- データベース: MySQL（AWS RDS）
- フロントエンド: Thymeleaf（またはReactなど）
- CI/CD: GitHub Actions
- インフラ: Terraform（AWS）

## 画面イメージ
- 株一覧画面
- 登録・編集画面
- 削除ダイアログ

## Terraform管理リソース例
- EC2（Webサーバ）
- RDS（DB）
- S3（ファイル/バックアップ）
- VPC, IAM, Security Group