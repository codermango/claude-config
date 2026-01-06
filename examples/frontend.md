# 前端项目配置示例

> 这是一个前端项目（React + TypeScript）的 Claude Code 配置示例

## 项目信息

- **技术栈**: React + TypeScript + Vite
- **状态管理**: Zustand / Redux Toolkit
- **样式方案**: Tailwind CSS / CSS Modules
- **测试框架**: Vitest + React Testing Library

## 代码风格

### 组件规范
- 优先使用函数式组件和 Hooks
- 组件文件使用 PascalCase 命名：`UserProfile.tsx`
- 自定义 Hooks 使用 `use` 前缀：`useUserData.ts`
- 每个组件放在独立目录，包含 index.tsx、styles 和 tests

```
components/
└── UserProfile/
    ├── index.tsx
    ├── UserProfile.module.css
    └── UserProfile.test.tsx
```

### TypeScript 规范
- 为所有 props 定义接口
- 使用 `type` 定义联合类型，使用 `interface` 定义对象结构
- 避免使用 `any`，必要时使用 `unknown`
- 使用严格模式（strict: true）

### 导入顺序
```typescript
// 1. 第三方库
import React, { useState } from 'react'
import { useQuery } from '@tanstack/react-query'

// 2. 绝对路径导入（别名）
import { Button } from '@/components/ui'
import { useAuth } from '@/hooks'

// 3. 相对路径导入
import { UserCard } from '../UserCard'
import styles from './UserProfile.module.css'
```

## 项目结构

```
src/
├── components/       # 可复用组件
│   ├── ui/          # 基础 UI 组件
│   └── features/    # 业务组件
├── pages/           # 页面组件
├── hooks/           # 自定义 Hooks
├── stores/          # 状态管理
├── utils/           # 工具函数
├── types/           # 类型定义
├── services/        # API 服务
├── assets/          # 静态资源
└── tests/           # 测试工具和配置
```

## 特殊要求

### 性能优化
- 使用 React.memo() 优化重渲染
- 使用 useMemo 和 useCallback 缓存计算和函数
- 使用 lazy() 和 Suspense 进行代码分割
- 图片使用懒加载

### 可访问性
- 为交互元素添加 aria-label
- 确保键盘可访问性
- 使用语义化 HTML 标签
- 确保足够的颜色对比度

### 错误处理
- 使用 Error Boundary 捕获组件错误
- API 错误显示用户友好的提示
- 表单验证提供清晰的错误信息

## 命名约定

- **组件**: PascalCase - `UserProfile`, `NavBar`
- **函数**: camelCase - `getUserData`, `handleClick`
- **常量**: UPPER_SNAKE_CASE - `API_BASE_URL`, `MAX_RETRIES`
- **类型/接口**: PascalCase - `UserData`, `ApiResponse`
- **CSS 类**: kebab-case - `user-profile`, `nav-bar`

## Git 提交类型

- `feat`: 新功能（新组件、新页面）
- `fix`: 修复 bug
- `style`: 样式调整（CSS、UI 优化）
- `refactor`: 重构组件
- `perf`: 性能优化
- `test`: 测试相关
- `chore`: 构建工具、依赖更新

## 示例提交信息

```
feat: 添加用户个人资料页面

- 实现用户信息展示
- 添加头像上传功能
- 集成表单验证

🤖 Generated with Claude Code
Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```
