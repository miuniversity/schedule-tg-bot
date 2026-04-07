FROM oven/bun:1-alpine
WORKDIR /app
RUN apk add --no-cache alpine-conf && \
    setup-timezone -z Europe/Moscow
COPY package.json bun.lock ./
RUN bun i --frozen-lockfile

COPY ./ ./
RUN bun run format
RUN bun run lint
RUN bun run build
VOLUME /app/logs ./logs
VOLUME /app/static ./static
CMD ["bun", "run", "start:prod"]
