#!/bin/bash

QUIZ_LOCATION=${HOME}'/Documents/gradschool/fall2018/math1310/quizzes'

cd $QUIZ_LOCATION

QUIZ_NUMBER=$(<quizTemplates/quizNumber)

NEW_QUIZ='quiz'$QUIZ_NUMBER

if [ -d "$NEW_QUIZ" ]; then
	echo "The directory $NEW_QUIZ already exists. Either delete it, or check quizTemplates//quiznumber to be sure you are using the correct quiz number."
	exit 1
fi


mkdir $NEW_QUIZ

cp quizTemplates/quizTemplate.tex $NEW_QUIZ/$NEW_QUIZ.tex
sed -i 's_\\newcommand{\\quiznumber}{blank}_\\newcommand{\\quiznumber}{'$QUIZ_NUMBER'}_g' $NEW_QUIZ/$NEW_QUIZ.tex

cp quizTemplates/quizAugTemplate.tex $NEW_QUIZ/$NEW_QUIZ'Aug.tex'
sed -i 's_\\newcommand{\\quiznumber}{blank}_\\newcommand{\\quiznumber}{'$QUIZ_NUMBER'}_g' $NEW_QUIZ/$NEW_QUIZ'Aug.tex'

cp quizTemplates/quizKeyTemplate.tex $NEW_QUIZ/$NEW_QUIZ'Key.tex'
sed -i 's_\\newcommand{\\quiznumber}{blank}_\\newcommand{\\quiznumber}{'$QUIZ_NUMBER'}_g' $NEW_QUIZ/$NEW_QUIZ'Key.tex'

QUIZ_NUMBER=$((QUIZ_NUMBER+1))
echo $QUIZ_NUMBER > quizTemplates/quizNumber
