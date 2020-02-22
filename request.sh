
function request() {
    DEBUG=${DEBUG:-"true"}

    if [ "$DEBUG" == "true" ]; then
        curl -o - -D - -vL -c cookie-jar.txt  -b cookie-jar.txt $@
    else
        curl -sL -c cookie-jar.txt  -b cookie-jar.txt $@ 
    fi
}