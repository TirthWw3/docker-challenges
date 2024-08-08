# Docker Challenges: Full Stack Application and Scaling

## Introduction
This project is part of a series of Docker challenges designed to develop technical skills in using containerization tools like Docker. It covers two challenges: building a full stack application and scaling the application.

## Goals
### Challenge 3: Full Stack Application
- Understand how different components (services) connect.
- Present the environment variables in the application's configuration.
- Produce a `docker-compose.yml` with web server, application, and database working together.

### Challenge 4: Scaling Up an Application
- Scale up the Node.js service from 1 to 3 instances.
- Understand the benefits of having more instances running instead of only one.

## Challenge 3: Full Stack Application

### Steps
1. **Create the .env File:**
   - Create a `.env` file with the appropriate values:
     ```env
     DB_ROOT_PASSWORD=myrootpassword
     DB_DATABASE=mydatabase
     DB_USERNAME=myuser
     DB_PASSWORD=mypassword
     DB_HOST=db
     ```

2. **Create the docker-compose.yml File:**
   - Define three services: `nginx`, `node-service`, and `db`.
     ```yaml
     version: '3.8'
     services:
       nginx:
         image: nginx
         ports:
           - "8080:80"
         depends_on:
           - node-service
       node-service:
         build: ./api
         ports:
           - "3000:3000"
         environment:
           - DB_HOST=${DB_HOST}
           - DB_DATABASE=${DB_DATABASE}
           - DB_USERNAME=${DB_USERNAME}
           - DB_PASSWORD=${DB_PASSWORD}
         depends_on:
           - db
       db:
         image: mariadb:latest
         environment:
           - MYSQL_ROOT_PASSWORD=${DB_ROOT_PASSWORD}
           - MYSQL_DATABASE=${DB_DATABASE}
           - MYSQL_USER=${DB_USERNAME}
           - MYSQL_PASSWORD=${DB_PASSWORD}
         volumes:
           - db_data:/var/lib/mysql
           - ./db/init:/docker-entrypoint-initdb.d
     volumes:
       db_data:
     ```

3. **Verify the Services:**
   - Run `docker-compose up` and ensure all services are running properly.
   - Test the endpoints:
     - `http://localhost:8080/api/books`
     - `http://localhost:8080/api/books/1`

### Expected Outcomes
- Successful responses with JSON data from the database.
- Confirm services are running using `docker-compose ps`.

## Challenge 4: Scaling Up an Application

### Steps

1. **Initial Setup and Testing:**
   - Ensure the application from Challenge 3 is running correctly.
   - Make initial GET requests to `http://localhost:8080/api/stats` and record the hostname before scaling.

2. **Scaling the Node-Service:**
   - Use Docker Compose to scale the `node-service` from 1 to 3 instances.
     ```sh
     docker-compose up --scale node-service=3
     ```

3. **Testing After Scaling:**
   - Make multiple GET requests to `http://localhost:8080/api/stats` to verify different hostnames in the responses, demonstrating the round-robin load balancing.

4. **Verifying the Setup:**
   - Execute the command `docker-compose ps` to show the status of all running services.
     ```sh
     docker-compose ps
     ```

## Conclusion
These challenges demonstrate the ability to set up a full stack application with Docker Compose and scale the service to handle more traffic. The provided steps and configurations help ensure that the application components work together and can be scaled as needed.




Using the API
Adding a Book with Postman
Open Postman and create a new request.
Set up the request:
Method: POST
URL: http://localhost:8080/api/books
Body: raw JSON
json
Copy code
{
  "title": "New Book",
  "author": "New Author"
}
Send the request and verify the response.
Verifying the Addition
Use Postman or your browser to send a GET request to http://localhost:8080/api/books.
Troubleshooting
Containers not starting: Check logs with docker-compose logs [service-name].
Database connection errors: Verify environment variables and database logs.
Port conflicts: Adjust port mappings in docker-compose.yml.
Future Enhancements
User Authentication
Improved Error Handling
Data Validation
Search and Filtering
Pagination
Logging and Monitoring
Unit and Integration Testing
CI/CD Pipeline
Docker Swarm/Kubernetes
API Documentation
Frontend Integration
Caching