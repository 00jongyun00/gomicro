# base go image
FROM golang:1.18-alpine as builer

RUN mkdir /app

COPY . /app

WORKDIR /app

RUN CGO_ENABLED=0 go build -o brokerApp ./cmd/api

# build a tiny docker image
FROM alpine:latest

RUN mkdir /app

COPY --from=builer /app/brokerApp /app

CMD ["/app/brokerApp"]
