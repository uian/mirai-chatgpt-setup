# README

本项目旨在为原项目提供一个简单的 Docker 部署方式，方便大家使用。

下述命令均在项目根目录下执行。

原项目地址：[lss233/chatgpt-mirai-qq-bot](https://github.com/lss233/chatgpt-mirai-qq-bot)

## 1. 安装 Docker & Compose

- [获取 Docker 桌面版 (已包含 Compose)](https://docs.docker.com/get-docker/)
- [中文站](https://dockerdocs.cn/get-docker/index.html)

## 2. 配置账号

下载这个 repo 的文件

`git clone https://github.com/paradox8599/mirai-chatgpt-setup.git`

`cd mirai-chatgpt-setup`

打开本 repo 中的 `docker-compose.yaml`， 填入账号信息。

其中只包含启动的必要参数，更多参数配置请参照[原项目](https://github.com/lss233/chatgpt-mirai-qq-bot)的说明。

- `QQ`: QQ账号
- `QQ_PASS`: QQ密码
- `SESSION_TOKEN`: OpenAI Sesson token
- `API_KEY`: （可选）任意字符串

填写后，运行以下命令生成配置文件

`docker compose run --rm setup`

### 如何获取 OpenAI Session Token

1. 用Chrome浏览器访问 [OpenAI ChatGPT](https://chat.openai.com/chat) 并登录
2. 按下 `F12` 打开开发者工具，切换到 `Application` 标签
3. 在左侧 `Storage` 菜单中找到 `Cookies` 并展开，选中 `https://chat.openai.com`
4. 找到 `Name` 为 `__Secure-next-auth.session-token` 的一项，复制 `Value` 的值

> - 请注意，此值为 `__Secure-next-auth.session-token` 的 `Value`，而不是 `__Secure-next-auth.callback-url` 或 `__Host-next-auth.csrf-token` 的 `Value`。
> - 已知此值以 `ey` 开头

## 3. 配置 Mirai

`docker compose run --rm mirai setup`

用以上命令启动 Mirai 进行安装，并按照提示操作登录。

当出现 `Login successful.` 时，说明登录成功，输入 `stop` 或 `Ctrl + C` 退出。

## 4. 启动

`docker compose up` 将在前台启动；

`docker compose up -d` 将在后台启动。

如果出现 `Websocket reconnecting in 5s...` 的提示，请不要担心，这是因为 Mirai 主程序还未启动完毕，等待一段时间即可。
