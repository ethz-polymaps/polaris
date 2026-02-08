# Makefile for Polaris

# Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
GOFMT=$(GOCMD) fmt
GOVET=$(GOCMD) vet
GOMOD=$(GOCMD) mod

# Lint parameters
LINTCMD=golangci-lint
LINTRUN=$(LINTCMD) run

.DEFAULT_GOAL := help

.PHONY: help
help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: fmt
fmt: ## Run go fmt against code
	$(GOFMT) ./...

.PHONY: vet
vet: ## Run go vet against code
	$(GOVET) ./...

.PHONY: lint
lint: ## Run golangci-lint
	$(LINTRUN)

.PHONY: test
test: ## Run tests
	$(GOCLEAN) -testcache
	$(GOTEST) ./... -race -v

.PHONY: test-coverage
test-coverage: ## Run tests with coverage report
	$(GOTEST) ./... -race -coverprofile=coverage.out
	$(GOCMD) tool cover -html=coverage.out

.PHONY: build
build: ## Build the project
	$(GOBUILD) ./...

.PHONY: clean
clean: ## Remove build artifacts and coverage files
	$(GOCLEAN)
	rm -f coverage.out

.PHONY: tidy
tidy: ## Tidy go modules
	$(GOMOD) tidy

.PHONY: verify
verify: fmt vet lint test ## Run all quality checks (fmt, vet, lint, test)
