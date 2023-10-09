# serverless-examples

## setup

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# v18系のLTSをインストール
nvm install --lts=Hydrogen
nvm alias default lts/Hydrogen
```

## install serverless framework

```bash
npm install -g serverless

# チェック
sls -v
```

## create project

```bash
serverless create --template-url https://github.com/serverless/examples/tree/v3/aws-node-typescript --path example-app
```

ソースコードはsrc配下に入れておく

## test

```bash
yarn sls deploy
```

別のターミナルを開いて

```bash
yarn sls invoke local -f hello --path src/functions/hello/mock.json
```

## deploy

### install esbuild

```bash
npm install -D @types/aws-lambda esbuild
```

### tsconfig

tsconfig.json,tsconfig.paths.jsonを作成

### serverless.yml

serverless.ymlでイメージ指定

```bash
functions:
  hello:
    image: <your image uri>
    events:
    - httpApi:
        path: /hello
        method: GET
```

