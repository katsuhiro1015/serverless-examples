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
sls create --template aws-nodejs-typescript --name example-app --path example-app
```

## test

```bash
yarn sls deploy
```

別のターミナルを開いて

```bash
yarn sls invoke local -f hello --path src/functions/hello/mock.json
```