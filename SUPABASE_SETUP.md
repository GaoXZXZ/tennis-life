# 云同步一次性配置

应用已经具备自动云同步能力，但首次使用前需要创建自己的 Supabase 项目并初始化数据库。

1. 在 [Supabase Dashboard](https://supabase.com/dashboard) 创建一个项目。
2. 打开项目的 **SQL Editor**，新建查询，将 [`supabase-schema.sql`](./supabase-schema.sql) 的全部内容粘贴并运行。
3. 在 **Authentication → URL Configuration** 中把 Site URL 设置为：
   `https://gaoxzxz.github.io/tennis-life/`
4. 在 **Project Settings → API** 复制：
   - Project URL
   - Publishable key（旧项目可使用 anon key）

切勿使用或分享 `service_role` key。

然后在手机 App 的“我的 → 云同步”中：

1. 点“连接云数据库”，填写 Project URL 与 Publishable / anon key。
2. 点“创建同步账号”，用邮箱和密码注册；若启用了邮箱验证，完成验证后再点“同步账号”登录。
3. 登录成功即会首次同步。以后打开 App 会自动恢复会话、拉取云端数据，并上传本机新修改。

安全设计：表启用了 Row Level Security；每条数据按登录用户的 `auth.uid()` 隔离。项目的 Publishable / anon key 可以在客户端使用，但 `service_role` key 只能保留在服务端。
