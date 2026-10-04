#!/usr/bin/env bash
set -Eeuo pipefail

# check-version.sh 在实际发布前确认标签仍指向本次构建提交。
# 标签分支来源和版本号形状由 release.yml 的触发规则决定，这里不再限制最高版本。
expected_tag="${1:?用法：check-version.sh <tag> <sha>}"
expected_sha="${2:?用法：check-version.sh <tag> <sha>}"
actual_sha="$(git rev-list -n 1 "$expected_tag")"
if [ "$actual_sha" != "$expected_sha" ]; then
  echo "标签 $expected_tag 未指向构建提交。" >&2
  exit 1
fi
