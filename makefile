# use this to initialize the database and set up keycloak
# if you want to seed the database, be sure you have a dump file in db/init
init-db-keyloak:
	docker compose --env-file .env.local up -d

# use this to create a database backup. This will not be under version control. 
backup-db:
	mkdir -p .db/init
	docker exec mealwurm_db pg_dump -U mealwurm -p 5432 mealwurm > db/init/init.sql
