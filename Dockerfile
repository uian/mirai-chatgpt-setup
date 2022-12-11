FROM alpine:latest

# QQ账号
ARG QQ=123456789

# QQ密码
ARG QQ_PASS=123456789

# OpenAI账号邮箱
ARG OPENAI_EMAIL=openai@exmaple.com

# OpenAI账号密码
ARG OPENAI_PASS=openaipass

# API KEY
ARG API_KEY=RandomAPIKey

RUN sh -c "\
mkdir -p /tmpapp/mirai/config/Console \
&& \
\
printf '\
accounts:\n\
  -\n\
    account: $QQ\n\
    password:\n\
      kind: PLAIN\n\
      value: $QQ_PASS\n\
    configuration:\n\
      protocol: ANDROID_PAD\n\
' > /tmpapp/mirai/config/Console/AutoLogin.yml \
&& \
\
mkdir -p /tmpapp/mirai/config/net.mamoe.mirai-api-http \
&& \
\
printf '\
adapters:\n\
  - http\n\
  - ws\n\
debug: true\n\
enableVerify: true\n\
verifyKey: $API_KEY\n\
singleMode: false\n\
cacheSize: 4096\n\
persistenceFactory: \"built-in\"\n\
adapterSettings:\n\
  ## HTTP 服务的主机, 端口和跨域设置\n\
  http:\n\
    host: mirai\n\
    port: 8080\n\
    cors: [\"*\"]\n\
  ## Websocket 服务的主机, 端口和事件同步ID设置\n\
  ws:\n\
    host: mirai\n\
    port: 8080\n\
    reservedSyncId: -1\n\
' > /tmpapp/mirai/config/net.mamoe.mirai-api-http/setting.yml \
&& \
\
touch /tmpapp/config.json \
&& \
\
printf '\
{\n\
    \"mirai\": {\n\
        \"qq\": $QQ,\n\
        \"api_key\": \"$API_KEY\",\n\
        \"http_url\": \"http://mirai:8080\",\n\
        \"ws_url\": \"http://mirai:8080\"\n\
    },\n\
    \"openai\": {\n\
        \"email\": \"$OPENAI_EMAIL\",\n\
        \"password\": \"$OPENAI_PASS\"\n\
    },\n\
    \"text_to_image\": {\n\
        \"font_size\": 30,\n\
        \"width\": 700,\n\
        \"font_path\": \"fonts/sarasa-mono-sc-regular.ttf\",\n\
        \"offset_x\": 50,\n\
        \"offset_y\": 50\n\
    }\n\
}\n\
' > /tmpapp/config.json \
"

CMD sh -c "\
mkdir -p /app/mirai/config/Console && \
mkdir -p /app/mirai/config/net.mamoe.mirai-api-http && \
cp /tmpapp/config.json /app/config.json && \
cp /tmpapp/mirai/config/Console/AutoLogin.yml /app/mirai/config/Console/AutoLogin.yml && \
cp /tmpapp/mirai/config/net.mamoe.mirai-api-http/setting.yml /app/mirai/config/net.mamoe.mirai-api-http/setting.yml"