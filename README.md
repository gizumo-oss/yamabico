# yamabico

Gizumo 音声コンテンツ配信サービスプラットフォーム

## 必要な技術スタック

- **Node.js** (v18.x 以上)
- **npm** (v9.x 以上)
- **React** (v19.0.0)
- **React Native** (v0.79.2)
- **Expo** (v53.0.9)
- **TypeScript** (v5.8.3)
- **React Navigation** (v7.x)
- **Expo AV** - 音声再生用ライブラリ

## ディレクトリ構成とその簡易説明

```
src/
├── assets/                 # アイコン、スプラッシュ画像など静的リソース
├── components/             # 再利用可能なUIコンポーネント
│   └── AppHeader.tsx       # アプリヘッダーコンポーネント
├── App.tsx                 # アプリのメインコンポーネントとナビゲーション設定
├── TrackList.tsx           # 曲一覧画面のコンポーネント
├── BookmarksScreen.tsx     # お気に入り曲一覧画面のコンポーネント
├── index.ts                # アプリのエントリーポイント
├── app.json                # Expoの設定ファイル
├── tsconfig.json           # TypeScriptの設定
├── package.json            # プロジェクト依存関係の定義
└── README.md               # プロジェクト説明（本ファイル）
```

### 主要ファイルの説明

- **App.tsx**: ナビゲーションの設定と曲再生画面（PlayerScreen）の実装
- **TrackList.tsx**: 楽曲リスト画面の実装と曲の型定義
- **BookmarksScreen.tsx**: お気に入りに登録した曲の一覧表示と管理
- **components/AppHeader.tsx**: 各画面で使用するヘッダーコンポーネント

## 環境構築

### セットアップ手順

1. リポジトリのクローン

   ```
   git clone https://github.com/gizumo-oss/yamabico.git
   cd yamabico
   ```

2. 依存関係のインストール

   ```
   make setup
   ```

3. アプリの起動

   ```
   make start
   ```

4. 実行オプション
   - iOS シミュレータで実行: `make dev-ios`
   - Android エミュレータで実行: `make dev-android`
   - Web ブラウザで実行: `make dev-web`

### 開発中の注意点

- 音声ファイルは `assets` ディレクトリに配置してください
- 新しい依存関係を追加する場合は `expo install` コマンドを使用することをお勧めします
- TypeScript の型定義は TrackList.tsx に定義されています
