# Stage 1: Build React app
FROM node:16.17.0-alpine AS builder

WORKDIR /app

# Copy dependencies first
COPY client/package.json client/yarn.lock ./

RUN yarn install

# Copy the rest of the client source
COPY client ./

# Optional: Pass API key from build ARG
ARG TMDB_V3_API_KEY
ENV VITE_APP_TMDB_V3_API_KEY=$TMDB_V3_API_KEY

# Build the React app
RUN yarn build

# Stage 2: Serve with NGINX
FROM nginx:alpine

# Copy build files to NGINX web root
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

