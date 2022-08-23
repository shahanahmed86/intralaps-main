create-web-image:
	docker build -t 127.0.0.1:5000/intralaps-web --target web . && \
	docker push 127.0.0.1:5000/intralaps-web
create-mysql-image:
	docker build -t 127.0.0.1:5000/intralaps-mysql --target mysql . && \
	docker push 127.0.0.1:5000/intralaps-mysql
create-server-image:
	docker build -t 127.0.0.1:5000/intralaps-server . && \
	docker push 127.0.0.1:5000/intralaps-server

run-dev-up:
	docker-compose -p intralaps \
	-f docker-compose/docker-compose.yml -f docker-compose/docker-compose.dev.yml \
	up -d
run-dev-up-rebuild:
	docker-compose -p intralaps \
	-f docker-compose/docker-compose.yml -f docker-compose/docker-compose.dev.yml \
	up -d --build
run-dev-down:
	docker-compose -p intralaps \
	-f docker-compose/docker-compose.yml -f docker-compose/docker-compose.dev.yml \
	down
run-dev-down-hard:
	docker-compose -p intralaps \
	-f docker-compose/docker-compose.yml -f docker-compose/docker-compose.dev.yml \
	down -v

run-test-up:
	docker-compose -p intralaps \
	-f docker-compose/docker-compose.yml -f docker-compose/docker-compose.test.yml up \
	--abort-on-container-exit --build
run-test-down:
	docker-compose -p intralaps \
	-f docker-compose/docker-compose.yml -f docker-compose/docker-compose.test.yml \
	down -v

run-prod-up:
	docker stack deploy \
	-c docker-compose/docker-compose.yml -c docker-compose/docker-compose.prod.yml \
	intralaps
run-prod-down:
	docker stack rm intralaps

# only for dev environment
run-migration:
	DATABASE_URL="mysql://root:prisma@localhost:3306/intralaps" npm run db:dev
run-test:
	DATABASE_URL="mysql://root:prisma@localhost:3306/intralaps" npm run --ignore-scripts exec-tests
