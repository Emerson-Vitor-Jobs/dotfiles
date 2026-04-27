function sleep --wraps='systemctl hibernate' --wraps='systemctl suspend' --description 'alias sleep=systemctl suspend'
    systemctl suspend $argv
end
