DATA_DIR=data

mkdir -p $DATA_DIR
dt=`date '+%d/%m/%Y_%H:%M:%S'`
gbpusd=`curl -s https://www.freeforexapi.com/api/live?pairs=GBPUSD | jq .rates.GBPUSD.rate`
symbolxrpusdbgp="XRPUSDGBP"

echo "ASK MAN CRYPTO QUOTER - LAST ASK - GBPUSD=$gbpusd- $dt"
echo
printf "\e[1;38m%-15s\t%-26s\t%-31s\t%-20s\t%-10s\t%-15s\e[0m\t\n" "EXCHNAGE" "XRPUSD" "XRPGBP" "XRPUSDGBP" "FEE" "TOTALUSD"

function strip_quotes() {
  temp="${1%\"}"
  temp="${temp#\"}"
  echo $temp
}

function print_quote() {
  printf "%-15s\t%-8s = %-15s\t%-8s = %-20s\t%-9s=%-10s\t%-10s\t%-10s\n" "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9"
}

function usdgbp() {
   echo $(expr $1/$2 | bc)
}

function addfee() {
   echo $(expr $1*$2 | bc)
}

#COINBASEPRIME
exchange="COINBASEPRIME" 
symbolusd="XRP-USD"
curl -s https://api.prime.coinbase.com/products/XRP-USD/ticker > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq .price  ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")
symbolgbp="XRP-GBP"
curl -s https://api.prime.coinbase.com/products/XRP-GBP/ticker > ./$DATA_DIR/${exchange}_${symbolgbp}.json
pricegbp=`jq .price  ./$DATA_DIR/${exchange}_${symbolgbp}.json`
pricegbp=$(strip_quotes "$pricegbp")
xrpusdgbp=$(usdgbp "$priceusd" "$gbpusd")
totalusd=$(addfee "1.0025" "$priceusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp $pricegbp $symbolxrpusdbgp $xrpusdgbp "0.25%" $totalusd 

exchange="COINBASEPRO" 
symbolusd="XRP-USD"
curl -s https://api.pro.coinbase.com/products/XRP-USD/book  > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq .asks[0][0]  ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")
symbolgbp="XRP-GBP"
curl -s https://api.pro.coinbase.com/products/XRP-GBP/book  > ./$DATA_DIR/${exchange}_${symbolgbp}.json
pricegbp=`jq .asks[0][0]  ./$DATA_DIR/${exchange}_${symbolgbp}.json`
pricegbp=$(strip_quotes "$pricegbp")
xrpusdgbp=$(usdgbp "$priceusd" "$gbpusd")
totalusd=$(addfee "1.0025" "$priceusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp $pricegbp $symbolxrpusdbgp $xrpusdgbp "0.25%" $totalusd 

#KRAKEN
exchange="KRAKEN" 
symbolusd="XXRPZUSD"
curl -s https://api.kraken.com/0/public/Ticker?pair=$symbolusd > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq .result.XXRPZUSD.a[0] ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")

symbolgbp="XXRPZGBP"
curl -s https://api.kraken.com/0/public/Ticker?pair=$symbolgbp > ./$DATA_DIR/${exchange}_${symbolgbp}.json
pricegbp=`jq .result.XXRPZGBP.a[0] ./$DATA_DIR/${exchange}_${symbolgbp}.json`
pricegbp=$(strip_quotes "$pricegbp")
xrpusdgbp=$(usdgbp "$priceusd" "$gbpusd")
totalusd=$(addfee "1.0026" "$priceusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp $pricegbp $symbolxrpusdbgp $xrpusdgbp "0.26%" $totalusd 

#BITFINEX
exchange="BITFINEX" 
symbolusd="XRPUSD"
curl -s --request GET --url https://api.bitfinex.com/v1/pubticker/xrpusd > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq .last_price ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")

symbolgbp="XRPGBP"
curl -s --request GET --url https://api.bitfinex.com/v1/pubticker/xrpgbp > ./$DATA_DIR/${exchange}_${symbolgbp}.json
pricegbp=`jq .last_price ./$DATA_DIR/${exchange}_${symbolgbp}.json`
pricegbp=$(strip_quotes "$pricegbp")
xrpusdgbp=$(usdgbp "$priceusd" "$gbpusd")
totalusd=$(addfee "1.0020" "$priceusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp $pricegbp $symbolxrpusdbgp $xrpusdgbp "0.20%" $totalusd 

#WIREX
exchange="WIREX" 
symbolusd="XRPUSD"
curl -s https://api.wirexapp.com/public/ticker > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq '.rates[] | select(.ticker == "XRP/USD") | .ask' ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")

symbolgbp="XRPGBP"
curl -s https://api.wirexapp.com/public/ticker > ./$DATA_DIR/${exchange}_${symbolgbp}.json
pricegbp=`jq '.rates[] | select(.ticker == "XRP/GBP") | .ask' ./$DATA_DIR/${exchange}_${symbolgbp}.json`
pricegbp=$(strip_quotes "$pricegbp")
xrpusdgbp=$(usdgbp "$priceusd" "$gbpusd")
totalusd=$(addfee "1.01" "$priceusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp $pricegbp $symbolxrpusdbgp $xrpusdgbp "1.0%" $totalusd

# Binance USD
exchange="BINANCE" 
symbolusd="XRPUSDT"
symbolgbp="XRPGBPT"
curl -s https://api.binance.com/api/v3/ticker/price?symbol=$symbolusd > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq .price $DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")
xrpusdgbp=$(usdgbp "$priceusd" "$gbpusd")
totalusd=$(addfee "1.0010" "$priceusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolxrpusdbgp $xrpusdgbp "0.1%" $totalusd

#Bitstamp
exchange="BITSTAMP" 
symbolusd="XRPUSD"
curl -s https://www.bitstamp.net/api/v2/ticker/xrpusd > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq .last ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")

#curl -s https://www.bitstamp.net/api/v2/ticker/xrpeur > ./$DATA_DIR/BITSTAMP_XRPEUR.json
#priceeur=`cat ./$DATA_DIR/BITSTAMP_XRPEUR.json | jq '.last'`
#priceeur=$(strip_quotes "$priceeur")
symbolgbp="XRPGBP"
xrpusdgbp=$(usdgbp "$priceusd" "$gbpusd")
totalusd=$(addfee "1.0050" "$priceusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolxrpusdbgp $xrpusdgbp "0.5%" $totalusd

#Huobi-Global
exchange="HUOBI-GLOBAL" 
symbolusd="XRPUSDT"
curl -s https://api.huobi.pro/market/detail/merged?symbol=xrpusdt > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq .tick.ask[0] ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")
xrpusdgbp=$(usdgbp "$priceusd" "$gbpusd")
totalusd=$(addfee "1.0070" "$priceusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolxrpusdbgp $xrpusdgbp "0.7%" $totalusd

##VINDAX
#exchange="VINDAX" 
#symbolusd="XRPUSDT"
#curl -s https://api.vindax.com/api/v1/returnTicker?symbol=XRPUSDT > ./$DATA_DIR/${exchange}_${symbolusd}.json
#priceusd=`jq '.[].last' ./$DATA_DIR/${exchange}_${symbolusd}.json`
#priceusd=$(strip_quotes "$priceusd")
#symbolgbp="XRPGBPT"
#xrpusdgbp=$(usdgbp "$priceusd" "$gbpusd")
#totalusd=$(addfee "1.0005" "$priceusd")
#print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolxrpusdbgp $xrpusdgbp "0.05%" $totalusd

#P2PB2B
#exchange="P2PB2B" 
#symbolusd="XRP_USD"
#curl -s --location --request GET https://api.p2pb2b.io/api/v1/public/ticker?market=XRP_USD > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq '.result.ask' ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")
symbolgbp="XRP_GBPT"
xrpusdgbp=$(usdgbp "$priceusd" "$gbpusd")
totalusd=$(addfee "1.0020" "$priceusd")
#print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolxrpusdbgp $xrpusdgbp "0.2%" $totalusd

#MXC
exchange="MXC" 
symbolusd="XRP_USDT"
curl -s https://www.mxc.ceo/open/api/v1/data/ticker?market=XRP_USDT > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq '.data.last' ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")
symbolgbp="XRP_GBPT"
xrpusdgbp=$(usdgbp "$priceusd" "$gbpusd")
totalusd=$(addfee "1.0010" "$priceusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolxrpusdbgp $xrpusdgbp "0.1%" $totalusd

#COINEGG
exchange="COINEGG" 
symbolusd="XRP_USDT"
curl -s https://api.coinegg.vip/api/v1/ticker/region/usdt?coin=xrp > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq '.last' ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")
symbolgbp="XRP_GBPT"
xrpusdgbp=$(usdgbp "$priceusd" "$gbpusd")
totalusd=$(addfee "1.0010" "$priceusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolxrpusdbgp $xrpusdgbp "0.1%" $totalusd

#COINEAL
#exchange="COINEAL" 
#symbolusd="XRPUSDT"
#curl -s https://exchange-open-api.coineal.com/open/api/get_ticker?symbol=xrpusdt > ./$DATA_DIR/${exchange}_${symbolusd}.json
#priceusd=`jq '.data.last ' ./$DATA_DIR/${exchange}_${symbolusd}.json`
#priceusd=$(strip_quotes "$priceusd")
#symbolgbp="XRPGBPT"
#xrpusdgbp=$(usdgbp "$priceusd" "$gbpusd")
#totalusd=$(addfee "1.0015" "$priceusd")
#print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolxrpusdbgp $xrpusdgbp "0.15%" $totalusd

#IDAX
exchange="IDAX" 
symbolusd="XRP_USDT"
curl -s https://openapi.idax.pro/api/v2/ticker?pair=XRP_USDT > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq '.ticker[].last' ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")
symbolgbp="XRP_GBPT"
xrpusdgbp=$(usdgbp "$priceusd" "$gbpusd")
totalusd=$(addfee "1.0015" "$priceusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolxrpusdbgp $xrpusdgbp "0.15%" $totalusd

#FATXRP
#exchange="FATXRP" 
#symbolusd="XRPUSDT"
#curl -s https://www.fatxrp.com/m/trade/XRPUSDT/1/`date +%s` > ./$DATA_DIR/${exchange}_${symbolusd}.json
#TIMESTAMP=`date +%s`
#curl -s "https://www.fatxrp.com/m/trade/XRPUSDT/1/$TIMESTAMP" -H 'authority: www.fatxrp.com' -H 'cache-control: max-age=0' -H 'upgrade-insecure-requests: 1' -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36' -H 'sec-fetch-mode: navigate' -H 'sec-fetch-user: ?1' -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3' -H 'sec-fetch-site: none' -H 'accept-language: en-US,en;q=0.9' -H 'cookie: __cfduid=dffa23eb5799dfcf685b8caa274c8a6021570320591; _ga=GA1.2.834151933.1570320595; Hm_lvt_79ceeb6955b44b09df6a9c3fbb72555a=1570320596; cf_clearance=91ca8d2a5eb61e169e663680aecf56a2669f1275-1571071164-0-150' > ./$DATA_DIR/${exchange}_${symbolusd}.json
#priceusd=`jq '.trades[].price' ./$DATA_DIR/${exchange}_${symbolusd}.json`
#priceusd=$(strip_quotes "$priceusd")
#symbolgbp="XRP_GBPT"
#xrpusdgbp=$(usdgbp "$priceusd" "$gbpusd")
#totalusd=$(addfee "1.0020" "$priceusd")
#print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolxrpusdbgp $xrpusdgbp "0.2%" $totalusd

#BILAXY
exchange="BILAXY" 
symbolusd="XRPUSDT"
curl -s https://api.bilaxy.com/v1/ticker?symbol=113 > ./$DATA_DIR/${exchange}_${symbolusd}.json
priceusd=`jq '.data.sell' ./$DATA_DIR/${exchange}_${symbolusd}.json`
priceusd=$(strip_quotes "$priceusd")
symbolgbp="XRPGBPT"
xrpusdgbp=$(usdgbp "$priceusd" "$gbpusd")
totalusd=$(addfee "1.0015" "$priceusd")
print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolxrpusdbgp $xrpusdgbp "0.15%" $totalusd

#BITFOREX
#exchange="BITFOREX" 
#symbolusd="USDTXRP"
#curl -s https://api.bitforex.com/api/v1/market/ticker?symbol=coin-usdt-xrp > ./$DATA_DIR/${exchange}_${symbolusd}.json
#priceusd=`jq '.data.sell' ./$DATA_DIR/${exchange}_${symbolusd}.json`
#priceusd=$(strip_quotes "$priceusd")
#symbolgbp="XRPGBPT"
#xrpusdgbp=$(usdgbp "$priceusd" "$gbpusd")
#totalusd=$(addfee "1.001" "$priceusd")
#print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolxrpusdbgp $xrpusdgbp "0.1%" $totalusd

#GEMINI
#exchange="GEMINI" 
#symbolusd="XRPUSD"
#curl -s -w "\n" https://api.gemini.com/v1/pubticker/xrpusd > ./$DATA_DIR/${exchange}_${symbolusd}.json
#priceusd=`jq '.ask' ./$DATA_DIR/${exchange}_${symbolusd}.json`
#priceusd=$(strip_quotes "$priceusd")
#symbolgbp="XRPGBP"
#xrpusdgbp=$(usdgbp "$priceusd" "$gbpusd")
#totalusd=$(addfee "1.0025" "$priceusd")
#print_quote $exchange $symbolusd $priceusd $symbolgbp "N/A" $symbolxrpusdbgp $xrpusdgbp "0.25%" $totalusd
