# 開発体制・ブランチ運用

## ブランチ構成
- main　　　：リリース用の安定ブランチ
- develop　 ：アプリ開発用メインブランチ
- feature/xxx：機能追加・改修（アプリ）
- bugfix/xxx ：バグ修正
- infra/xxx　：Terraform構成変更・追加（infra/配下）

## 運用ルール
1. Issueを立てて作業内容・目的を明確化
2. 対応するfeature/bugfix/infraブランチを作成
3. 作業・コミット（PR単位で粒度を意識）
4. Pull Request作成 → レビュー
5. OKなら main/develop へマージ
6. 不要なブランチは削除

## CI/CD
- GitHub Actionsで自動テスト（Java）
- Terraform plan/validateのCIも実施
- PRごとの自動チェック推奨