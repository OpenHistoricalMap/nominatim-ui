FROM node:20 as builder

WORKDIR /app
COPY package.json /app
RUN npm install --legacy-peer-deps && \
    npm install rollup-plugin-svelte@latest --save-dev --legacy-peer-deps
COPY . /app
RUN npm run build

FROM nginx:stable-alpine
COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /usr/share/nginx/html/ui
COPY --from=builder /app/dist /usr/share/nginx/html/ui/
