PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;32m\]\w\[\e[m\] \[\e[0;31m\]\$ \[\e[m\]\[\e[0;32m\]'

alias ls='ls --color'
alias la='ls -la  --color'
alias ..='cd ..'
alias i3edit='vim ~/.config/i3/config'
alias starti3='startx $HOME/.xinitrc i3'
alias startgnome='startx $HOME/.xinitrc gnome'
alias ls='ls --color'
alias install='pacman -S'
alias remove='pacman -R'
alias update='pacman -Syu'
alias netstart='netctl start'
alias netstop='netctl stop'
alias netlist='netctl list'
alias ipp='ip addr | grep --color 'inet''
alias startvm='vboxmanage startvm'
alias listvm='vboxmanage list vms'
alias bashedit='vim /root/.bashrc'
alias about='screenfetch'


LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
export LS_COLORS
