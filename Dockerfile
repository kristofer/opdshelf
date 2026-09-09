FROM golang:1.25-bookworm AS builder
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 go build -o /out/gopdshelf ./cmd/gopdshelf

FROM debian:bookworm-slim
WORKDIR /app

ENV PORT=3000
ENV HOST=0.0.0.0
ENV BOOKS_DIR=/app/books
ENV DATABASE_PATH=/app/data/gopdshelf.db

COPY --from=builder /out/gopdshelf /usr/local/bin/gopdshelf
COPY static ./static

RUN mkdir -p /app/books /app/data

EXPOSE 3000
VOLUME ["/app/books", "/app/data"]

CMD ["gopdshelf"]
