FROM golang:1.22.1-alpine as build
WORKDIR /go/src/app
RUN apk update && apk add build-base
COPY go.mod go.sum /go/src/app/
RUN go mod download
COPY . .
RUN go build -o api

FROM alpine
WORKDIR /app
COPY --from=build /go/src/app/api /app/
