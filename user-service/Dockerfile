# Use small Node base
FROM node:18-alpine AS builder

WORKDIR /app
# copy package files first to leverage cache
COPY package*.json ./
RUN npm ci --only=production

# copy app
COPY index.js ./

# create a minimal runtime image
FROM node:18-alpine
WORKDIR /app

# create a non-root user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# copy node_modules from builder
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/index.js ./index.js

USER appuser
EXPOSE 3001

# Simple healthcheck
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s \
  CMD wget -qO- http://localhost:3001/health || exit 1

CMD ["node","index.js"]