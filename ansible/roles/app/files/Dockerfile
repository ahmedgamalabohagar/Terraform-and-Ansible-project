FROM node:20-alpine

WORKDIR /app

RUN apk add --no-cache curl \
 && addgroup -S appgroup && adduser -S nodeuser -G appgroup

COPY package*.json ./
RUN npm ci --omit=dev && npm cache clean --force

COPY --chown=nodeuser:appgroup src ./src

USER nodeuser

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

CMD ["node", "src/app.js"]
