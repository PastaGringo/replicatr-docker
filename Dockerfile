FROM golang:1.22.2-alpine AS builder
RUN apk update && apk add --no-cache git gcc g++
RUN git clone https://github.com/Hubmakerlabs/replicatr.git /app
WORKDIR /app 
RUN go mod download
RUN GOOS=linux GOARCH=amd64 go build -o replicatr

FROM alpine:edge
RUN apk add --no-cache libstdc++
WORKDIR /
COPY --from=builder /app/replicatr . 
EXPOSE 3334
CMD ["/replicatr" ]