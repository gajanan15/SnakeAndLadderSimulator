#!/bin/bash
echo "Welcome To Snake And Ladder Simulator"

#constant
NUMBER_OF_PLAYER=1
START_POSITION=0
WINNING_POSITION=100
NO_PLAY=0
LADDER=1
SNAKE=2

#variables
playerCurrentPosition=$START_POSITION

function rollingDice() {
	getValue=$((RANDOM%6 + 1))
	echo "After Rolling Dice Number is : "$getValue
}

function checkForOption() {
	position=$((RANDOM%3))
	case $position in
		$NO_PLAY)
			playerCurrentPosition=$playerCurrentPosition
			;;
		$LADDER)
			playerCurrentPosition=$(( $playerCurrentPosition + $getValue ))
			;;
		$SNAKE)
			playerCurrentPosition=$(( $playerCurrentPosition - $getValue ))
			if [ $playerCurrentPosition -lt $START_POSITION ]
			then
				playerCurrentPosition=$START_POSITION
			fi
			;;
	esac
	echo "Player Current Position: "$playerCurrentPosition
}

while [ $playerCurrentPosition -lt $WINNING_POSITION ]
do
	rollingDice
	checkForOption
done
