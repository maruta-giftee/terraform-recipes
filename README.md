# terraform-recipes
TerraformのレシピやTips等を集約したリポジトリ

詳細な説明は後で記載する。

## 実行方法（AWS）

実行対象のディレクトリに移動します。

`cd providers/aws/`

`providers/aws/terraform.tfvars` を設置します。

```
access_key            = "YOUR_ACCESS_KEY"
secret_key            = "YOUR_SECRET_KEY"
workplace_cidr_blocks = ["200.200.200.200/32"]
ssh_public_key_path   = "~/.ssh/your_key_name.pem.pub"
```

`access_key`, `secret_key` は非常に強力な権限を持ったIAMアクセスキーです。

よってpublicなGitRepositoryには絶対に公開しないよう注意して下さい。

### SSH接続を許可するIPアドレス範囲を設定

`workplace_cidr_blocks` にはあなたのオフィスのIPアドレス範囲を入力して下さい。

例えばあなたのオフィスのIPが `200.200.200.200` 固定であれば `200.200.200.200/32` となります。

これはリスト構造なので複数設定する事が可能です。

### SSH接続用の鍵を作成

`ssh_public_key_path` にはOpenSSH形式の公開鍵のパスを設定します。

本プロジェクトのSSH接続は全て bastionサーバを経由します。

bastionサーバには `workplace_cidr_blocks` で許可した場所からのみ接続が可能となります。

その為、SSH接続用のキーペアを作成する必要があります。

`ssh-keygen` コマンドを使ってキーペアを作成しましょう。

下記にコマンドの例を記載しておきます。

`ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f your_key_name.pem`

下記のように表示されれば成功です。

```
+---[RSA 4096]----+
|       Eo+o .=.. |
|       . o+.B . .|
|        o.=X.=..o|
|       . *oo*o*o.|
|        S o.=+.o |
|         o.. oo  |
|          .o . o |
|         .= . o +|
|        .o o   .+|
+----[SHA256]-----+
```

`~/.ssh` に鍵が出力されています。

`providers/aws/terraform.tfvars` に以下の記述を追加して下さい。

先程のコマンドの例だと `~/.ssh/your_key_name.pem.pub` が作成されているハズなので、下記のようになるかと思います。

```
ssh_public_key_path   = "~/.ssh/your_key_name.pem.pub"
```

### workspaceの設定

`workspace` によって実行環境を切り替えます。

`providers/aws/` 配下で以下のコマンドを実行します。

`terraform workspace list`

実行結果は下記のようになります。

```
  default
* dev
```

これは現在の `workspace` が `dev` である事を表しています。

`workspace` を新規作成するには以下のように実行します。

`qa`, `dev`, `stg`, `prd` 全ての環境で利用する場合は以下のコマンドを全て実行して下さい。

- `terraform workspace new qa`
- `terraform workspace new dev`
- `terraform workspace new stg`
- `terraform workspace new prd`

`workspace` の切り替えは `terraform workspace select stg` のように実行します。

詳しくは公式ドキュメントの [workspace](https://www.terraform.io/docs/commands/workspace/index.html) を参照して下さい。

## よく利用する各種コマンド

### `terraform plan`

実行計画を確認するコマンドです。

開発環境等ではそれほど気にならないかもしれませんが、本番環境で予期しないリソースの再作成等が行われてしまうと大きな事故になってしまうのでこのコマンドで実行計画を確認しましょう。

（参考）[plan](https://www.terraform.io/docs/commands/plan.html)

### `terraform apply`

実際にCloudサービス上に適応します。

（参考）[apply](https://www.terraform.io/docs/commands/apply.html)

### `terraform fmt`

`.tf` ファイルを整形するコマンドです。

コミット前に必ずコマンドを実行しましょう。

`.git/hooks` に仕込んでおくとベストです。

（参考）[fmt](https://www.terraform.io/docs/commands/fmt.html)
