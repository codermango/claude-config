# 全栈项目配置示例

> 这是一个全栈项目的 Claude Code 配置示例

## 项目信息

- **前端**: React + TypeScript + Vite
- **后端**: Node.js + TypeScript + Express
- **数据库**: PostgreSQL + Prisma
- **部署**: Docker + Docker Compose

## Monorepo 结构

```
project/
├── apps/
│   ├── web/              # 前端应用
│   │   ├── src/
│   │   ├── public/
│   │   └── package.json
│   └── api/              # 后端应用
│       ├── src/
│       ├── prisma/
│       └── package.json
├── packages/
│   ├── shared/           # 共享代码
│   │   ├── types/        # 共享类型定义
│   │   ├── utils/        # 共享工具函数
│   │   └── constants/    # 共享常量
│   └── ui/              # 共享 UI 组件（可选）
├── docker/              # Docker 配置
├── scripts/             # 脚本文件
└── package.json         # 根 package.json
```

## 工作空间配置

### 使用 pnpm workspace（推荐）

```yaml
# pnpm-workspace.yaml
packages:
  - 'apps/*'
  - 'packages/*'
```

### 依赖管理
- 共享依赖安装在根目录
- 特定依赖安装在各自的应用中
- 使用 workspace protocol 引用内部包

## 类型共享

### 共享类型定义
在 `packages/shared/types` 中定义前后端共享的类型：

```typescript
// packages/shared/types/user.ts
export interface User {
  id: string
  email: string
  username: string
  createdAt: Date
  updatedAt: Date
}

export interface CreateUserDto {
  email: string
  username: string
  password: string
}

export interface ApiResponse<T> {
  success: boolean
  data?: T
  error?: {
    code: string
    message: string
  }
}
```

### 在前后端使用
```typescript
// 后端
import { User, CreateUserDto } from '@project/shared'

// 前端
import { User, ApiResponse } from '@project/shared'
```

## API 接口规范

### RESTful API 设计
```
GET    /api/users          # 获取用户列表
GET    /api/users/:id      # 获取单个用户
POST   /api/users          # 创建用户
PUT    /api/users/:id      # 更新用户
DELETE /api/users/:id      # 删除用户
```

### 前端 API 客户端
```typescript
// apps/web/src/services/api.ts
import axios from 'axios'
import type { User, ApiResponse } from '@project/shared'

const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL,
  timeout: 10000,
})

export const userApi = {
  getUsers: () => api.get<ApiResponse<User[]>>('/users'),
  getUser: (id: string) => api.get<ApiResponse<User>>(`/users/${id}`),
  createUser: (data: CreateUserDto) => api.post<ApiResponse<User>>('/users', data),
}
```

## 环境变量管理

### 前端环境变量
```bash
# apps/web/.env
VITE_API_URL=http://localhost:3000/api
VITE_APP_NAME=MyApp
```

### 后端环境变量
```bash
# apps/api/.env
NODE_ENV=development
PORT=3000
DATABASE_URL=postgresql://user:password@localhost:5432/mydb
JWT_SECRET=your-secret-key
CORS_ORIGIN=http://localhost:5173
```

## Docker 配置

### docker-compose.yml
```yaml
version: '3.8'

services:
  postgres:
    image: postgres:15
    environment:
      POSTGRES_DB: mydb
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  api:
    build:
      context: .
      dockerfile: docker/api.Dockerfile
    ports:
      - "3000:3000"
    environment:
      DATABASE_URL: postgresql://user:password@postgres:5432/mydb
    depends_on:
      - postgres

  web:
    build:
      context: .
      dockerfile: docker/web.Dockerfile
    ports:
      - "5173:5173"
    environment:
      VITE_API_URL: http://localhost:3000/api

volumes:
  postgres_data:
```

## 开发工作流

### 本地开发
```bash
# 安装依赖
pnpm install

# 启动数据库
docker-compose up -d postgres

# 运行数据库迁移
pnpm --filter api prisma:migrate

# 并行启动前后端
pnpm dev

# 或分别启动
pnpm --filter web dev
pnpm --filter api dev
```

### 测试
```bash
# 运行所有测试
pnpm test

# 运行特定应用的测试
pnpm --filter api test
pnpm --filter web test
```

## 代码组织原则

### 前端特定规范
- 参考 [frontend.md](./frontend.md)
- API 调用统一在 `services/` 目录
- 使用 React Query 管理服务端状态

### 后端特定规范
- 参考 [backend.md](./backend.md)
- 使用 DTO 验证请求数据
- 实现统一的错误处理

### 共享代码规范
- 只放置真正需要共享的代码
- 避免循环依赖
- 提供清晰的导出接口

## 数据库管理

### Prisma Schema
```prisma
// apps/api/prisma/schema.prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

model User {
  id        String   @id @default(uuid())
  email     String   @unique
  username  String   @unique
  password  String
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
}
```

### 数据库迁移
```bash
# 创建迁移
pnpm --filter api prisma migrate dev --name add_user_model

# 应用迁移
pnpm --filter api prisma migrate deploy

# 生成 Prisma Client
pnpm --filter api prisma generate
```

## 部署

### 构建生产版本
```bash
# 构建所有应用
pnpm build

# 构建特定应用
pnpm --filter web build
pnpm --filter api build
```

### 使用 Docker 部署
```bash
# 构建镜像
docker-compose build

# 启动服务
docker-compose up -d

# 查看日志
docker-compose logs -f
```

## Git 工作流

### 分支策略
- `main`: 生产环境
- `develop`: 开发环境
- `feature/*`: 功能分支
- `fix/*`: 修复分支

### 提交信息格式
```
<类型>(<范围>): <描述>

类型: feat, fix, refactor, test, docs, chore
范围: web, api, shared, 或具体模块名

示例:
feat(api): 添加用户认证接口
fix(web): 修复登录表单验证问题
refactor(shared): 重构 API 类型定义
```

## 最佳实践

1. **类型安全**: 充分利用 TypeScript，前后端共享类型定义
2. **代码复用**: 将可复用的代码提取到 `packages/shared`
3. **API 契约**: 使用共享类型确保前后端 API 契约一致
4. **环境隔离**: 使用不同的环境变量文件管理不同环境
5. **自动化**: 使用脚本自动化常见任务（构建、测试、部署）
6. **文档**: 在 README 中记录项目结构和开发流程
