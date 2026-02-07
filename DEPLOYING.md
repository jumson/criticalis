# Deploying Criticalis

This guide covers deploying Criticalis to a VPS using Docker Compose with an OpenResty reverse proxy.

---

## Prerequisites

- A Linux VPS with Docker and Docker Compose installed
- Git
- The ePub source files (7 volumes of *The Treasury of David*)

---

## Quick Start

```bash
# 1. Clone the repository
git clone https://github.com/jumson/criticalis.git
cd criticalis

# 2. Create your environment file
cp .env.example .env

# 3. Edit .env — at minimum, set these three values:
#    DOMAIN=criticalis.example.com
#    POSTGRES_PASSWORD=<strong-random-password>
#    BETTER_AUTH_SECRET=<generate-with: openssl rand -base64 32>

# 4. Start the stack
docker compose up -d

# 5. Seed the ePub source files into the Docker volume
./scripts/seed-sources.sh

# 6. Verify it's running
curl http://localhost
```

---

## Configuration Reference

All configuration is done through a single `.env` file. See `.env.example` for the full template with comments.

### Required

| Variable | Description | Example |
|----------|-------------|---------|
| `POSTGRES_PASSWORD` | Database password | `my-secure-password-123` |
| `BETTER_AUTH_SECRET` | Secret for signing auth tokens | `openssl rand -base64 32` |

### Recommended

| Variable | Default | Description |
|----------|---------|-------------|
| `DOMAIN` | `localhost` | Domain or subdomain for the site |
| `PUBLIC_URL` | `http://localhost` | Full public URL (protocol + domain) |
| `LISTEN_PORT` | `80` | Port the proxy listens on (host side) |

### Optional

| Variable | Default | Description |
|----------|---------|-------------|
| `POSTGRES_USER` | `criticalis` | Database username |
| `POSTGRES_DB` | `criticalis` | Database name |
| `GITHUB_CLIENT_ID` | — | GitHub OAuth app client ID |
| `GITHUB_CLIENT_SECRET` | — | GitHub OAuth app client secret |
| `GOOGLE_CLIENT_ID` | — | Google OAuth client ID |
| `GOOGLE_CLIENT_SECRET` | — | Google OAuth client secret |
| `SOURCES_PATH` | `/data/sources` | Path to ePub files inside the container |

---

## Architecture

The Docker Compose stack runs three containers:

```
                   ┌──────────┐
   :80 ──────────▶ │ OpenResty │  (reverse proxy, rate limiting, security headers)
                   └─────┬────┘
                         │
                   ┌─────▼────┐
                   │   App    │  (SvelteKit Node server on :3000)
                   └─────┬────┘
                         │
                   ┌─────▼────┐
                   │ Postgres │  (PostgreSQL 17)
                   └──────────┘
```

### Volumes

| Volume | Purpose |
|--------|---------|
| `pgdata` | PostgreSQL data directory |
| `sources` | ePub source files |

---

## Seeding Source Files

The ePub files need to be copied into the `sources` Docker volume. The included helper script handles this:

```bash
./scripts/seed-sources.sh
```

This copies all `.epub` files from the local `sources/` directory into the running app container's `/data/sources/` directory, which is backed by the named volume.

If you need to add or update files later, just re-run the script.

---

## Running Behind an Existing Reverse Proxy

If your VPS already has an OpenResty/nginx instance handling TLS and routing for multiple sites, you have two options:

### Option A: Use the built-in OpenResty (simplest)

Set `LISTEN_PORT` to an unused port (e.g., `8090`) and proxy to it from your host-level nginx:

```nginx
# In your host nginx/openresty config
server {
    listen 443 ssl;
    server_name criticalis.example.com;

    # ... your SSL config ...

    location / {
        proxy_pass http://127.0.0.1:8090;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

### Option B: Bypass the built-in OpenResty

Remove or comment out the `proxy` service in `docker-compose.yml` and expose the `app` service directly:

```yaml
services:
  app:
    # ... existing config ...
    ports:
      - "127.0.0.1:3000:3000"
```

Then proxy to port 3000 from your host-level nginx. Make sure to set `ORIGIN` in the app's environment to match your public URL (SvelteKit uses this for CSRF protection):

```yaml
environment:
  - ORIGIN=https://criticalis.example.com
```

---

## Local Development

For developing without Docker:

```bash
# Install dependencies
npm ci

# Start PostgreSQL locally (or use Docker for just the database)
docker run -d --name criticalis-db \
  -e POSTGRES_USER=criticalis \
  -e POSTGRES_PASSWORD=dev \
  -e POSTGRES_DB=criticalis \
  -p 5432:5432 \
  postgres:17-alpine

# Create .env for local dev
cat > .env << 'EOF'
DATABASE_URL=postgresql://criticalis:dev@localhost:5432/criticalis
BETTER_AUTH_SECRET=dev-secret-not-for-production
BETTER_AUTH_URL=http://localhost:5173
EOF

# Start the dev server
npm run dev
```

The dev server runs at `http://localhost:5173`. ePub files are served from the local `sources/` directory.

---

## Common Operations

### View logs

```bash
# All services
docker compose logs -f

# Just the app
docker compose logs -f app
```

### Restart after config changes

```bash
docker compose down && docker compose up -d
```

### Rebuild after code changes

```bash
docker compose build app && docker compose up -d app
```

### Database access

```bash
docker compose exec db psql -U criticalis
```

### Backup the database

```bash
docker compose exec db pg_dump -U criticalis criticalis > backup.sql
```

### Restore a database backup

```bash
docker compose exec -T db psql -U criticalis criticalis < backup.sql
```

---

## Project Structure

```
criticalis/
├── src/
│   ├── routes/
│   │   ├── +page.svelte              # Landing page (volume grid)
│   │   ├── +layout.svelte            # Global layout (header, footer)
│   │   ├── about/+page.svelte        # About page
│   │   ├── read/[volumeId]/          # Reader UI
│   │   │   ├── +page.svelte          # ePub reader with foliate-js
│   │   │   └── +page.ts              # Volume data loader
│   │   └── api/epub/[volumeId]/      # ePub file serving endpoint
│   │       └── +server.ts
│   ├── lib/
│   │   ├── server/
│   │   │   ├── schema.ts             # Drizzle ORM database schema
│   │   │   ├── db.ts                 # PostgreSQL connection
│   │   │   └── auth.ts               # Better Auth configuration
│   │   └── data/
│   │       └── volumes.ts            # Volume metadata (titles, psalm ranges)
│   ├── hooks.server.ts               # CSP headers for ePub rendering
│   ├── app.css                       # Global styles
│   └── app.html                      # HTML shell
├── sources/                           # ePub + PDF source files (7 volumes each)
├── static/
│   └── foliate-js/                   # ePub renderer (git submodule)
├── docker/
│   └── openresty/
│       ├── nginx.conf.template       # nginx config with envsubst variables
│       └── docker-entrypoint.sh      # Substitutes $DOMAIN at startup
├── scripts/
│   └── seed-sources.sh               # Copies ePubs into Docker volume
├── Dockerfile                         # Multi-stage Node 22 Alpine build
├── docker-compose.yml                 # App + PostgreSQL + OpenResty
├── .env.example                       # All configuration options documented
├── drizzle.config.ts                  # ORM migration config
├── svelte.config.js                   # SvelteKit config (adapter-node)
├── vite.config.ts                     # Vite bundler config
├── ROADMAP.md                         # Technical roadmap and decision log
├── DEPLOYING.md                       # This file
└── README.md                          # Project vision
```
