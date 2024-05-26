# Stage 1: Build the app
FROM node:22-alpine3.19 AS build
WORKDIR /app
COPY package.json ./
COPY ./ ./
RUN npm install
RUN npm run build

# Stage 2: Serve the app with Nginx
FROM nginx:mainline-bookworm
COPY --from=build /app/dist /usr/share/nginx/html
# COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]