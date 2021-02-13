################################################################################
# Help                                                                         #
################################################################################
Help()
{
  echo "----------------------------------------------------"
  echo "Use the following parameters to modify automatically all the required environment settings:"
  echo "  n: Project name"
  echo "  t: Database table name"
  echo "  u: Database user name"
  echo "  p: Database user password (root and normal user)"
  echo "  h: Help"
  echo "----------------------------------------------------"
  exit
}
################################################################################

################################################################################
# Get parameters                                                               #
################################################################################
while getopts n:t:u:p:h flag
do
    case "${flag}" in
        n) project_name=${OPTARG};;
        t) db_table=${OPTARG};;
        u) db_user=${OPTARG};;
        p) db_password=${OPTARG};;
        h) Help;;
    esac
done

################################################################################
# Start installation                                                           #
################################################################################
echo "---  Overwritting settings  ---"

# Copy .env file from example
cp .env.example .env

# Project name
if [ -n "$project_name" ]; then
  echo "Setting $project_name (-n) on DB_DATABASE from .env and on docker-compose.yml"
  sed -i "s/APP_NAME=Laravel-Project/APP_NAME=$project_name/" .env
  sed -i "s/laravel-project/$project_name/" docker-compose.yml
else
  echo "'project_name' (-n) parameter not given, using default 'Laravel Project'"
fi

# DB Table name
if [ -n "$db_table" ]; then
  echo "Setting '$db_table' (-t) on DB_DATABASE from .env"
  sed -i "s/DB_DATABASE=laravel_project_database/DB_DATABASE=$db_table/" .env
else
  echo "'db_table' (-t) parameter not given, using default 'laravel_project_database'"
fi

# DB Table user
if [ -n "$db_user" ]; then
  echo "Setting '$db_user' (-u) on DB_DATABASE from .env"
  sed -i "s/DB_USERNAME=laravel_project_user/DB_USERNAME=$db_user/" .env
else
  echo "'db_table' (-u) parameter not given, using default 'laravel_project_user'"
fi

# DB Table password
if [ -n "$db_password" ]; then
  echo "Setting '$db_password' (-p) on DB_DATABASE from .env"
  sed -i "s/DB_PASSWORD=laravel_project_password/DB_PASSWORD=$db_password/" .env
else
  echo "'db_table' (-p) parameter not given, using default 'laravel_project_password'"
fi
echo "------------------------------"

echo "---     Creating images     ---"
docker-compose --log-level ERROR up -d --build

echo "--- Installing Dependencies ---"
docker-compose exec app composer create-project --prefer-dist laravel/laravel:^7.0 project
docker-compose exec app mv project/* .
docker-compose exec app rm project -Rf
docker-compose exec app composer update
docker-compose exec app php artisan key:generate
echo "-------------------------------"
echo " Setup finished, happy coding! "
echo "-------------------------------"
################################################################################
