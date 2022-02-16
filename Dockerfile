FROM node:12.18.3-alpine as build
WORKDIR /app
COPY package*.json /app/
RUN npm i
COPY . /app
RUN npm run build
FROM nginx:1.15.8-alpine
RUN sed -i 's|index  index.html index.htm;|try_files $uri /index.html;|' /etc/nginx/conf.d/default.conf
COPY --from=0  /app/dist/LeavePlannerApp /usr/share/nginx/html
EXPOSE 80
