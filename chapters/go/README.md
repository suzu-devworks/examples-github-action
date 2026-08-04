# github.com/suzu-devworks/examples-github-action/chapters/go

## Create a new Go module for this chapter.

最初のモジュール作成

```bash
go mod init github.com/suzu-devworks/examples-github-action/chapters/go
go get github.com/gin-gonic/gin
```

## Uopdate dependencies

現在のモジュールとそのすべての依存関係を一覧表示します。

```bash
go list -m all
```

依存関係の必須バージョンを更新する

```bash
go get {package}@latest
```

すべての依存関係を最新バージョンに更新する

```bash
go get -u ./...
```

最小Goバージョンをアップグレード

```bash
go get go@latest
```

未使用の依存関係をクリーンアップします。

```bash
go mod tidy
```