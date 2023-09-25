#!/bin/bash

plateau="123456789"
# x=${plateau:1:3}
# echo $x
J1="x"
J2="o"


function display_grid {
  echo ______
  echo \| ${plateau:0:3} \|
  echo \| ${plateau:3:3} \|
  echo \| ${plateau:6:3} \|
  echo ______
}

function change_letter {
  plateau=${plateau/$1/$2}
  echo $plateau
}

function que_lettre {
	R=$(echo $plateau | tr -d [:alpha:])
	if [[ -z $R ]]; then
		echo 0
	else
		echo 1
	fi

}

function only_same { #argument of type "xxx" "xox" "ooo"
	S=$(echo "$1" | cut -c 1) #S = x
	if [[ "$1" =~ ^${S}*$ ]] ; then
		echo 1
	else
		echo 0
	fi
}

function est_fini {
	#in a line :
	if [[ $(only_same ${plateau:0:3}) == 1 || $(only_same ${plateau:3:3}) == 1 || $(only_same ${plateau:6:3}) == 1 ]]; then
		echo 1
	fi
	#in a column :
	col1=${plateau:0:1}${plateau:3:1}${plateau:6:1}
	col2=${plateau:1:1}${plateau:4:1}${plateau:7:1}
	col3=${plateau:2:1}${plateau:5:1}${plateau:8:1}
	if [[ $(only_same $col1) == 1 || $(only_same $col2) == 1 || $(only_same $col3) == 1 ]]; then
		echo 1
	fi
	#in diagonal :
	diago1=${plateau:0:1}${plateau:4:1}${plateau:8:1}
	diago2=${plateau:2:1}${plateau:4:1}${plateau:6:1}
	if [[ $(only_same $diago1) == 1 || $(only_same $diago2) == 1 ]]; then
		echo 1
	fi
	#if there are no more numbers in $plateau : return 1
	R=$(que_lettre)
	if [[ $R == 0 ]]; then
		echo 1
	fi
}

function play {

  echo Welcome on the tictactoe game.
  echo Player 1 will be playing as x
  echo Player 2 will be playing as o
  CJ=1
  while true; 
  do
	if [ $CJ == 1 ]; then #changing the character for the players
		turn="x"
	else
		turn="o"
	fi

	display_grid #displays the grid
	echo Where does P$CJ want to play?
	read -p "I want to play : " pion #position of the mark = var 'pion'
	change_letter $pion "$turn"
	if [[ $(est_fini) == 1 ]]; then #if the game is over
		display_grid
		break
	fi

	if [ $CJ -eq 1 ]; then #changing the player
		CJ=2
	else
		CJ=1
	fi
  done
}

play
