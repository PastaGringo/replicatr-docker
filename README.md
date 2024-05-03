# replicatr-docker
A simple Dockerfile to build/run [replicatr](https://github.com/Hubmakerlabs/replicatr) Nostr relay.  

## Docker
Dockerfile:
```
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
```

build:
```
docker build -t YourUserName/replicatr-docker .
```

docker-compose.yml :
```
version: '3.8'
services:

  replicatr-docker:
    image: pastagringo/replicatr-docker
    container_name: replicatr-docker
    ports:
      - 3334:3334
```

composing:
```
docker compose up -d && docker logs -f replicatr-docker
```

You can check if the Nostr relay is working from: https://nostrrr.com/relay/YourNostrRelayUL  
Nostrrr: https://nostrrr.com/relay/replicatr.fractalized.net  
Nostr.watch: https://nostr.watch/relay/replicatr.fractalized.net  
Docker hub: https://hub.docker.com/r/pastagringo/replicatr-docker (15.44 MB)  
