#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# Check if an argument was provided
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit
fi

# Determine if the argument is a number or a string
if [[ $1 =~ ^[0-9]+$ ]]
then
  # If it's a number, search by atomic_number
  CONDITION="e.atomic_number = $1"
else
  # If it's a string, search by symbol or name
  CONDITION="e.symbol = '$1' OR e.name = '$1'"
fi

# Fetch element information from the database
ELEMENT_INFO=$($PSQL "SELECT e.atomic_number, e.name, e.symbol, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius FROM elements e JOIN properties p ON e.atomic_number = p.atomic_number JOIN types t ON p.type_id = t.type_id WHERE $CONDITION;")

# Check if the query returned a result
if [[ -z $ELEMENT_INFO ]]
then
  echo "I could not find that element in the database."
else
  # Parse the result and format the output
  echo "$ELEMENT_INFO" | while IFS="|" read ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELTING BOILING
  do
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
  done
fiSun 20 Sep 2026 05:49:05 AM EDT
Sun 20 Sep 2026 05:49:22 AM EDT
Sun 20 Sep 2026 05:49:40 AM EDT
