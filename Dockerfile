FROM golang:alpine AS build
RUN go get github.com/go-jira/jira/cmd/jira

FROM alpine:latest
RUN apk add --no-cache \
            python3 \
            py3-pip \
            jq \
            ca-certificates \
            bash \
        && pip3 install --upgrade pip \
        && pip3 install \
            awscli \
        && sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd \
        && ln -sf /bin/bash /bin/sh \
        && rm -rf /var/cache/apk/* \
        && echo "" > /root/.ash_history

COPY --from=build /go/bin/jira /usr/bin

ENV LC_ALL=en_US.UTF-8

WORKDIR /root

CMD [ "jira" ]
