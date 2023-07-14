ARG DBT_CORE_VERSION=latest
FROM ghcr.io/dbt-labs/dbt-core:${DBT_CORE_VERSION}

RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        netcat \
        curl \
        git \
        ssh \
        make \
        gnupg2 \
        build-essential \
        ca-certificates \
        libpq-dev \
        libsasl2-dev \
        libsasl2-2 \
        libsasl2-modules-gssapi-mit \
        libyaml-dev \
        openssl \
        libffi-dev \
        ca-certificates \
        iputils-ping \
    && curl -s https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl -s https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql18 unixodbc-dev \
    && python -m pip install --no-cache-dir "git+https://github.com/dbeatty10/dbt-mysql.git" \
    && python -m pip install --no-cache-dir "git+https://github.com/dbt-msft/dbt-sqlserver.git"