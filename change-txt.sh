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
    #csrf_token_zap=8c0ac66808702a15b4c6a0d53347de59a0d25d24af640e17&record_name=test&record_type=TXT&record_value=123456&record_ttl=3600&record_id=300081&cmd=EDIT&saveDnsZone=
    request \
        -d "csrf_token_zap=$csrfToken&record_name=$txtName&record_type=TXT&record_value=$value&record_ttl=$ttl&record_id=$recordId&cmd=EDIT&saveDnsZone=" \
        https://zap-hosting.com/de/customer/domain/show/47060/dns/ > /dev/null
}