# time-getter-rack-app
The minimalistic Rack application to respond for the `GET /time` requests.

### How to use

Send request to `.../time?format=[the nodes devided by %2C]`

### For example

```bigquery
curl --url "http://localhost:9292/time?format=year%2Cmonth%2Cday%2Chour" -i
```

#### Available formats:
- year
- month
- day
- hour
- minute
- second