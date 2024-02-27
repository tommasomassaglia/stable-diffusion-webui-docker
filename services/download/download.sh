#!/usr/bin/env bash

set -Eeuo pipefail

# TODO: maybe just use the .gitignore file to create all of these
mkdir -vp /data/.cache \
  /data/embeddings \
  /data/config/ \
  /data/models/ \
  /data/models/Stable-diffusion \
  /data/models/GFPGAN \
  /data/models/RealESRGAN \
  /data/models/LDSR \
  /data/models/VAE \
  /data/models/Lora \
  /data/models/ControlNet

cp /data/styles.csv /data/config/auto/styles.csv

echo "Downloading, this might take a while..."

aria2c -x 10 --disable-ipv6 --input-file /docker/links.txt --dir /data --continue

# CN_DIR=/data/config/auto/extensions/sd-webui-controlnet
# git -C "$CN_DIR" pull || git clone https://github.com/Mikubill/sd-webui-controlnet "$CN_DIR"

PL_DIR=/data/config/auto/extensions/sd-webui-api-payload-display
git -C "$PL_DIR" pull || git clone https://github.com/huchenlei/sd-webui-api-payload-display "$PL_DIR"

aria2c -x 10 --disable-ipv6 --input-file /docker/controlnet_links.txt --dir /data/models/ControlNet --continue