postgres: 
	docker run --name postgres12 --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres12 dropdb --username=root simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost/simple_bank?sslmode=disable" -verbose down


getup:
	docker run --rm -v C:\Users\JWNC9857\Workspace\simplebank\db\migration:/migrations --network host migrate/migrate -path=/migrations/ -database "postgresql://root:secret@localhost/simple_bank?sslmode=disable" up

getdown:
	docker run --rm -v C:\Users\JWNC9857\Workspace\simplebank\db\migration:/migrations --network host migrate/migrate -path=/migrations/ -database "postgresql://root:secret@localhost/simple_bank?sslmode=disable" down -all

sqlc:
	docker run --rm -v C:\Users\JWNC9857\Workspace\simplebank:/src -w /src kjconroy/sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/kamalbowselvam/simple_bank/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test server