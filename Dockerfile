FROM golang:alpine

RUN \
  go get github.com/go-jira/jira/cmd/jira

ENTRYPOINT [ "jira" ]