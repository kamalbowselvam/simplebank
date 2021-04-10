package api

import (
	"github.com/gin-gonic/gin"
	db "github.com/kamalbowselvam/simple_bank/db/sqlc"
)

// serve http request for banking service

type Server struct {

	store *db.Store
	router *gin.Engine
}


func NewServer(store *db.Store) *Server  {

	server := &Server{store: store}
	router := gin.Default()


	// create a new routes here to handle them 
	router.POST("/accounts", server.createAccount)
	router.GET("/accounts/:id", server.getAccount)
	router.GET("/accounts",server.listAccount)
	server.router = router
	return server
	
}


// start running the Http server on a specific address
func (server *Server) Start(address string) error {

	return server.router.Run(address)
	
}

func errorResponse(err error) gin.H {
	return gin.H{"error": err.Error()}
	
}