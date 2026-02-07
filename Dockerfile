# Stage 1: Build
FROM node:22-alpine AS builder

WORKDIR /app

COPY package.json package-lock.json* ./
RUN npm ci

COPY . .

# Generate SvelteKit types and build
RUN npm run prepare && npm run build

# Stage 2: Production
FROM node:22-alpine

WORKDIR /app

# Copy built output and production dependencies
COPY --from=builder /app/build ./build
COPY --from=builder /app/package.json ./
COPY --from=builder /app/node_modules ./node_modules

# Copy static assets needed at runtime (foliate-js)
COPY --from=builder /app/static ./static

# Sources will be mounted as a volume
RUN mkdir -p /data/sources

ENV NODE_ENV=production
ENV PORT=3000
ENV HOST=0.0.0.0
ENV SOURCES_PATH=/data/sources

EXPOSE 3000

CMD ["node", "build"]
