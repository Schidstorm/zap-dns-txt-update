. ./request.sh
. ./login.sh
. ./change-txt.sh

export DEBUG=false

opt_username=""
opt_password=""
opt_domainId=""
opt_txtName=""
opt_txtId=""
opt_txtValue=""

function usage() {
    u=<< EOL
$(basename $0) -u username -p password --did domainId -n txtName --tid txtId txtValue
EOL
}

while true; do
    arg="$1"
    case "$arg" in 
        -h|--help) usage; exit ;;
        -u*) opt_username="${arg:2}"; shift ;;
        -u|--username)  opt_username="$2"; shift 2 ;;
        -p*) opt_password="${arg:2}"; shift ;;
        -p|--password) opt_password="$2"; shift 2 ;;
        --did) opt_domainId="$2"; shift 2 ;;
        -n|--name) opt_txtName="$2"; shift 2 ;;
        --tid) opt_txtId="$2"; shift 2 ;;
        --) shift; break ;; 
        *) shift; break ;;
    esac
done

login "$opt_username" "$opt_password"
changeTxt "$opt_domainId" "$opt_txtName" "$opt_txtId" "$opt_txtValue"