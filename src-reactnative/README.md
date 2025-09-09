# Vibe Yamabico

音楽再生アプリケーション「Vibe Yamabico」のリポジトリです。お気に入りの曲をブックマークして楽しむことができます。

## 必要な技術スタック

- **Node.js** (v18.x以上)
- **npm** (v9.x以上)
- **React** (v19.0.0)
- **React Native** (v0.79.2)
- **Expo** (v53.0.9)
- **TypeScript** (v5.8.3)
- **React Navigation** (v7.x)
- **Expo AV** - 音声再生用ライブラリ

## ディレクトリ構成とその簡易説明

```
vibe-yamabico/
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

### 前提条件

以下のツールが開発環境にインストールされていることを確認してください：

1. **Node.js** と **npm**
   ```
   # バージョン確認
   node -v
   npm -v
   ```

2. **Expo CLI**
   ```
   npm install -g expo-cli
   ```

### セットアップ手順

1. リポジトリのクローン
   ```
   git clone https://github.com/sankitch/vibe-yamabico.git
   cd vibe-yamabico
   ```

2. 依存関係のインストール
   ```
   npm install
   ```

3. アプリの起動
   ```
   npm start
   # または
   expo start
   ```

4. 実行オプション
   - iOSシミュレータで実行: `npm run ios`
   - Androidエミュレータで実行: `npm run android`
   - Webブラウザで実行: `npm run web`

### 開発中の注意点

- 音声ファイルは `assets` ディレクトリに配置してください
- 新しい依存関係を追加する場合は `expo install` コマンドを使用することをお勧めします
- TypeScriptの型定義は TrackList.tsx に定義されています