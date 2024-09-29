# Makefile for managing PaperMod fork

# Variables
UPSTREAM_URL := https://github.com/adityatelange/hugo-PaperMod.git
UPSTREAM_REMOTE := upstream
MAIN_BRANCH := master

# Ensure the upstream remote is set
.PHONY: ensure-upstream
ensure-upstream:
	@if ! git remote | grep -q $(UPSTREAM_REMOTE); then \
		echo "Adding upstream remote..."; \
		git remote add $(UPSTREAM_REMOTE) $(UPSTREAM_URL); \
	else \
		echo "Upstream remote already exists."; \
	fi

# Fetch updates from upstream
.PHONY: fetch-upstream
fetch-upstream: ensure-upstream
	@echo "Fetching updates from upstream..."
	@git fetch $(UPSTREAM_REMOTE)

# Merge upstream changes
.PHONY: merge-upstream
merge-upstream: fetch-upstream
	@echo "Merging upstream changes..."
	@git checkout $(MAIN_BRANCH)
	@git merge $(UPSTREAM_REMOTE)/$(MAIN_BRANCH)

# Push changes to origin
.PHONY: push-origin
push-origin:
	@echo "Pushing changes to origin..."
	@git push origin $(MAIN_BRANCH)

# Update fork with upstream changes and push to origin
.PHONY: update-fork
update-fork: merge-upstream push-origin
	@echo "Fork updated and pushed to origin."

# Show help
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  ensure-upstream  : Ensure upstream remote is set"
	@echo "  fetch-upstream   : Fetch updates from upstream"
	@echo "  merge-upstream   : Merge upstream changes into current branch"
	@echo "  push-origin      : Push changes to origin"
	@echo "  update-fork      : Update fork with upstream changes and push to origin"
	@echo "  help             : Show this help message"

# Default target
.DEFAULT_GOAL := help
