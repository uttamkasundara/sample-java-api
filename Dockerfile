# Debug stage: copy build context and list files for troubleshooting
FROM alpine:3.18 AS inspect
WORKDIR /context
COPY . /context
RUN echo "-- root of build context --" && ls -la /context || true
RUN echo "-- sample-java-api directory --" && ls -la /context/sample-java-api || true
RUN echo "-- sample-java-api/target (built artifacts) --" && ls -la /context/sample-java-api/target || true

FROM eclipse-temurin:17-jre

ARG GIT_SHA=unknown
LABEL service="sample-java-api"
LABEL git.commit.sha="${GIT_SHA}"
LABEL version="${GIT_SHA}"

WORKDIR /app
# Copy the built jar from the inspect stage so the build log shows the directory listing above
COPY --from=inspect /context/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
