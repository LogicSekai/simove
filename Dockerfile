    # Stage 1: Build the Nuxt application
    FROM node:20-alpine AS build

    WORKDIR /app

    # Copy package.json and package-lock.json first to leverage Docker cache
    COPY package*.json ./

    # Install npm dependencies
    RUN npm ci

    # Copy the rest of the application code
    COPY . .

    # Build the Nuxt application for client-side rendering
    RUN npm run build

    # Stage 2: Serve the built application
    FROM nginx:stable-alpine

    # Copy the built Nuxt application from the build stage to Nginx's public directory
    COPY --from=build /app/.output/public /usr/share/nginx/html

    # Expose port 80 for web traffic
    EXPOSE 3000

    # Start Nginx
    CMD ["nginx", "-g", "daemon off;"]