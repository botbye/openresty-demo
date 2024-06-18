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
