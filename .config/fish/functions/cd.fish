function cd --wraps='curl -L rickroll.sh | bash' --wraps='curl -s -L https://bit.ly/3zvELNz | bash' --description 'alias cd=cd'
    builtin cd $argv
end
