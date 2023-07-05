FROM python:3.7-slim-bullseye

WORKDIR /sirius

RUN apt-get update -y && \
  mkdir -p /usr/share/man/man1 && \
  mkdir -p /usr/share/man/man7 && \
  apt-get install -y \
  libfreetype6-dev \
  libgstreamer1.0-dev \
  libjpeg-dev \
  libpq-dev \
  zlib1g-dev \
  fontconfig \
  gcc \
  wkhtmltopdf

RUN apt-get autoremove -y


RUN pip install --upgrade pip setuptools wheel
ADD ./pyproject.toml /sirius/pyproject.toml
RUN pip install --no-cache-dir .

EXPOSE 5000

ADD . .

CMD ["bin/docker-entrypoint.sh"]