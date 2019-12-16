#!/bin/bash
function usage {
	clear
	echo "**************************"
	echo -e "* $1 parameters detected *"
	echo "**************************"
	echo "Syntax -> ./$0 PORT HOST ACTION"
	echo "Example: ./$0 8080 www.example.com scan" 
}

if [ $# -le 3 ]
then
	if [ $# -eq 1 ]
	then
		echo "The number of parameters is $#"
		echo "You need two additional parameters"
		sleep 2
		usage "$#"
	elif [ $# -eq 2 ]
        then
                echo "The number of parameters is $#"
                echo "You need one additional parameters"
                sleep 2
                usage "$#"
	elif [ $# -eq 3 ]
	then
                echo "The number of parameters is $# -> CORRECT!"
                exit 0
	else
                echo "The number of parameters is $#"
                echo "You need to specify 3 parameters"
                sleep 2
                usage "$#"

	fi
else
	echo "Too many parameters"; sleep 2
	usage "$#"
fi
