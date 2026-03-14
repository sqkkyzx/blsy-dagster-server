FROM sqkkyzx/blsy-dagster-server:latest

ADD https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/v0.4.41/grpc_health_probe-linux-amd64 /bin/grpc_health_probe
RUN chmod +x /bin/grpc_health_probe

# 安装 ffmpeg 和相关解码器
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    libavcodec-extra \
    && rm -rf /var/lib/apt/lists/*

# 升级 pip 和 uv
RUN pip install --no-cache-dir --upgrade pip && pip install --no-cache-dir --upgrade uv

# 其他软件包
RUN uv pip install --system --no-cache-dir --upgrade \
    psycopg[binary]  \
    colorama  \
    orjson  \
    portalocker  \
    playwright==1.54.0  \
    markitdown  \
    lxml  \
    openpyxl  \
    pycron  \
    py-grafana-render==0.1.11 \
    opencv-contrib-python \
    loguru \
    pydantic \
    smbprotocol \
    dagster-qcloud-cos \
    dagster-dingtalk \
    dagster-dify==0.27.15.1

EXPOSE 4000

WORKDIR /opt/dagster/dagster_home/code/
ENTRYPOINT ["dagster", "code-server", "start", "-h", "0.0.0.0", "-p", "4000"]
CMD ["-f", "definitions.py"]
