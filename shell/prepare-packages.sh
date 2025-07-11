#!/bin/sh

BASE_DIR="extra-packages"
TEMP_DIR="$BASE_DIR/temp-unpack"
TARGET_DIR="packages"

# 清理旧的临时解压目录和 packages 目录
rm -rf "$TEMP_DIR" "$TARGET_DIR"
mkdir -p "$TEMP_DIR" "$TARGET_DIR"

# 遍历 extra-packages 下的所有 .run 文件
for run_file in "$BASE_DIR"/*.run; do
    [ -e "$run_file" ] || continue
    echo "🧩 解压 $run_file -> $TEMP_DIR"
    sh "$run_file" --target "$TEMP_DIR" --noexec
done

# 收集所有解压出的 .ipk 文件
find "$TEMP_DIR" -type f -name "*.ipk" -exec cp {} "$TARGET_DIR"/ \;

# 拷贝 extra-packages 所有 .ipk 文件
find "$BASE_DIR" -maxdepth 1 -type f -name "*.ipk" -exec cp {} "$TARGET_DIR"/ \;

echo "✅ 所有 .ipk 已整理至 $TARGET_DIR/"


