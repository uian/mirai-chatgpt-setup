FROM python:3.9-slim

ARG BOT_URL=https://github.com/lss233/chatgpt-mirai-qq-bot
ARG BOT_PATH=/app

WORKDIR $BOT_PATH

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt install software-properties-common apt-transport-https wget ca-certificates gnupg2 -yq && \
    wget -qO /usr/share/keyrings/xpra-2022.gpg https://xpra.org/xpra-2022.gpg  && \
    echo deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/xpra-2022.gpg] https://xpra.org/ bullseye main |  tee /etc/apt/sources.list.d/xpra.list && \
    apt-get update && \
    apt install --no-install-recommends xpra xvfb libgl1-mesa-dri xauth -yq

RUN set -eux; \
    apt-get clean; \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/*

RUN pip install playwright && \
    playwright install && \
    playwright install-deps

RUN apt-get install git -yq && \
    git clone $BOT_URL . && \
    pip install -r requirements.txt

RUN cp docker/xpra.conf /etc/xpra/xpra.conf
RUN cp docker/start.sh ./start && chmod +x start

CMD /app/start
