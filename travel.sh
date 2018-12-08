#!/bin/bash
# Linux Programming Project
# Travel Booking Service

a=0
busTickets=120
echo "$busTickets"
dialog --textbox busPassenger.txt 20 80

while [ $a -lt 1 ]
input=$(dialog --backtitle "Maharashtra Tours and Travels" --stdout --inputbox "Enter 1 for Bus Booking\nEnter 2 for Cab Booking\nEnter 3 for Exit" 0 0)
echo "$input"

do
case $input in
1)
source=""
destination=""
user=""
date=""

# open fd
exec 3>&1

# Store data to $VALUES variable
VALUES=$(dialog --ok-label "Submit" \
--backtitle "Maharashtra Tours and Travels" \
--title "Enter Details" \
--form "Enter the travel details" \
15 50 0 \
"Passenger Name:" 1 1    "$user"     1 10 10 0 \
"Source:"    2 1    "$source"      2 10 15 0 \
"Destination:"    3 1    "$destination"      3 10 8 0 \
"Date:"     4 1    "$date"     4 10 40 0 \
2>&1 1>&3)
echo "$VALUES"
destdir="busPassenger"

numTickets=$(dialog --backtitle "Maharashtra Tours and Travels" --stdout --inputbox "Enter Number of Tickets You Need\n" 0 0)
busTickets=`expr $busTickets - $numTickets`

dialog --backtitle "Maharashtra Tours and Travels" \
--title "Available Tickets" \
--msgbox "Number of Tickets Available are : ${busTickets}" 10 41

if [ -f "$destdir" ]
then
echo "$VALUES" > "$destdir"
awk 'BEGIN { print ""; ORS = "|"; } {print}' busPassenger >> busPassenger.txt
fi
;;
#############################################################################
2)
sourceCab=""
destinationCab=""
userCab=""
time=""
# open fd
exec 3>&1

# Store data to $VALUES variable

VALUES=$(dialog --ok-label "Submit" \
--backtitle "Maharashtra Tours and Travels" \
--title "Enter Details" \
--form "Enter the travel details" \
15 50 0 \
"Passenger Name:" 1 1    "$userCab"     1 10 10 0 \
"Source:"    2 1    "$sourceCab"      2 10 15 0 \
"Destination:"    3 1    "$destinationCab"      3 10 8 0 \
"Date:"     4 1    "$time"     4 10 40 0 \
2>&1 1>&3)

echo "$VALUES"
destdir="cabPassenger"

numCab=$(dialog --backtitle "Maharashtra Tours and Travels" --stdout --inputbox "Enter Number Persons Travelling in Cab\n" 0 0)

dialog --backtitle "Maharashtra Tours and Travels" \
--title "Cab" \
--msgbox "Cab booked for ${numCab} persons. Pay RS.250" 10 41

if [ -f "$destdir" ]
then
echo "$VALUES" > "$destdir"
awk 'BEGIN { print ""; ORS = "|"; } {print}' cabPassenger >> cabPassenger.txt
fi
;;
###########################################################################
3)
echo "Thank You, Visit Again!!"
break
;;
*)
echo "Invalid Choice"
;;
esac
done
