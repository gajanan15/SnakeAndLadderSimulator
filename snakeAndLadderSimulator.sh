#!/bin/bash -x
echo "Welcome To Snake And Ladder Simulator"

#constant
NUMBER_OF_PLAYER=1
START_POSITION=0
NO_PLAY=0
LADDER=1
SNAKE=2

#variables
currentPosition=$START_POSITION

function rollingDice() {
	getValue=$((RANDOM%6 + 1))
	echo "After Rolling Dice Number is : "$getValue
	snakeLadderOrNoPlay
}

function snakeLadderOrNoPlay() {
	position=$((RANDOM%3))
	case $position in
		$NO_PLAY)
			currentPosition=$currentPosition
			;;
		$LADDER)
			currentPosition=$(($currentPosition + $getValue))
			;;
		$SNAKE)
			currentPosition=$(($currentPosition - $getValue))
			;;
	esac
	echo "Current Position: "$currentPosition
}
rollingDice
