# Set the color variable
GREEN='\033[0;32m'
RED='\033[0;31m'

# Clear the color after that
ENDCOLOR='\033[0m'

# Check for env file
ENV_FILE=$PWD/.env
if [ ! -f "$ENV_FILE" ]; then
    echo
    echo "There is no ${RED}.env${ENDCOLOR} file in the current directoryR"
    echo
    exit 1
fi

# Check if logged in
if ! RESULT=$(heroku whoami) > /dev/null 2>&1
then
    echo
    echo "Your are ${RED}not logged in${ENDCOLOR} to the Heroku CLI."
    echo "Please make sure you have installed the Heroku CLI and are logged in."
    echo
    exit 1
fi

echo
echo "Logged in as ${GREEN}$RESULT${ENDCOLOR}"
echo

# Get app name from user input
read -p "Enter Heroku app name: " APP_NAME

# Read .env file and upload config vars
heroku config:set $(cat .env | sed '/^$/d; /#[[:print:]]*$/d') --app $APP_NAME