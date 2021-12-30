# FROM golang:1.13 AS builder
# WORKDIR /app
# COPY main.go go.mod ./
# RUN CGO_ENABLED=0 GOOS=linux go build -o lb .

# FROM alpine:latest  
# RUN apk --no-cache add ca-certificates
# WORKDIR /root
# COPY --from=builder /app/lb .
# ENTRYPOINT [ "/root/lb" ]

FROM golang:1.17.5-alpine3.15 AS builder
WORKDIR /app
COPY main.go go.mod ./
RUN CGO_ENABLED=0 GOOS=linux go build -o lb .

#### SECOND STAGE ####

FROM alpine:3.15.0  
RUN apk --no-cache add ca-certificates
WORKDIR /root
COPY --from=builder /app/lb .
ENTRYPOINT [ "/root/lb" ]