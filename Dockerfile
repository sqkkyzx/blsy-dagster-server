FROM python:3.14-slim

ENV DAGSTER_HOME=/opt/dagster/dagster_home/ \
    PYTHONUNBUFFERED=1

RUN pip install --no-cache-dir --upgrade pip uv

WORKDIR $DAGSTER_HOME

COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh
COPY pyproject.toml uv.lock* default-config/ ./

RUN uv pip install --system --no-cache-dir --no-verify-hashes .

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["webserver"]