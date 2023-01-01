# README

本项目旨在为原项目提供一个简单的 Docker 部署方式，方便大家使用。

原项目地址：[lss233/chatgpt-mirai-qq-bot](https://github.com/lss233/chatgpt-mirai-qq-bot)

## 安装 Docker & Compose

- [获取 Docker 桌面版 (已包含 Compose)](https://docs.docker.com/get-docker/)
- [中文站](https://dockerdocs.cn/get-docker/index.html)
- [服务器安装 Docker](https://docs.docker.com/engine/install/)

## 获取本项目

`git clone https://github.com/paradox8599/mirai-chatgpt-setup.git`

## 编译镜像

> 通常情况下可跳过此步骤，第一次运行会自动编译。
> 但当项目有更新时，可能有必要跟随此步骤重新编译打包镜像。

输入命令 `docker compose build` 编译所有镜像。

也可分别编译：

- `docker compose build mirai`: 单独编译 Mirai
- `docker compose build chatgpt`: 单独编译 chatgpt bot
- `docker compose build setup`: 单独编译生成配置文件用的镜像

> **Apt 镜像源**: 如果你因为在国内导致 build chatgpt 镜像时过慢或失败，可以在 [`_chatgpt.Dockerfile`](https://github.com/paradox8599/mirai-chatgpt-setup/blob/main/_chatgpt.Dockerfile#:~:text=ARG%20TSINGHUA_SOURCE=false) 中将 `TSINGHUA_SOURCE` 设置为 `true`，以使用清华大学的镜像源。

## 配置账号

打开本项目中的 [`docker-compose.yaml`](https://github.com/paradox8599/mirai-chatgpt-setup/blob/main/docker-compose.yaml)， 填入账号信息。

其中只包含启动的必要参数，更多参数配置请参照[原项目](https://github.com/lss233/chatgpt-mirai-qq-bot)的说明。
相关配置可在生成的 `chatgpt` 目录中找到。

- [QQ](https://github.com/paradox8599/mirai-chatgpt-setup/blob/main/docker-compose.yaml#:~:text=QQ%20%E8%B4%A6%E5%8F%B7): QQ账号
- [QQ_PASS](https://github.com/paradox8599/mirai-chatgpt-setup/blob/main/docker-compose.yaml#:~:text=QQ%20%E5%AF%86%E7%A0%81) : QQ密码
- [DEVICE](https://github.com/paradox8599/mirai-chatgpt-setup/blob/main/docker-compose.yaml#:~:text=%E4%BC%AA%E8%A3%85%E7%99%BB%E5%BD%95%E8%AE%BE%E5%A4%87)：设备协议，如果登录失败请尝试更换
- [SESSION_TOKEN](https://github.com/paradox8599/mirai-chatgpt-setup/blob/main/docker-compose.yaml#:~:text=OpenAI%20session%20token) : OpenAI Sesson token
- [API_KEY](https://github.com/paradox8599/mirai-chatgpt-setup/blob/main/docker-compose.yaml#:~:text=API%20KEY): （可选）任意字符串

填写后，运行以下命令生成配置文件

`docker compose run --rm setup`

### 如何获取 OpenAI Session Token

1. 用Chrome浏览器访问 [OpenAI ChatGPT](https://chat.openai.com/chat) 并登录
2. 按下 `F12` 打开开发者工具，切换到 `Application` 标签
3. 在左侧 `Storage` 菜单中找到 `Cookies` 并展开，选中 `https://chat.openai.com`
4. 找到 `Name` 为 `__Secure-next-auth.session-token` 的一项，复制 `Value` 的值

> - 请注意，此值为 `__Secure-next-auth.session-token` 的 `Value`，而不是 `__Secure-next-auth.callback-url` 或 `__Host-next-auth.csrf-token` 的 `Value`。
> - 已知此值以 `ey` 开头

## 配置 Mirai

`docker compose run --rm mirai setup`

用以上命令启动 Mirai 进行安装，并按照提示操作登录。

当出现 `Login successful.` 时，说明登录成功，输入 `stop` 或 `Ctrl + C` 退出。

## 启动

`docker compose up` 将在前台启动；

`docker compose up -d` 将在后台启动。

如果出现 `Websocket reconnecting in 5s...` 的提示，如果 `mirai-chatgpt-setup-mirai-1` 有在正常运行，请不要担心，这是因为 Mirai 主程序还未启动完毕，等待一段时间即可。
