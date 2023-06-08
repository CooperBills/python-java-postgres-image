# Python from official slim image (3.11-slim as of 6/8/23)
FROM python@sha256:393195c807ea730a8498b4ba6745a44a6455ea7eb4adf981b49cc2f64a6fcfe9

# Install Java 11
RUN apt update && apt install -y \
    openjdk-11-jdk \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install Postgres jar so Spark can hydrate DB
RUN mkdir -p /usr/local/lib/python3.11/site-packages/pyspark/jars
RUN wget https://jdbc.postgresql.org/download/postgresql-42.5.3.jar \
   && mv postgresql-42.5.3.jar /usr/local/lib/python3.11/site-packages/pyspark/jars
