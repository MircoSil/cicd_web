# Statisches Hosting via Nginx
FROM nginx:1.27-alpine
# Nginx Default-Index ersetzen
COPY site/ /usr/share/nginx/html/
# Healthcheck (einfacher Ping)
HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- http://localhost/ || exit 1
