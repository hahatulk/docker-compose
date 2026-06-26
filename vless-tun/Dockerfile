FROM golang:1.25-alpine AS builder

WORKDIR /app
COPY ./tun .

RUN go build -o /tun .

FROM alpine:3.21

RUN apk add --no-cache ca-certificates iproute2 iptables
COPY --from=builder /tun /usr/local/bin/goxray-cli

ENTRYPOINT ["goxray-cli"]
