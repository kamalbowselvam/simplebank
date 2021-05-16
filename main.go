package main

import (
	"database/sql"
	"log"

	"github.com/kamalbowselvam/simple_bank/api"
	db "github.com/kamalbowselvam/simple_bank/db/sqlc"
	"github.com/kamalbowselvam/simple_bank/util"
	_ "github.com/lib/pq"
)

func main() {

	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("cannot load configuration:", err)
	}
	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("Cannot connect to db", err)
	}

	store := db.NewStore(conn)
	server, err := api.NewServer(config, store)

	if err != nil {
		log.Fatal("Cannot create server: ", err)
	}

	err = server.Start(config.ServerAddress)

	if err != nil {
		log.Fatal("cannot start server:", err)
	}
}
