# README

> **当前不可用，等待修复**

本项目旨在为原项目提供一个简单的 Docker 部署方式，方便大家使用。

原项目地址：[lss233/chatgpt-mirai-qq-bot](https://github.com/lss233/chatgpt-mirai-qq-bot)

## 1. 安装 Docker & Composer

- [获取 Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## 2. 配置账号

### 2.1 修改配置文件

打开 `Dockerfile`， 修改文件开头用`ARG`声明的账号信息。

以下为启动的必要参数，更多参数配置请参照[原项目](https://github.com/lss233/chatgpt-mirai-qq-bot)的说明。

- `QQ`: QQ账号
- `QQ_PASS`: QQ密码
- `OPENAI_EMAIL`: OpenAI账号邮箱
- `OPENAI_PASS`: OpenAI密码
- `API_KEY`: （可选）任意字符串

### 2.2 运行配置脚本

`docker compose run --rm setup`

## 3. 配置 Mirai

`docker compose run --rm mirai`

用以上命令启动 Mirai，然后按照提示操作。

当出现 `Login successful.` 时，说明配置成功，按 `Ctrl+C` 退出。

## 4. 启动

`docker compose up` 将在前台启动；

`docker compose up -d` 将在后台启动。
