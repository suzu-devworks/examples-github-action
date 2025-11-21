FROM golang:1.24 as builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o cicdhandson

FROM scratch
COPY --from=builder /app/cicdhandson /app
ENTRYPOINT ["/app"]
