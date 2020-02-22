function login() {
    rm -f cookie-jar.txt
    username="$1"
    password="$2" 
    file=`tempfile`
    curl -o - -L -X POST -d "username=$username&password=$password&login=" -c cookie-jar.txt https://zap-hosting.com/de/ | tee $file > /dev/null

    if [ ! -z "`cat $file | grep name="username"`" ]; then
        echo "Login failed." > /dev/stderr
        exit 1
    else
        echo "Login success." > /dev/stderr
    fi
}