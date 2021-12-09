FROM node:16 as base

WORKDIR /app

COPY package* ./

RUN npm ci

COPY rollup.config.js .
COPY tsconfig.json .
COPY public public
COPY src src

FROM base as build

RUN npm run build

FROM nginx:1.21.4 as prod

WORKDIR /usr/share/nginx/html

COPY --from=build /app/public/ ./
