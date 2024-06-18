# OpenResty demo

This repository offers an example of using the BotBye OpenResty module with Docker.

For more details, please refer to our [documentation](https://docs.botbye.com/server-side-integration/OpenResty/).

## 1 - Configuration

Open the `nginx.conf` file and set your `BOTBYE_SERVER_KEY` (found in your [projects](https://app.botbye.com/admin/projects)).

## 2 - Build

```
docker image build . -t botbye-openresty-image
```

## 3 - Run

```
docker run -d --rm --name openRestyDemo -p 8081:80 botbye-openresty-image
```

## 4 - Test

You can send a request with an invalid token in the header using e.g. with `curl`

```
curl --location --request POST 'http://localhost:8081/' \
--header 'X-Token: invalidString'
```

Your request will appear in the overview of your project as declined.

## 5 - Logs

```
docker logs -f openRestyDemo
```

## 6 - Stop

```
docker stop  openRestyDemo
```

# FAQ
## Can I get isAllowed header in my application?

BotBye module can add headers to the HTTP request that your application can access.
Here's a simple example based on the official OpenResty page for [req.get_headers()](https://github.com/openresty/lua-nginx-module#ngxreqget_headers):

```nginx configuration
location / {
    access_by_lua_block {
        local botbye = require("botbye")

        local token = ngx.req.get_headers()['X-Token'] -- specify the header(or other) in which the botbye token is contained, e.g. X-Token
        local response = botbye.validateRequest(token)

        local is_allowed_header = 'X-BotBye-isAllowed'
        local is_allowed = response.result.isAllowed or false

        ngx.header[is_allowed_header] = is_allowed -- add header to response
        ngx.req.set_header(is_allowed_header, is_allowed) -- add header to request
    }

    proxy_pass http://example.org;
}
```

*Bot Name, Bot Type and Bot/Human flags will be added soon*
