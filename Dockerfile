# Python from official slim image (3.11.4-bookworm as of 6/15/23)
FROM python@sha256:35483f08b07e42d712ba92576c0d09e7a077d33677855d3276190b65dc4aec30

# Install Java from eclipse-temurin (17/17.0.7_7-jdk-jammy as of 6/15/23)
ENV JAVA_HOME=/opt/java/openjdk
COPY --from=eclipse-temurin@sha256:b0faf02bf7acfc65be1c2d0a291140300bd129620f145bf1013a1da748295d0c $JAVA_HOME $JAVA_HOME
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Install Deps
RUN apt-get update && apt-get install -y \
    wget=1.21.3-1+b2 \
    && rm -rf /var/lib/apt/lists/*

# Install Postgres & GCS connectors for Spark
RUN mkdir -p /usr/local/lib/python3.11/site-packages/pyspark/jars
RUN wget https://jdbc.postgresql.org/download/postgresql-42.5.3.jar \
   && mv postgresql-42.5.3.jar /usr/local/lib/python3.11/site-packages/pyspark/jars
RUN wget https://repo1.maven.org/maven2/com/google/cloud/bigdataoss/gcs-connector/hadoop3-2.2.15/gcs-connector-hadoop3-2.2.15-shaded.jar \
    && mv gcs-connector-hadoop3-2.2.15-shaded.jar /usr/local/lib/python3.11/site-packages/pyspark/jars
