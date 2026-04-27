function qssock --wraps='socat - UNIX-CONNECT:/tmp/quickshell.sock' --description 'alias qssock=socat - UNIX-CONNECT:/tmp/quickshell.sock'
    socat - UNIX-CONNECT:/tmp/quickshell.sock $argv
end
