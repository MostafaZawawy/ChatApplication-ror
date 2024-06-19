# Chat Application

## Prerequisites

- Docker
- Docker Compose

## Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/MostafaZawawy/ChatApplication-ror
   cd ChatApplication

2. Configure Environment Variables
Ensure that you have a .env file in the root of your project with the necessary environment variables. Create a .env file if it doesn't exist and add the following variables:

env
MYSQL_ROOT_PASSWORD=password
MYSQL_DATABASE=myapp_development
MYSQL_USER=user
MYSQL_PASSWORD=password
REDIS_URL=redis://redis:6379/0
DATABASE_URL=mysql2://user:password@db/myapp_development

3. Build and Start the Containers
Use Docker Compose to build and start the containers:

docker-compose build
docker-compose up
This command will build the Docker images and start the services defined in docker-compose.yml.

4. Create and Migrate the Database
Once the containers are up and running, create and migrate the database:

docker-compose run web rails db:create db:migrate
This command runs the rails db:create db:migrate command inside the web container.

5. Access the Application
Open your browser and navigate to http://localhost:3000 to access the application.

## Services
Web: The Rails application running on port 3000.
Database: MySQL database running on the db service.
Redis: Redis server running on the redis service for Sidekiq.
Sidekiq: Background job processor running on the sidekiq service.
Running Tests

To run tests, use the following command:

docker-compose run web rails test
This command runs the test suite inside the web container.

## Troubleshooting
Viewing Logs
If you encounter any issues, you can check the logs for each service:

docker-compose logs web
docker-compose logs db
docker-compose logs redis
docker-compose logs sidekiq

Common Issues
Database Connection Error: If you encounter a database connection error, ensure that the database service is running and the environment variables in the .env file are correctly set.

Sidekiq Not Processing Jobs: If Sidekiq is not processing jobs, ensure that the Redis service is running and the REDIS_URL environment variable is correctly set.

### Stopping the Application
To stop the application, use the following command:
docker-compose down
