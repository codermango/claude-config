# 后端项目配置示例

> 这是一个后端项目（Node.js + TypeScript）的 Claude Code 配置示例

## 项目信息

- **技术栈**: Node.js + TypeScript + Express/Fastify
- **数据库**: PostgreSQL + Prisma / MongoDB + Mongoose
- **认证**: JWT + Passport.js
- **测试框架**: Jest + Supertest

## 代码风格

### API 设计规范
- 使用 RESTful API 风格
- 路由命名使用小写和连字符：`/api/user-profiles`
- HTTP 方法语义化：GET（查询）、POST（创建）、PUT/PATCH（更新）、DELETE（删除）
- 使用适当的 HTTP 状态码

### 目录结构
```
src/
├── controllers/     # 控制器（业务逻辑）
├── routes/          # 路由定义
├── models/          # 数据模型
├── services/        # 服务层（复杂业务逻辑）
├── middlewares/     # 中间件
├── utils/           # 工具函数
├── types/           # 类型定义
├── config/          # 配置文件
├── validators/      # 请求验证
└── tests/           # 测试文件
```

### 文件命名
- 控制器：`user.controller.ts`
- 路由：`user.routes.ts`
- 模型：`user.model.ts`
- 服务：`user.service.ts`
- 中间件：`auth.middleware.ts`

## 错误处理

### 统一错误格式
```typescript
{
  "success": false,
  "error": {
    "code": "USER_NOT_FOUND",
    "message": "用户不存在",
    "details": {}
  }
}
```

### 错误处理原则
- 使用自定义错误类
- 全局错误处理中间件
- 记录错误日志（使用 Winston/Pino）
- 不暴露敏感的错误信息给客户端

## 安全规范

### 必须实现的安全措施
- 输入验证和清理（使用 Joi/Zod）
- SQL 注入防护（使用参数化查询）
- XSS 防护（输出转义）
- CSRF 防护（对状态改变的操作）
- 速率限制（使用 express-rate-limit）
- Helmet.js 设置安全 HTTP 头

### 认证和授权
- 密码使用 bcrypt 加密（salt rounds >= 10）
- JWT token 设置合理过期时间
- 敏感操作需要二次验证
- 实现 RBAC（基于角色的访问控制）

## 数据库规范

### 查询优化
- 为常用查询字段添加索引
- 使用数据库连接池
- 避免 N+1 查询问题
- 大数据量使用分页

### 事务处理
- 涉及多表操作使用事务
- 设置合理的事务隔离级别
- 处理并发冲突

## 日志规范

### 日志级别
- `error`: 错误，需要立即处理
- `warn`: 警告，潜在问题
- `info`: 重要信息（如用户登录）
- `debug`: 调试信息

### 日志内容
- 包含时间戳、请求 ID、用户 ID
- 敏感信息（密码、token）不记录
- 错误日志包含堆栈信息

## API 响应格式

### 成功响应
```typescript
{
  "success": true,
  "data": {
    // 响应数据
  },
  "meta": {
    "page": 1,
    "limit": 20,
    "total": 100
  }
}
```

### 错误响应
```typescript
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "请求参数验证失败",
    "details": {
      "email": "邮箱格式不正确"
    }
  }
}
```

## 测试规范

### 测试覆盖
- 单元测试：工具函数、服务层
- 集成测试：API 端点
- 测试覆盖率目标：> 80%

### 测试命名
```typescript
describe('UserController', () => {
  describe('createUser', () => {
    it('应该成功创建用户', async () => {
      // 测试代码
    })

    it('应该在邮箱重复时返回错误', async () => {
      // 测试代码
    })
  })
})
```

## 环境变量

### 必需的环境变量
```bash
NODE_ENV=production
PORT=3000
DATABASE_URL=postgresql://...
JWT_SECRET=your-secret-key
REDIS_URL=redis://...
```

### 配置管理
- 使用 .env 文件（不提交到 Git）
- 提供 .env.example 模板
- 使用 dotenv-safe 验证必需变量

## Git 提交类型

- `feat`: 新功能（新接口、新功能）
- `fix`: 修复 bug
- `perf`: 性能优化
- `refactor`: 代码重构
- `test`: 测试相关
- `docs`: 文档更新
- `chore`: 依赖更新、配置修改

## 示例提交信息

```
feat: 添加用户注册接口

- 实现邮箱注册功能
- 添加邮箱验证
- 集成短信验证码
- 添加单元测试和集成测试

🤖 Generated with Claude Code
Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```
