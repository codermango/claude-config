#!/bin/bash

# Claude Code 配置安装脚本
# 用途：将 CLAUDE.md 安装到全局 Claude 配置目录

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 配置目录和文件
CLAUDE_DIR="$HOME/.claude"
SOURCE_FILE="./CLAUDE.md"
TARGET_FILE="$CLAUDE_DIR/CLAUDE.md"
BACKUP_FILE="$CLAUDE_DIR/CLAUDE.md.backup"

echo "======================================"
echo "  Claude Code 配置安装脚本"
echo "======================================"
echo ""

# 检查源文件是否存在
if [ ! -f "$SOURCE_FILE" ]; then
    echo -e "${RED}错误: 找不到 CLAUDE.md 文件${NC}"
    echo "请确保在 claude-config 仓库根目录下运行此脚本"
    exit 1
fi

# 创建配置目录（如果不存在）
if [ ! -d "$CLAUDE_DIR" ]; then
    echo -e "${YELLOW}创建 Claude 配置目录: $CLAUDE_DIR${NC}"
    mkdir -p "$CLAUDE_DIR"
fi

# 如果目标文件已存在，创建备份
if [ -f "$TARGET_FILE" ]; then
    echo -e "${YELLOW}检测到已存在的配置文件${NC}"
    echo -n "是否备份现有配置? [Y/n] "
    read -r response
    response=${response:-Y}

    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        TIMESTAMP=$(date +%Y%m%d_%H%M%S)
        BACKUP_FILE="$CLAUDE_DIR/CLAUDE.md.backup.$TIMESTAMP"
        cp "$TARGET_FILE" "$BACKUP_FILE"
        echo -e "${GREEN}✓ 已备份到: $BACKUP_FILE${NC}"
    fi
fi

# 复制配置文件
echo -e "${YELLOW}正在安装配置文件...${NC}"
cp "$SOURCE_FILE" "$TARGET_FILE"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ 配置文件安装成功!${NC}"
    echo ""
    echo "配置文件位置: $TARGET_FILE"
    echo ""
    echo "后续步骤:"
    echo "1. 查看并编辑配置文件: nano $TARGET_FILE"
    echo "2. 根据你的偏好调整配置内容"
    echo "3. 在新的 Claude Code 会话中配置将自动生效"
    echo ""
    echo -e "${YELLOW}提示: 项目级配置可以通过在项目根目录创建 .claude/CLAUDE.md 来覆盖全局配置${NC}"
else
    echo -e "${RED}✗ 安装失败${NC}"
    exit 1
fi

echo ""
echo "======================================"
echo "安装完成!"
echo "======================================"
