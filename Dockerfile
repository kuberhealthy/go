# syntax=docker/dockerfile:1
FROM golang:1.24 AS builder
WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o /bin/example-check ./cmd/example

FROM gcr.io/distroless/base-debian12
COPY --from=builder /bin/example-check /example-check
ENTRYPOINT ["/example-check"]
