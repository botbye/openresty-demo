FROM openresty/openresty:1.25.3.1-3-jammy

RUN luarocks install botbye-openresty

COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

EXPOSE 80
