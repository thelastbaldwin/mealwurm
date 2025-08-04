# Mealwyrm

A recipe management system

## Prerequisites

1. [Intellij CE](https://www.jetbrains.com/idea/)
2. [NodeJS](https://nodejs.org/en)
3. [Docker](https://www.docker.com/)
4. (Optional) A DB management tool like [DBeaver](https://dbeaver.io/) or [PGAdmin](https://www.pgadmin.org/)

## Setup

### 1. Setup an Auth0 API

Create an auth0 application. You will need a few configuration values for the server and client to run. These can be found in their respective README files and on the main settings of the auth0 application.

### 2. Install the DB

From the project root run `docker compose up -d`. This will create the `mealwyrm_db` postgres container. You can find the db credentials, name, and mapped port within `docker-compose.yml`

### 3. Install and run the server

Open the `mealwyrm-server` in Intellij. Create a `local.env` file with the variables listed in `README.md`. Install the maven dependencies and run `ServerApplication.java`

### 4. Install and run client

Navigate to `mealwyrm-client` and run `npm install`. Create a `.env.local` file with the required environment variables listed in `README.md`. Run `npm run dev`.
