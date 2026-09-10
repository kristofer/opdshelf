<p align="center">
  <img src="static/logo.png" alt="gopdshelf Logo" width="200">
</p>
<h1 align="center">gopdshelf</h1>
<p align="center"><em>Host your own OPDS library server with Go, SQLite, and HTMX</em></p>

## Overview

gopdshelf is a Go rewrite of the original OPDShelf Bun application. It keeps the same core workflow—a books directory that is exposed as an OPDS catalog and editable from an admin UI—but now uses:

- **Go** with a standard `cmd/` + `internal/` project layout
- **SQLite** to persist the catalog state
- **HTMX** for server-rendered admin interactions

Books remain stored on disk in `BOOKS_DIR`, while SQLite keeps searchable metadata such as filename, title, MIME type, size, and last-updated time.

## Conversion plan

- [x] Phase 1: replace the Bun entrypoint with a proper Go application structure
- [x] Phase 2: introduce SQLite-backed catalog synchronization for books stored on disk
- [x] Phase 3: rebuild the admin flow with server-rendered HTML and HTMX partial updates
- [x] Phase 4: preserve OPDS feed output, upload/rename/delete flows, and Docker packaging in Go

## Features

- OPDS feed at `/`
- HTMX-powered admin UI at `/admin`
- Upload, rename, delete, and download books
- Optional admin login via `ADMIN_USERNAME` and `ADMIN_PASSWORD`
- SQLite-backed searchable library catalog

## Configuration

| Variable | Default | Description |
|---|---|---|
| `HOST` | `0.0.0.0` | Bind host |
| `PORT` | `3000` | HTTP port |
| `BOOKS_DIR` | `./books` | Directory where book files are stored |
| `DATABASE_PATH` | `./data/gopdshelf.db` | SQLite database path |
| `ADMIN_USERNAME` | unset | Optional admin username |
| `ADMIN_PASSWORD` | unset | Optional admin password |

## Run locally

```bash
go mod download
go run ./cmd/gopdshelf
```

Then open `http://localhost:3000/admin`.

## Docker Compose

```yaml
services:
  gopdshelf:
    build: .
    container_name: gopdshelf
    ports:
      - "3000:3000"
    volumes:
      - ./books:/app/books
      - ./data:/app/data
    restart: unless-stopped
```

## Testing

```bash
go test ./...
```
