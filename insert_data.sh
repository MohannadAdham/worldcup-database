#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
# empty the tables
echo $($PSQL "TRUNCATE teams, games;")

# iterate over the records of games.csv and insert into the database
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $WINNER != winner ]]
  then
    # get team_id of winner
    # if not found
      # insert winner as team
    # get team_id of opponent
    # if not found
      # insert opponent as team
  fi
done