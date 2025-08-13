# Mealwurm

A recipe management system

## Prerequisites

1. [Intellij CE](https://www.jetbrains.com/idea/)
2. [NodeJS](https://nodejs.org/en)
3. [Docker](https://www.docker.com/)
4. (Optional) A DB management tool like [DBeaver](https://dbeaver.io/) or [PGAdmin](https://www.pgadmin.org/)

## Setup

### 1. Rename sample.env.local to .env.local

### 2. Setup Keycloak and DB

The easiest way to do this is to just run `make` from the project root. This will create a database with the requisite realm and client, as well as two users, admin and user (both with passwords 123456).

### 3. Install and run the server

Open `server` in Intellij. Ensure the environment variables in `.env.local` are used in the projeect. Install the maven dependencies and run `ServerApplication.java`

### 4. Install and run client

Navigate to `client` and run `npm install`. Then, run `npm run dev`.
