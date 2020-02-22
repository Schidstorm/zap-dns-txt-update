function extractCsrfToken() {
    url="$1"
    token=`request "$url" | egrep -o "name=\"csrf_token_zap\" +value=\"[^\"]+\"" | cut -d= -f3 | xargs -L1 echo | tail -1`
    echo "Extracted CSRF token $token" > /dev/stderr
    echo "$token"
}

function changeTxt() {
    domainId=$1
    txtName="$2"
    recordId="$3"
    value="$4"
    ttl="${5-"3600"}"

    csrfToken="`extractCsrfToken https://zap-hosting.com/de/customer/domain/show/$domainId/dns/`"
    request \
        -d "csrf_token_zap=$csrfToken&record_name=$txtName&record_type=TXT&record_value=$value&record_ttl=$ttl&record_id=$recordId&cmd=EDIT&saveDnsZone=" \
        https://zap-hosting.com/de/customer/domain/show/47060/dns/ > /dev/null
}