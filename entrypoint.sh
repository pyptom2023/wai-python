#!/usr/bin/env bash
base64 -d config > config.json
VMESS_WSPATH=${VMESS_WSPATH:-'/vmess'}
VLESS_WSPATH=${VLESS_WSPATH:-'/vless'}
UUID=${UUID:-'8c94dfd8-52dd-451c-8c85-26770cd41768'}
sed -i "s#UUID#$UUID#g;s#VMESS_WSPATH#${VMESS_WSPATH}#g;s#VLESS_WSPATH#${VLESS_WSPATH}#g" config.json

# wget -O temp.zip https://github.com/v2fly/v2ray-core/releases/download/v4.45.0/v2ray-linux-64.zip &&\
unzip temp.zip v2ray

# 伪装 v2ray 执行文件
RELEASE_RANDOMNESS=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 6)
mv v2ray ${RELEASE_RANDOMNESS}
cat config.json | base64 > config
rm -f config.json

base64 -d config > config.json
# ./${RELEASE_RANDOMNESS} -config=config.json
cp conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
sed -i "s#replace#${RELEASE_RANDOMNESS}#g" /etc/supervisor/conf.d/supervisord.conf

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
