#!/bin/bash

# Farbcodes fur Magenta und Blau
MAGENTA='\e[35m' # Magenta
BLUE='\e[34m' #Blue
NC='\e[0m'  # Normal Color

# ASCII-Art mit "WWLabs" und "HomeLabs Inc."

echo -e "${NC} "
echo -e "${NC} "

echo -e "${MAGENTA}*********************************************************************"
echo -e "${MAGENTA}*                                                                   ${MAGENTA}*"
echo -e "${MAGENTA}* :::  ${BLUE}===  === ${MAGENTA}:::  ${BLUE}===  === ${MAGENTA}:::      :::${BLUE}====  ${MAGENTA}:::${BLUE}====  ${MAGENTA}:::===     ${MAGENTA}*"
echo -e "${MAGENTA}* :::  ${BLUE}===  === ${MAGENTA}:::  ${BLUE}===  === ${MAGENTA}:::      :::  ${BLUE}=== ${MAGENTA}:::  ${BLUE}=== ${MAGENTA}:::        ${MAGENTA}*"
echo -e "${MAGENTA}* ${BLUE}===  ===  === ===  ===  === ===      ======== =======   =====     ${MAGENTA}*"
echo -e "${MAGENTA}*  ${BLUE}===========   ===========  ===      ===  === ===  ===     ===    ${MAGENTA}*"
echo -e "${MAGENTA}*   ${BLUE}==== ====     ==== ====   ======== ===  === =======  ======     ${MAGENTA}*"
echo -e "${MAGENTA}*                                                                   ${MAGENTA}*"
echo -e "${MAGENTA}* :::  ${BLUE}=== ${MAGENTA}:::${BLUE}====  ${MAGENTA}:::${BLUE}=======  ${MAGENTA}:::${BLUE}===== ${MAGENTA}:::      :::${BLUE}====  ${MAGENTA}:::${BLUE}====  ${MAGENTA}*"
echo -e "${MAGENTA}* :::  ${BLUE}=== ${MAGENTA}:::  ${BLUE}=== ${MAGENTA}::: ${BLUE}=== === ${MAGENTA}:::      ${MAGENTA}:::      :::  ${BLUE}=== ${MAGENTA}:::  ${BLUE}=== ${MAGENTA}*"
echo -e "${MAGENTA}* ${BLUE}======== ===  === === === === ======   ===      ======== =======  ${MAGENTA}*"
echo -e "${MAGENTA}* ${BLUE}===  === ===  === ===     === ===      ===      ===  === ===  === ${MAGENTA}*"
echo -e "${MAGENTA}* ${BLUE}===  ===  ======  ===     === ======== ======== ===  === =======  ${MAGENTA}*"
echo -e "${MAGENTA}*                                                                   ${MAGENTA}*"
echo -e "${MAGENTA}*********************************************************************"

echo -e "${NC} "
echo -e "${BLUE} all Copyrights belongs to ${MAGENTA}®© wwlabs.cc ${NC}♛ 📨 ${BLUE}info@wwlabs.cc"
echo -e "${NC} "
ip a | grep /22
echo -e "${NC} "

neofetch

echo -e "${NC} "
echo -e "${NC} "
