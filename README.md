# Laravel docker
---
Based on [Digitalocean's laravel docker tutorial]()

## Setup
### Bash script
```bash
  # Give execution permissions
  sudo chmod x+ install_env.sh
  # Help command
  ./install_env.sh -h
  # You can change the setting values directly from the script by using parameters
  ./install_env.sh -n test_project -t test_database -u test_user -p test_password
```
### Manual
1. Copy the `.env` file and rename the following variables as desired
    ```bash
      cp .env.example .env
    ```
    ```bash
      # .env
      APP_NAME=Laravel-Project
                  ...
      DB_DATABASE=laravel_project_database
      DB_USERNAME=laravel_project_user
      DB_PASSWORD=laravel_project_password
    ```
2. Rename `laravel-project` on `docker-compose.yml`
3. Optionally, you can add some SQL code that will be run when the MySQL image creates. To do so, add the code on `./docker/mysql/db_init.sql`
4. Use `docker-compose up -d --build` to build the App, Nginx and MySQL containers
5. Enter on the app container to create a new Laravel Project
   ```bash
    # Create a new Laravel project using composer
    composer create-project --prefer-dist laravel/laravel:^7.0 project
    # move contents to root folder
    mv project/* .
    rm project -Rf
    # Update dependencies, it shouldn't be necessary
    composer update
    # Create a Single Application key to encrypt the session and sensitive data
    php artisan key:generate
   ```
6. All setup, go to `http://YOUR_IP_OR_HOSTNAME:8000` to check if all works correctly
