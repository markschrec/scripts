#!/bin/bash

DIR=""
if [ "$#" = 0 ]; then
	DIR=$PWD
else
	DIR=$1
fi

cd "$DIR"

MATCHES=$(find . -maxdepth 1 -regex ".*quiz[0-9]+\.tex" | wc -w)

if [ "$MATCHES" = 0 ]; then
	echo "No quiz file found."
	exit 1
fi

if [ "$MATCHES" -gt 1 ]; then
	echo "Command Ambigouous. Too many files named \"quizN.tex\" in directory."
	exit 1
fi

#Gets the *unique* quizN.tex file name from the desired directory
QUIZ_NAME=$(find . -maxdepth 1 -regex ".*quiz[0-9]+\.tex")

#removes any text in the key between the markers from old versions of the quiz
sed -i '/%beginQuestion1/,/%endQuestion1/{//!d}' $(echo "$QUIZ_NAME" | sed 's_\.tex_Key\.tex_g')
sed -i '/%beginQuestion2/,/%endQuestion2/{//!d}' $(echo "$QUIZ_NAME" | sed 's_\.tex_Key\.tex_g')

#gets and inserts the question text from the quiz to the key
QUESTION_TEXT=$(awk '/%beginQuestion1/{flag=1;next}/%endQuestion1/{flag=0}flag' "$QUIZ_NAME")
echo "$QUESTION_TEXT" | sed -i "/%beginQuestion1/r /dev/stdin"  $(echo "$QUIZ_NAME" | sed 's_\.tex_Key\.tex_g')
QUESTION_TEXT=$(awk '/%beginQuestion2/{flag=1;next}/%endQuestion2/{flag=0}flag' "$QUIZ_NAME")
echo "$QUESTION_TEXT" | sed -i "/%beginQuestion2/r /dev/stdin"  $(echo "$QUIZ_NAME" | sed 's_\.tex_Key\.tex_g')

#Need to do a little more testing, see if I can remove duplicate code
#format the quiz so I can have an arbitrary number of questions
