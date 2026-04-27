function kitty --wraps='nohup kitty . &' --description 'alias kitty=nohup kitty . &'
    nohup kitty . & $argv
end
