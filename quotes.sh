DATA_DIR=data

dt=`date '+%d/%m/%Y_%H:%M:%S'`

echo "CRYPTO QUOTER -  $dt"

# Binance USD
curl -s https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT > ./$DATA_DIR/BINANACE_BTCUSDT.json
symbol=`cat $DATA_DIR/BINANACE_BTCUSDT.json | jq .symbol`
price=`cat $DATA_DIR/BINANACE_BTCUSDT.json | jq .price`
echo "BINANCE: SYMBOL=$symbol PRICE=$price"

# Binance GBP
#curl -s https://api.binance.com/api/v3/ticker/price?symbol=BTCGBPT > ./$DATA_DIR/BINANACE_BTCGBPT.json
#symbol=`cat $DATA_DIR/BINANACE_BTCGBPT.json | jq .symbol`
#price=`cat $DATA_DIR/BINANACE_BTCGBPT.json | jq .price`
#echo "BINANCE: SYMBOL=$symbol PRICE=$price"

#Kraken
curl -s https://api.kraken.com/0/public/Ticker?pair=XBTUSD > ./$DATA_DIR/KRAKEN_XBTUSD.json
price=`cat ./$DATA_DIR/KRAKEN_XBTUSD.json | jq '.result.XXBTZUSD.a[0]'`
echo "KRAKEN: SYMBOL=XXBTZUSD PRICE=$price"

#Bitstamp
curl -s https://www.bitstamp.net/api/ticker?currency_pair=btcusd > ./$DATA_DIR/BITSTAMP_BTCUSD.json
price=`cat ./$DATA_DIR/BITSTAMP_BTCUSD.json | jq '.last'`
echo "BITSTAMP: SYMBOL=BTCUSD PRICE=$price"

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
price=`jq '.data.buy' ./$DATA_DIR/MXC.json`
echo "MXC: SYMBOL=BTC_USDT price=$price"
