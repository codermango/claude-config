# Claude Code 配置仓库

这是我的 Claude Code 配置管理仓库，用于存储和同步我在不同项目中使用 Claude Code 的个性化配置和偏好设置。

## 📁 仓库结构

```
claude-config/
├── CLAUDE.md              # 全局配置模板
├── README.md              # 说明文档（本文件）
├── install.sh             # 安装脚本
├── examples/              # 示例配置
│   ├── frontend.md        # 前端项目配置示例
│   ├── backend.md         # 后端项目配置示例
│   └── fullstack.md       # 全栈项目配置示例
└── templates/             # 项目模板
    └── project-claude.md  # 项目级配置模板
```

## 🚀 快速开始

### 安装全局配置

将配置文件安装到你的全局 Claude 配置目录（`~/.claude/`）：

```bash
./install.sh
```

或者手动复制：

```bash
# 创建 Claude 配置目录（如果不存在）
mkdir -p ~/.claude

# 复制配置文件
cp CLAUDE.md ~/.claude/CLAUDE.md
```

### 为新项目添加配置

在项目根目录创建 `.claude` 文件夹并添加项目特定配置：

```bash
# 在你的项目目录中
mkdir -p .claude
cp /path/to/claude-config/templates/project-claude.md .claude/CLAUDE.md
```

## 📝 配置说明

### 全局配置 vs 项目配置

- **全局配置** (`~/.claude/CLAUDE.md`): 适用于所有项目的通用设置
  - 语言偏好
  - 通用代码风格
  - Git 提交规范
  - 安全注意事项

- **项目配置** (`.claude/CLAUDE.md`): 针对特定项目的设置
  - 项目特定的技术栈
  - 项目结构
  - 特殊的代码风格要求
  - 项目特定的工作流程

### 配置优先级

项目级配置会覆盖全局配置。Claude Code 会按以下顺序读取配置：

1. 项目的 `.claude/CLAUDE.md`
2. 全局的 `~/.claude/CLAUDE.md`

## 🔧 自定义配置

### 修改全局配置

1. 编辑 [CLAUDE.md](CLAUDE.md) 文件
2. 运行 `./install.sh` 重新安装
3. 或者直接编辑 `~/.claude/CLAUDE.md`

### 创建项目配置

1. 从 `templates/` 目录选择合适的模板
2. 复制到项目的 `.claude/` 目录
3. 根据项目需求进行调整

## 📚 配置示例

查看 `examples/` 目录中的示例配置：

- [前端项目配置示例](examples/frontend.md)
- [后端项目配置示例](examples/backend.md)
- [全栈项目配置示例](examples/fullstack.md)

## 🔄 配置迁移

### 方法一：使用 Git 子模块

在新项目中添加此仓库作为子模块：

```bash
git submodule add <your-repo-url> .claude-config
ln -s .claude-config/templates/project-claude.md .claude/CLAUDE.md
```

### 方法二：使用软链接

```bash
# 克隆配置仓库到固定位置
git clone <your-repo-url> ~/claude-config

# 在新项目中创建软链接
mkdir -p .claude
ln -s ~/claude-config/CLAUDE.md ~/.claude/CLAUDE.md
```

### 方法三：使用脚本安装

```bash
# 克隆并安装
git clone <your-repo-url> ~/claude-config
cd ~/claude-config
./install.sh
```

## 📖 最佳实践

1. **保持配置简洁**：只添加真正需要的配置，避免过度配置
2. **定期更新**：随着工作流程的变化，及时更新配置
3. **使用版本控制**：通过 Git 管理配置变更历史
4. **文档化特殊配置**：为非标准配置添加注释说明原因
5. **团队共享**：可以将项目级配置提交到项目仓库，与团队共享

## 🛠️ 相关链接

- [Claude Code 官方文档](https://github.com/anthropics/claude-code)
- [Claude Code 最佳实践](https://docs.anthropic.com/claude-code/best-practices)

## 📄 许可证

MIT License - 根据需要自由使用和修改

---

**提示**：修改配置后，建议在新的对话中测试，以确保配置生效。
