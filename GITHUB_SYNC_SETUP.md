# GitHub 自动同步：只需做一次

GitHub 继续负责发布 App；另建一个 **私有仓库** 专门保存你的网球记录。

## 1. 创建私有数据仓库

1. 打开 GitHub，右上角 `+` → **New repository**。
2. 仓库名填 `tennis-life-data`。
3. Visibility 选择 **Private**。
4. 不勾选 README、`.gitignore` 或 License，点击 **Create repository**。

## 2. 创建细粒度令牌

GitHub 头像 → **Settings** → **Developer settings** → **Personal access tokens** → **Fine-grained tokens** → **Generate new token**。

按下面选：

- Token name：`Tennis Life Sync`
- Expiration：建议 90 天或更短
- Resource owner：选择你自己
- Repository access：选择 **Only select repositories**，只勾选 `tennis-life-data`
- Repository permissions → **Contents**：选择 **Read and write**

生成后复制令牌。它只会显示这一次：不要发到聊天里，也不要提交到 GitHub。

## 3. 在 iPhone App 中开启

打开网球 App → **我的** → **GitHub 私有同步**，填写：

- 私有仓库：`GaoXZXZ/tennis-life-data`
- 细粒度令牌：刚刚复制的令牌

保存后会立即同步。以后每次打开 App，以及每次新增、修改或删除记录后，都会自动同步。

令牌只保存在这台设备的浏览器存储中。若手机遗失或不再使用，在 GitHub 的 Fine-grained tokens 页面撤销该令牌即可。
