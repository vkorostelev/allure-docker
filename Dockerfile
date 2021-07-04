FROM busybox:stable as build

ARG ALLURE_VERSION=2.14.0

WORKDIR /dist
RUN wget -q "https://github.com/allure-framework/allure2/releases/download/${ALLURE_VERSION}/allure-${ALLURE_VERSION}.tgz" -O "allure.tgz"
RUN mkdir -p usr/share/allure usr/bin
RUN tar -xzf allure.tgz --strip-components=1 -C usr/share/allure
RUN ln -s /usr/share/allure/bin/allure usr/bin/allure

FROM openjdk:8-jre-alpine
COPY --from=build --chown=root:root /dist/* /usr/
ENTRYPOINT ["allure"]
CMD ["--help"]
