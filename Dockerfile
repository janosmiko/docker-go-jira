FROM golang:alpine AS build
RUN go get github.com/go-jira/jira/cmd/jira

FROM alpine:latest
RUN apk add --no-cache jq ca-certificates
COPY --from=builder /go/bin/jira /usr/bin
CMD [ "jira" ]
