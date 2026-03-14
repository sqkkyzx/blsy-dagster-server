# Dagster Runtime Base Image

基于 Python 3.13-slim 与 uv 构建的 Dagster 基础镜像。
通过 command 参数即可切换 webserver 或 daemon 模式。

### 🛠️ 环境变量
通过环境变量可灵活定义运行参数，无需重新构建镜像：

| 变量名                         | 默认值            | 描述             | 
|-----------------------------|----------------|----------------|
| DAGSTER_WEBSERVER_PORT      | 3000           | Webserver 监听端口 | 
| DAGSTER_WEBSERVER_WORKSPACE | workspace.yaml | Dagster 配置文件路径 |

### 📦 部署示例 (Docker Compose)

```YAML
services:
  # Dagster Web 界面
  webserver:
    image: ghcr.io/sqkkyzx/blsy-dagster-server:latest
    command: webserver
    ports:
      - "3000:3000"
    environment:
      - DAGSTER_WEBSERVER_PORT=3000
      - DAGSTER_WEBSERVER_WORKSPACE=workspace.yaml
    restart: always

  # Dagster 调度守护进程
  daemon:
    image: ghcr.io/sqkkyzx/blsy-dagster-server:latest
    command: daemon
    restart: always
```
