
DATE=`date +%s`
curl -s -w "\n" \
-H 'authority: www.fatbtc.com' \
-H 'upgrade-insecure-requests: 1' \
-H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36' \
-H 'sec-fetch-mode: navigate' \
-H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3' \
-H 'sec-fetch-site: same-origin' \
-H 'accept-encoding: gzip, deflate, br' \
-H 'accept-language: en-US,en;q=0.9' \
https://www.fatbtc.com/m/trade/BTCUSDT/1/$DATE --compressed > out

s=`grep name=\"s\"  out | awk '{print $4}' | sed 's/value="//g' | sed 's/"\><\/input>//g'`
jschl_vc=`grep name=\"jschl_vc\"  out | awk '{print $4}' | sed 's/value="//g' | sed 's/"\/>//g'`
pass=`grep name=\"pass\"  out | awk '{print $4}' | sed 's/value="//g' | sed 's/"\/>//g'`

echo "s"=$s
echo "jsch1_vc"=$jschl_vc
echo "pass"=$pass

curl -v "https://www.fatbtc.com/cdn-cgi/l/chk_jschl?s=$s&jschl_vc=$jschl_vc&pass=$pass&jschl_answer=25.9907379908" -H 'authority: www.fatbtc.com' -H 'upgrade-insecure-requests: 1' -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36' -H 'sec-fetch-mode: navigate' -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3' -H 'sec-fetch-site: same-origin' -H "referer: https://www.fatbtc.com/m/allticker/1/$DATE" -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.9' -H 'cookie: __cfduid=dffa23eb5799dfcf685b8caa274c8a6021570320591; _ga=GA1.2.834151933.1570320595; Hm_lvt_79ceeb6955b44b09df6a9c3fbb72555a=1570320596; cf_clearance=0ecc69618cfefa13efe16d3566037aa1747f732d-1571065550-0-150' --compressed
