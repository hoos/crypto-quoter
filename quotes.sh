DATA_DIR=data

mkdir -p $DATA_DIR
dt=`date '+%d/%m/%Y_%H:%M:%S'`
gbpusd=`curl -s https://www.freeforexapi.com/api/live?pairs=GBPUSD | jq .rates.GBPUSD.rate`
symbolbtcusdbgp="BTCUSDGBP"

echo "ASK MAN CRYPTO QUOTER - LAST ASK - GBPUSD=$gbpusd- $dt"
echo

function strip_quotes() {
  temp="${1%\"}"
  temp="${temp#\"}"
  echo $temp
}

function print_quote() {
  printf "%-15s%s=%-15s\t%s=%-20s\t%-9s=%s\n" "$1" "$2" "$3" "$4" "$5" "$6" "$7"
}

function usdgbp() {
   echo $(expr $1/$2 | bc)
}

#COINBASEPRIME
exchange="COINBASEPRIME" 
symbolusd="BTC-USD"
curl -s https://api.prime.coinbase.com/products/BTC-USD/ticker > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq .price  ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")
symbolgbp="BTC-GBP"
curl -s https://api.prime.coinbase.com/products/BTC-GBP/ticker > ./$DATA_DIR/${exchange}_${symbolgbp}.json
pricegbp=`jq .price  ./$DATA_DIR/${exchange}_${symbolgbp}.json`
pricegbp=$(strip_quotes "$pricegbp")
btcusdgbp=$(usdgbp "$priceusd" "$gbpusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp $pricegbp $symbolbtcusdbgp $btcusdgbp


exchange="COINBASEPRO" 
symbolusd="BTC-USD"
curl -s https://api.pro.coinbase.com/products/BTC-USD/book  > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq .asks[0][0]  ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")
symbolgbp="BTC-GBP"
curl -s https://api.pro.coinbase.com/products/BTC-GBP/book  > ./$DATA_DIR/${exchange}_${symbolgbp}.json
pricegbp=`jq .asks[0][0]  ./$DATA_DIR/${exchange}_${symbolgbp}.json`
pricegbp=$(strip_quotes "$pricegbp")
btcusdgbp=$(usdgbp "$priceusd" "$gbpusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp $pricegbp $symbolbtcusdbgp $btcusdgbp

#KRAKEN
exchange="KRAKEN" 
symbolusd="XXBTZUSD"
curl -s https://api.kraken.com/0/public/Ticker?pair=$symbolusd > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq .result.XXBTZUSD.a[0] ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")

symbolgbp="XXBTZGBP"
curl -s https://api.kraken.com/0/public/Ticker?pair=$symbolgbp > ./$DATA_DIR/${exchange}_${symbolgbp}.json
pricegbp=`jq .result.XXBTZGBP.a[0] ./$DATA_DIR/${exchange}_${symbolgbp}.json`
pricegbp=$(strip_quotes "$pricegbp")
btcusdgbp=$(usdgbp "$priceusd" "$gbpusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp $pricegbp $symbolbtcusdbgp $btcusdgbp

#BITFINEX
exchange="BITFINEX" 
symbolusd="BTCUSD"
curl -s --request GET --url https://api.bitfinex.com/v1/pubticker/btcusd > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq .last_price ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")

symbolgbp="BTCGBP"
curl -s --request GET --url https://api.bitfinex.com/v1/pubticker/btcgbp > ./$DATA_DIR/${exchange}_${symbolgbp}.json
pricegbp=`jq .last_price ./$DATA_DIR/${exchange}_${symbolgbp}.json`
pricegbp=$(strip_quotes "$pricegbp")
btcusdgbp=$(usdgbp "$priceusd" "$gbpusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp $pricegbp $symbolbtcusdbgp $btcusdgbp

#WIREX
exchange="WIREX" 
symbolusd="BTCUSD"
curl -s https://api.wirexapp.com/public/ticker > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq '.rates[] | select(.ticker == "BTC/USD") | .ask' ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")

symbolgbp="BTCGBP"
curl -s https://api.wirexapp.com/public/ticker > ./$DATA_DIR/${exchange}_${symbolgbp}.json
pricegbp=`jq '.rates[] | select(.ticker == "BTC/GBP") | .ask' ./$DATA_DIR/${exchange}_${symbolgbp}.json`
pricegbp=$(strip_quotes "$pricegbp")
btcusdgbp=$(usdgbp "$priceusd" "$gbpusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp $pricegbp $symbolbtcusdbgp $btcusdgbp

# Binance Jersey
exchange="BINANCE-JERSEY" 
symbolusd="BTCUSD"
symbolgbp="BTCGBP"
curl -s https://api.binance.je/api/v3/avgPrice?symbol=$symbolgbp > ./$DATA_DIR/${exchange}_${symbolgbp}.json
pricegbp=`jq .price $DATA_DIR/${exchange}_${symbolgbp}.json`
pricegbp=$(strip_quotes "$pricegbp")
print_quote $exchange $symbolusd "N/A" $symbolgbp $pricegbp $symbolbtcusdbgp "N/A"

# Binance USD
exchange="BINANCE" 
symbolusd="BTCUSDT"
symbolgbp="BTCGBPT"
curl -s https://api.binance.com/api/v3/ticker/price?symbol=$symbolusd > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq .price $DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")
btcusdgbp=$(usdgbp "$priceusd" "$gbpusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolbtcusdbgp $btcusdgbp

#Bitstamp
exchange="BITSTAMP" 
symbolusd="BTCUSD"
curl -s https://www.bitstamp.net/api/v2/ticker/btcusd > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq .last ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")

#curl -s https://www.bitstamp.net/api/v2/ticker/btceur > ./$DATA_DIR/BITSTAMP_BTCEUR.json
#priceeur=`cat ./$DATA_DIR/BITSTAMP_BTCEUR.json | jq '.last'`
#priceeur=$(strip_quotes "$priceeur")
symbolgbp="BTCGBP"
btcusdgbp=$(usdgbp "$priceusd" "$gbpusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolbtcusdbgp $btcusdgbp

#Huobi-Global
exchange="HUOBI-GLOBAL" 
symbolusd="BTCUSDT"
curl -s https://api.huobi.pro/market/detail/merged?symbol=btcusdt > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq .tick.ask[0] ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")
btcusdgbp=$(usdgbp "$priceusd" "$gbpusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolbtcusdbgp $btcusdgbp

#VINDAX
exchange="VINDAX" 
symbolusd="BTCUSDT"
curl -s https://api.vindax.com/api/v1/returnTicker?symbol=BTCUSDT > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq '.[].last' ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")
symbolgbp="BTCGBPT"
btcusdgbp=$(usdgbp "$priceusd" "$gbpusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolbtcusdbgp $btcusdgbp

#P2PB2B
exchange="P2PB2B" 
symbolusd="BTC_USD"
curl -s --location --request GET https://api.p2pb2b.io/api/v1/public/ticker?market=BTC_USD > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq '.result.ask' ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")
symbolgbp="BTC_GBPT"
btcusdgbp=$(usdgbp "$priceusd" "$gbpusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolbtcusdbgp $btcusdgbp

#MXC
exchange="MXC" 
symbolusd="BTC_USDT"
curl -s https://www.mxc.ceo/open/api/v1/data/ticker?market=BTC_USDT > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq '.data.last' ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")
symbolgbp="BTC_GBPT"
btcusdgbp=$(usdgbp "$priceusd" "$gbpusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolbtcusdbgp $btcusdgbp

#COINEGG
exchange="COINEGG" 
symbolusd="BTC_USDT"
curl -s https://api.coinegg.vip/api/v1/ticker/region/usdt?coin=btc > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq '.last' ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")
symbolgbp="BTC_GBPT"
btcusdgbp=$(usdgbp "$priceusd" "$gbpusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolbtcusdbgp $btcusdgbp

#COINEAL
exchange="COINEAL" 
symbolusd="BTCUSDT"
curl -s https://exchange-open-api.coineal.com/open/api/get_ticker?symbol=btcusdt > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq '.data.last ' ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")
symbolgbp="BTCGBPT"
btcusdgbp=$(usdgbp "$priceusd" "$gbpusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolbtcusdbgp $btcusdgbp

#IDAX
exchange="IDAX" 
symbolusd="BTC_USDT"
curl -s https://openapi.idax.pro/api/v2/ticker?pair=BTC_USDT > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq '.ticker[].last' ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")
symbolgbp="BTC_GBPT"
btcusdgbp=$(usdgbp "$priceusd" "$gbpusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolbtcusdbgp $btcusdgbp

#FATBTC
exchange="FATBTC" 
symbolusd="BTCUSDT"
curl -s https://www.fatbtc.com/m/trade/BTCUSDT/1/`date +%s` > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq '.trades[].price' ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")
symbolgbp="BTC_GBPT"
btcusdgbp=$(usdgbp "$priceusd" "$gbpusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolbtcusdbgp $btcusdgbp

#BILAXY
exchange="BILAXY" 
symbolusd="BTCUSDT"
curl -s https://api.bilaxy.com/v1/ticker?symbol=113 > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq '.data.sell' ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")
symbolgbp="BTCGBPT"
btcusdgbp=$(usdgbp "$priceusd" "$gbpusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolbtcusdbgp $btcusdgbp


