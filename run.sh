#
# Author: Terran Tian
# Email: terran.tian@foxmail.com
#

dir=$(
    cd $(dirname $0)
    pwd
)
echo $dir

# SSL_HOST=root@192.168.50.232
# SSL_HOST=gpu4090@192.168.50.231
SSL_HOST=root@47.89.184.191
# SSL_HOST=root@47.253.107.50
SSL_DIR="/home/work"

SSL_PEM=~/.ssh/id_rsa
function login() {
    echo ssh -i $SSL_PEM $SSL_HOST
}

function sync() {
    rsync -avP \
        --exclude=.git \
        --exclude=.github \
        --exclude=.gitignore \
        --exclude=.python-version \
        --exclude=out \
        --exclude=tmp \
        --exclude=__pycache__ \
        ./ $SSL_HOST:$SSL_DIR/InstantID
}

function restart_kit(){
    ssh -i $SSL_PEM root@8.140.200.125 bash -c "'\
        docker restart admin-front-1
	'"
}


if test $# -lt 1; then error_exit "wrong arguments"; fi
cmd=$1 && shift
echo $cmd $@
echo $date $cmd $@ >>history.log
$cmd $@
