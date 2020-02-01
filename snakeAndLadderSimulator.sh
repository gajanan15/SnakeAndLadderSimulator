#!/bin/bash -x
echo "Welcome To Snake And Ladder Simulator"

#constant
PLAYER_ONE=0
PLAYER_TWO=1
START_POSITION=0
WINNING_POSITION=100
NO_PLAY=0
LADDER=1
SNAKE=2

#variables
playerCurrentPosition=$START_POSITION
playerOnePosition=0
playerTwoPosition=0
diceCount=0
flag=0

function rollingDice() {
	rollValue=$((RANDOM%6+1))
	((diceCount++))
} 

function checkForOption() {
	position=$((RANDOM%3))
	playerCurrentPosition=$1
	case $position in
		$NO_PLAY)
			playerCurrentPosition=$playerCurrentPosition
			;;
		$LADDER)
			playerCurrentPosition=$(( $playerCurrentPosition + $2 ))
			;;
		$SNAKE)
			playerCurrentPosition=$(( $playerCurrentPosition - $2 ))
			;;
	esac
	echo $playerCurrentPosition
}

function reachExactPosition() {
	playerPosition=$1
	if [ $playerPosition -lt 0 ]
	then
		playerPosition=$START_POSITION
	fi
	if [ $playerPosition -gt $WINNING_POSITION ]
	then
		playerPosition=$(( $playerPosition - $2 ))
	fi
	echo $playerPosition
}

function switchTurnsOfPlayers() {
	while [[ $playerOnePosition -ne $WINNING_POSITION && $playerTwoPosition -ne $WINNING_POSITION ]]
	do
		if [ $flag -eq 0 ]
		then
			rollingDice
			firstPlayerPosition=$( checkForOption $playerOnePosition $rollValue )
			playerOnePosition=$( reachExactPosition $firstPlayerPosition $rollValue )
			flag=1
		else
			rollingDice
			secondPlayerPosition=$( checkForOption $playerTwoPosition $rollValue )
			playerTwoPosition=$( reachExactPosition $secondPlayerPosition $rollValue )
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
