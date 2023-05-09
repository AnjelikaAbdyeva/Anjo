# syntax=docker/dockerfile:1

FROM golang:1.16

WORKDIR /go/src/github.com/alexellis/href-counter/

RUN go get -d -v golang.org/x/net/html 

COPY app.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o app app.go

FROM alpine:latest 

WORKDIR /root/

COPY --from=0 /go/src/github.com/alexellis/href-counter/app ./

CMD ["./app"]