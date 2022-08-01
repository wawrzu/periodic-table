#!/bin/bash

#Periodic table reader

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
if [[ -z $1 ]]
  then
  echo -e "Please provide an element as an argument."
else
  RE='^[0-9]+$'
  if [[ $1 =~ $RE ]]
    then
    NUMBER=$($PSQL "SELECT atomic_number FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$1")
    SYMBOL=$($PSQL "SELECT symbol FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$1")
    NAME=$($PSQL "SELECT name FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$1")
    TYPE=$($PSQL "SELECT type FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$1")
    MASS=$($PSQL "SELECT atomic_mass FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$1")
    MELTING=$($PSQL "SELECT melting_point_celsius FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$1")
    BOILING=$($PSQL "SELECT boiling_point_celsius FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$1")
    if [[ -z $NUMBER ]]
      then
      echo -e "I could not find that element in the database."
    else
      echo -e "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    fi
  else
    NUMBER=$($PSQL "SELECT atomic_number FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol='$1' OR name='$1'")
    SYMBOL=$($PSQL "SELECT symbol FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol='$1' OR name='$1'")
    NAME=$($PSQL "SELECT name FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol='$1' OR name='$1'")
    TYPE=$($PSQL "SELECT type FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol='$1' OR name='$1'")
    MASS=$($PSQL "SELECT atomic_mass FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol='$1' OR name='$1'")
    MELTING=$($PSQL "SELECT melting_point_celsius FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol='$1' OR name='$1'")
    BOILING=$($PSQL "SELECT boiling_point_celsius FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol='$1' OR name='$1'")
    if [[ -z $NUMBER ]]
      then
      echo -e "I could not find that element in the database."
    else
      echo -e "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    fi
  fi
fi