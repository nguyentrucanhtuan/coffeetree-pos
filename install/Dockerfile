FROM python:3.12-slim

ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        git \
        ca-certificates \
        curl \
        wget \
        gnupg \
        npm \
        node-less \
        libpq-dev \
        postgresql-client \
        gcc \
        g++ \
        libxml2-dev \
        libxslt1-dev \
        libjpeg-dev \
        libffi-dev \
        libldap2-dev \
        libsasl2-dev \
        libssl-dev \
        fonts-noto-cjk \
        libnss3 \
        libatk1.0-0 \
        libatk-bridge2.0-0 \
        libcups2 \
        libdrm2 \
        libxkbcommon0 \
        libxcomposite1 \
        libxdamage1 \
        libxfixes3 \
        libxrandr2 \
        libgbm1 \
        libasound2 \
    && rm -rf /var/lib/apt/lists/*

# Install wkhtmltopdf (PDF reports)
RUN wget -q https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-3/wkhtmltox_0.12.6.1-3.bookworm_amd64.deb \
    && dpkg -i wkhtmltox_0.12.6.1-3.bookworm_amd64.deb || apt-get install -fy \
    && rm wkhtmltox_0.12.6.1-3.bookworm_amd64.deb \
    && rm -rf /var/lib/apt/lists/*

# Install rtlcss
RUN npm install -g rtlcss

# Clone Odoo source từ repo của bạn
RUN git clone https://github.com/nguyentrucanhtuan/coffeetree-pos.git \
        --branch 19.0 \
        --depth 1 \
        /opt/odoo

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r /opt/odoo/requirements.txt

# Create necessary directories & odoo user
RUN useradd -m -d /home/odoo -s /bin/bash odoo \
    && mkdir -p /var/lib/odoo /mnt/custom_addons \
    && chown -R odoo:odoo /opt/odoo /var/lib/odoo /mnt/custom_addons

USER odoo

EXPOSE 8069 8072

CMD ["/opt/odoo/odoo-bin", \
     "--db_host=db", \
     "--db_port=5432", \
     "--db_user=coffeetree", \
     "--db_password=coffeetree", \
     "--addons-path=/opt/odoo/addons,/mnt/custom_addons", \
     "--data-dir=/var/lib/odoo"]
