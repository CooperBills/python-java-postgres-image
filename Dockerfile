# Python from official slim image (3.11-bookworm as of 11/1/23)
FROM python@sha256:99cb81c1d8e4d6fe275c1f5127c770ad86a64286533e06991e1887d3e18aa812

# Install Deps
RUN apt-get update && apt-get install -y \
    wget=1.21.3-1+b2 \
    nodejs=18.13.0+dfsg1-1 \
    npm=9.2.0~ds1-1 \
    && rm -rf /var/lib/apt/lists/*

# Install Java from eclipse-temurin (17 as of 11/1/23)
ENV JAVA_HOME=/opt/java/openjdk
COPY --from=eclipse-temurin@sha256:49a9414b125e2496a305baff9e0b5d9a8aded91b0df16729be5097f4555f2db5 $JAVA_HOME $JAVA_HOME
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Make directory for Spark jars
RUN mkdir -p /usr/local/lib/python3.11/site-packages/pyspark/jars
# Install the Postgres connector for Spark
RUN wget https://jdbc.postgresql.org/download/postgresql-42.5.3.jar \
    && mv postgresql-42.5.3.jar /usr/local/lib/python3.11/site-packages/pyspark/jars
# Install GCS connector for Spark
RUN wget https://repo1.maven.org/maven2/com/google/cloud/bigdataoss/gcs-connector/hadoop3-2.2.17/gcs-connector-hadoop3-2.2.17-shaded.jar \
    && mv gcs-connector-hadoop3-2.2.17-shaded.jar /usr/local/lib/python3.11/site-packages/pyspark/jars
