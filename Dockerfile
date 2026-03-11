FROM python:3.12-slim

SHELL ["/bin/bash", "-xo", "pipefail", "-c"]

# Generate locale
ENV LANG=C.UTF-8

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        dirmngr \
        fonts-noto-cjk \
        gnupg \
        libssl-dev \
        node-less \
        npm \
        python3-magic \
        python3-num2words \
        python3-odf \
        python3-pdfminer \
        python3-pip \
        python3-phonenumbers \
        python3-pyldap \
        python3-qrcode \
        python3-renderpm \
        python3-setuptools \
        python3-slugify \
        python3-vobject \
        python3-watchdog \
        python3-xlrd \
        python3-xlwt \
        xz-utils \
        # PostgreSQL client
        libpq-dev \
        postgresql-client \
        # Build tools
        gcc \
        g++ \
        libxml2-dev \
        libxslt1-dev \
        libjpeg-dev \
        libffi-dev \
        libldap2-dev \
        libsasl2-dev \
        # wkhtmltopdf dependencies
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
        wget \
    && rm -rf /var/lib/apt/lists/*

# Install wkhtmltopdf (for PDF reports)
RUN wget -q https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-3/wkhtmltox_0.12.6.1-3.bookworm_amd64.deb \
    && dpkg -i wkhtmltox_0.12.6.1-3.bookworm_amd64.deb || apt-get install -fy \
    && rm wkhtmltox_0.12.6.1-3.bookworm_amd64.deb

# Install rtlcss (for RTL language support)
RUN npm install -g rtlcss

# Create odoo user
RUN useradd -m -d /home/odoo -s /bin/bash odoo

# Set working directory
WORKDIR /opt/odoo

# Copy source code
COPY --chown=odoo:odoo . /opt/odoo

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r /opt/odoo/requirements.txt

# Create necessary directories
RUN mkdir -p /var/lib/odoo /mnt/custom_addons /mnt/conf \
    && chown -R odoo:odoo /var/lib/odoo /mnt/custom_addons /mnt/conf

# Switch to odoo user
USER odoo

# Expose ports
EXPOSE 8069 8072

# Default config file
ENV ODOO_RC=/mnt/conf/odoo.conf

# Entrypoint
CMD ["/opt/odoo/odoo-bin", "--config=/mnt/conf/odoo.conf"]
