#!/bin/bash -x
echo "Welcome To Snake And Ladder Simulator"

#constant
START_POSITION=0
WINNING_POSITION=100
NO_PLAY=0
LADDER=1
SNAKE=2

#variables
playerCurrentPosition=$START_POSITION
playerOnePosition=$START_POSITION
playerTwoPosition=$START_POSITION
diceCount=0
flag=0

function rollingDice() {
	rollValue=$((RANDOM%6+1))
	((diceCount++))
	checkForOption
}

function checkForOption() {
	position=$((RANDOM%3))
	case $position in
		$NO_PLAY)
			playerCurrentPosition=$playerCurrentPosition
			;;
		$LADDER)
			playerCurrentPosition=$(( $playerCurrentPosition + $rollValue ))
			if [ $playerCurrentPosition -gt $WINNING_POSITION ]
			then
				playerCurrentPosition=$(( $playerCurrentPosition - $rollValue ))
			fi
			;;
		$SNAKE)
			playerCurrentPosition=$(( $playerCurrentPosition - $rollValue ))
			if [ $playerCurrentPosition -lt $START_POSITION ]
			then
				playerCurrentPosition=$START_POSITION
			fi
			;;
	esac
	echo $playerCurrentPosition
}

function switchTurnsOfPlayers() {
	while [[ $playerCurrentPosition -ne $WINNING_POSITION ]]
	do
		if [ $flag -eq 0 ]
		then
			playerCurrentPosition=$playerOnePosition
			rollingDice
			playerOnePosition=$playerCurrentPosition
			flag=1
		else
			playerCurrentPosition=$playerTwoPosition
			rollingDice
			playerTwoPosition=$playerCurrentPosition
			flag=0
		fi
	done
	checkWinner
}

function checkWinner() {
	if [ $playerOnePosition -eq $WINNING_POSITION ]
	then
		echo "Player one win"
		echo "Number Of Time Dice Tossed Player one: " $(($diceCount + 1))
	else
		echo "Player Two win"
		echo "Number Of Time Dice Tossed Player Two: " $diceCount
	fi
}

switchTurnsOfPlayers
