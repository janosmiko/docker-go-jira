FROM golang:alpine AS build
RUN go get github.com/go-jira/jira/cmd/jira

FROM alpine:latest
RUN apk add --no-cache \
            python3 \
            py3-pip \
            jq \
            ca-certificates \
        && pip3 install --upgrade pip \
        && pip3 install \
            awscli \
        && rm -rf /var/cache/apk/*

COPY --from=build /go/bin/jira /usr/bin

WORKDIR /root

CMD [ "jira" ]
