# Gunakan Nginx sebagai base image
FROM nginx:alpine

# Salin konfigurasi nginx
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Salin file hasil build Nuxt ke direktori Nginx
COPY dist/ /usr/share/nginx/html/

# Expose port 80
EXPOSE 3000

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
