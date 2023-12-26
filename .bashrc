# ~/.bashrc: executed by bash(1) for non-login shells.
# nano ~/.bashrc
# source ~/.bashrc


# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
export LS_OPTIONS='--color=auto'
eval "$(dircolors)"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
#alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
#export HISTTIMEFORMAT="%d-%m-%y %T "
alias aus="shutdown now"
alias host="hostname -I"
alias iwc="iwconfig"
alias ifc='ifconfig'
alias up="apt update"
alias upg="apt update && apt upgrade -y && apt autoremove -y"
alias cls="clear"
#alias ip='ip addr'
alias nano2='nano -c -S -u' # Nano mit Scroll und Undo

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# Farben und Zeitstempel in History
MY_BASH_BLUE="\033[0;34m" #Blue
MY_BASH_NOCOLOR="\033[0m"
MY_BASH_GREEN="\033[0;32m" #Green
HISTTIMEFORMAT=`echo -e ${MY_BASH_BLUE}[%F - %T] $MY_BASH_GREEN \| $MY_BASH_NOCOLOR`
HISTSIZE=20000
HISTFILESIZE=20000