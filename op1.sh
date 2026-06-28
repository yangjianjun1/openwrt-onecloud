#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-op1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# 查看所有标签
#git tag
# 切换到标签 v24.10.7
git checkout v24.10.7

# 全部改为稳定的 github 源
sed -i 's|https://git.openwrt.org/feed/packages.git|https://github.com/openwrt/packages.git|g' feeds.conf.default
sed -i 's|https://git.openwrt.org/project/luci.git|https://github.com/openwrt/luci.git|g' feeds.conf.default
sed -i 's|https://git.openwrt.org/feed/routing.git|https://github.com/openwrt/routing.git|g' feeds.conf.default
sed -i 's|https://git.openwrt.org/feed/telephony.git|https://github.com/openwrt/telephony.git|g' feeds.conf.default

# 添加 lienol 大的 package
echo 'src-git lienol https://github.com/Lienol/openwrt-package.git;main' >>feeds.conf.default
# ========== 新增 Dockerman 依赖源 ==========
# Dockerman主程序
grep -q "dockerman" feeds.conf.default || echo "src-git dockerman https://github.com/lisaac/luci-app-dockerman.git" >> feeds.conf.default
# Docker依赖库 luci-lib-docker
grep -q "dockermanlib" feeds.conf.default || echo "src-git dockermanlib https://github.com/lisaac/luci-lib-docker.git" >> feeds.conf.default

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
