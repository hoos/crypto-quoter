DATA_DIR=data

dt=`date '+%d/%m/%Y_%H:%M:%S'`
gbpusd=`curl -s https://www.freeforexapi.com/api/live?pairs=GBPUSD | jq .rates.GBPUSD.rate`

echo "CRYPTO QUOTER -  $dt"
echo

# Binance USD
curl -s https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT > ./$DATA_DIR/BINANACE_BTCUSDT.json
symbol=`cat $DATA_DIR/BINANACE_BTCUSDT.json | jq .symbol`
price=`cat $DATA_DIR/BINANACE_BTCUSDT.json | jq .price`
temp="${price%\"}"
temp="${temp#\"}"
price="$temp"
echo "BINANCE: SYMBOL=$symbol PRICE=$price"

#Kraken
curl -s https://api.kraken.com/0/public/Ticker?pair=XBTUSD > ./$DATA_DIR/KRAKEN_XBTUSD.json
priceusd=`cat ./$DATA_DIR/KRAKEN_XBTUSD.json | jq '.result.XXBTZUSD.a[0]'`
temp="${priceusd%\"}"
temp="${temp#\"}"
priceusd="$temp"

curl -s https://api.kraken.com/0/public/Ticker?pair=XBTGBP > ./$DATA_DIR/KRAKEN_XBTGBP.json
pricegbp=`cat ./$DATA_DIR/KRAKEN_XBTGBP.json | jq '.result.XXBTZGBP.a[0]'`
temp="${pricegbp%\"}"
temp="${temp#\"}"
pricegbp="$temp"
echo "KRAKEN: XBTZUSD=$priceusd XBTZGBP=$pricegbp"

#Bitstamp
curl -s https://www.bitstamp.net/api/v2/ticker/btcusd > ./$DATA_DIR/BITSTAMP_BTCUSD.json
priceusd=`cat ./$DATA_DIR/BITSTAMP_BTCUSD.json | jq '.last'`
temp="${priceusd%\"}"
temp="${temp#\"}"
priceusd=$temp

curl -s https://www.bitstamp.net/api/v2/ticker/btceur > ./$DATA_DIR/BITSTAMP_BTCEUR.json
priceeur=`cat ./$DATA_DIR/BITSTAMP_BTCEUR.json | jq '.last'`
temp="${priceeur%\"}"
temp="${temp#\"}"
priceeur=$temp

echo "BITSTAMP: BTCUSD=$priceusd BTCEUR=$priceeur"

#Huobi-Global
curl -s https://api.huobi.pro/market/detail/merged?symbol=btcusdt > ./$DATA_DIR/HUOBI_GLOBAL_BTCUSDT.json
price=`cat ./$DATA_DIR/HUOBI_GLOBAL_BTCUSDT.json | jq '.tick.ask[0]'`
echo "HUOBI_GLOBAL: SYMBOL=BTCUSDT price=$price"

#BITFINEX
curl -s --request GET --url https://api.bitfinex.com/v1/pubticker/btcusd > ./$DATA_DIR/BITFINEX.json
price=`cat ./$DATA_DIR/BITFINEX.json | jq '.last_price'`
echo "BITFINEX: SYMBOL=BTCUSD price=$price"

#WIREX
curl -s https://api.wirexapp.com/public/ticker > ./$DATA_DIR/WIREX.json
price=`jq '.rates[] | select(.ticker == "BTC/USD") | .ask' ./$DATA_DIR/WIREX.json`
echo "WIREX: SYMBOL=BTCUSD price=$price"

#BITCOINPRO
curl -s https://api.pro.coinbase.com/products/BTC-USD/book  > ./$DATA_DIR/BITCOINPRO.json
price=`cat ./$DATA_DIR/BITCOINPRO.json | jq .asks[0][0]`
echo "BITCOINPRO: SYMBOL=BTC-USD price=$price"

#VINDAX
curl -s https://api.vindax.com/api/v1/returnTicker?symbol=BTCUSDT > ./$DATA_DIR/VINDAX.json
price=`jq '.[].last' ./$DATA_DIR/VINDAX.json`
echo "VINDAX: SYMBOL=BTCUSDT price=$price"

#P2PB2B
curl -s --location --request GET https://api.p2pb2b.io/api/v1/public/ticker?market=BTC_USD > ./$DATA_DIR/P2PB2B.json
price=`jq '.result.ask' ./$DATA_DIR/P2PB2B.json`
echo "P2PB2B: SYMBOL=BTC_USD price=$price"

#MXC
curl -s https://www.mxc.ceo/open/api/v1/data/ticker?market=BTC_USDT > ./$DATA_DIR/MXC.json
price=`jq '.data.last' ./$DATA_DIR/MXC.json`
echo "MXC: SYMBOL=BTC_USDT price=$price"

#COINEGG
curl -s https://api.coinegg.vip/api/v1/ticker/region/usdt?coin=btc > ./$DATA_DIR/COINEGG.json
price=`jq '.last' ./$DATA_DIR/COINEGG.json`
echo "COINEGG: SYMBOL=BTC_USDT price=$price"

#COINEAL
curl -s https://exchange-open-api.coineal.com/open/api/get_ticker?symbol=btcusdt > ./$DATA_DIR/COINEAL.json
price=`jq '.data.last' ./$DATA_DIR/COINEAL.json`
echo "COINEAL: SYMBOL=BTCUSDT price=$price"

#IDAX
curl -s https://openapi.idax.pro/api/v2/ticker?pair=BTC_USDT > ./$DATA_DIR/IDAX.json
price=`jq '.ticker[].last' ./$DATA_DIR/IDAX.json`
echo "IDAX: SYMBOL=BTC_USDT price=$price"

#FATBTC
curl -s https://www.fatbtc.com/m/trade/BTCUSDT/1/`date +%s` > ./$DATA_DIR/FATBTC.json
price=`jq '.trades[].price' ./$DATA_DIR/FATBTC.json`
echo "FATBTC: SYMBOL=BTCUSDT price=$price"
