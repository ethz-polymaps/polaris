test:
	go clean -testcache
	go test ./... -race

lint:
	golangci-lint run
