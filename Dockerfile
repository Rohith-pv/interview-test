FROM nginx:1.19-alpine
RUN addgroup -S nginx && adduser -S nginx -G nginx
RUN chown -R nginx:nginx /var/cache/nginx /var/run /var/log/nginx
USER nginx
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;"]
