postgres: 
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres12 dropdb --username=root --owner=root simple_bank

migrateup:
	migrate -path db/migration: -database "postgresql://root:secret@localhost/simple_bank?sslmode=disable" up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost/simple_bank?sslmode=disable" down


migrateuplocal:
	docker run -v C:\Users\JWNC9857\Workspace\simplebank\db\migration:/migrations --network host migrate/migrate -path=/migrations/ -database "postgresql://root:secret@localhost/simple_bank?sslmode=disable" up

migratedownlocal:
	docker run -v C:\Users\JWNC9857\Workspace\simplebank\db\migration:/migrations --network host migrate/migrate -path=/migrations/ -database "postgresql://root:secret@localhost/simple_bank?sslmode=disable" down

sqlc:
	docker run --rm -v C:\Users\JWNC9857\Workspace\simplebank:/src -w /src kjconroy/sqlc generate

test:
	go test -v -cover ./...

.PHONY: createdb