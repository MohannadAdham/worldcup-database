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
    WINNER_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    echo WINNER_TEAM_ID: $WINNER_TEAM_ID
    # if not found
    if [[ -z $WINNER_TEAM_ID ]]
    then
      # insert winner as team
      INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams (name) VALUES ('$WINNER');")
      echo $INSERT_WINNER_RESULT
      if [[ $INSERT_WINNER_RESULT == 'INSERT 0 1' ]]
      then
        echo Inserted into teams the winner, $WINNER
      fi
    fi
    # get team_id of opponent
    OPPONENT_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
    # if not found
    if [[ -z $OPPONENT_TEAM_ID ]]
    then
      # insert opponent as team
      INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams (name) VALUES ('$OPPONENT');")
      if [[ $INSERT_OPPONENT_RESULT == 'INSERT 0 1' ]]
      then
        echo Inserted into teams the opponent, $OPPONENT
      fi
    fi
  fi
done
