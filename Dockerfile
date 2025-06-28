# Build Stage
FROM node:16.17.0-alpine as builder
WORKDIR /app
COPY ./client/package.json ./client/yarn.lock ./
RUN yarn install
COPY ./client ./
ARG TMDB_V3_API_KEY
ENV VITE_APP_TMDB_V3_API_KEY=$TMDB_V3_API_KEY
RUN yarn build

# Serve Stage
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

