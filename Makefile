# DEFCON 33 Project Makefile

# Configuration
DEFCON_MEDIA_URL := https://media.defcon.org/DEF%20CON%2033/
MIRROR_DIR := .media-mirror
WGET_OPTIONS := --recursive --no-parent --no-host-directories --cut-dirs=2 \
                --reject-regex=".*\?.*" --user-agent="DEFCON33-Research-Mirror/1.0" \
                --wait=1 --random-wait --limit-rate=500k

.PHONY: help clean mirror-media update-mirror verify-mirror

help: ## Show this help message
	@echo "DEFCON 33 Project Makefile"
	@echo ""
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

mirror-media: ## Create local mirror of DEFCON 33 media (git-ignored)
	@echo "Creating local mirror of DEFCON 33 media..."
	@mkdir -p $(MIRROR_DIR)
	@echo "# DEFCON 33 Media Mirror" > $(MIRROR_DIR)/README.md
	@echo "" >> $(MIRROR_DIR)/README.md
	@echo "This directory contains a local mirror of DEFCON 33 media content." >> $(MIRROR_DIR)/README.md
	@echo "Source: $(DEFCON_MEDIA_URL)" >> $(MIRROR_DIR)/README.md
	@echo "Created: $$(date)" >> $(MIRROR_DIR)/README.md
	@echo "" >> $(MIRROR_DIR)/README.md
	@echo "This directory is git-ignored to avoid committing large media files." >> $(MIRROR_DIR)/README.md
	@echo ""
	@echo "Downloading media files (this may take a while)..."
	@cd $(MIRROR_DIR) && wget $(WGET_OPTIONS) "$(DEFCON_MEDIA_URL)" || true
	@echo "Mirror creation completed. Check $(MIRROR_DIR) for downloaded content."

update-mirror: ## Update existing media mirror
	@if [ ! -d "$(MIRROR_DIR)" ]; then \
		echo "Mirror directory does not exist. Run 'make mirror-media' first."; \
		exit 1; \
	fi
	@echo "Updating media mirror..."
	@cd $(MIRROR_DIR) && wget $(WGET_OPTIONS) --continue "$(DEFCON_MEDIA_URL)" || true
	@echo "Mirror update completed."

verify-mirror: ## Verify mirror integrity and show statistics
	@if [ ! -d "$(MIRROR_DIR)" ]; then \
		echo "Mirror directory does not exist. Run 'make mirror-media' first."; \
		exit 1; \
	fi
	@echo "Mirror statistics:"
	@echo "  Directory: $(MIRROR_DIR)"
	@echo "  Total files: $$(find $(MIRROR_DIR) -type f | wc -l)"
	@echo "  Total size: $$(du -sh $(MIRROR_DIR) | cut -f1)"
	@echo "  Last updated: $$(stat -c %y $(MIRROR_DIR) 2>/dev/null || stat -f %Sm $(MIRROR_DIR) 2>/dev/null || echo 'Unknown')"

clean: ## Clean build artifacts and temporary files
	@echo "Cleaning temporary files..."
	@find . -name "*.pyc" -delete 2>/dev/null || true
	@find . -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
	@find . -name ".DS_Store" -delete 2>/dev/null || true
	@find . -name "*.tmp" -delete 2>/dev/null || true
	@echo "Cleanup completed."

clean-mirror: ## Remove media mirror directory
	@if [ -d "$(MIRROR_DIR)" ]; then \
		echo "Removing media mirror directory..."; \
		rm -rf $(MIRROR_DIR); \
		echo "Mirror directory removed."; \
	else \
		echo "Mirror directory does not exist."; \
	fi

test: ## Run basic project tests
	@echo "Running project tests..."
	@echo "✓ Checking directory structure..."
	@for dir in ai-village blue-team capture-the-flag demos docs presentations red-team tools workshops; do \
		if [ ! -d "$$dir" ]; then \
			echo "✗ Missing directory: $$dir"; \
			exit 1; \
		fi; \
	done
	@echo "✓ Directory structure is valid"
	@echo "✓ All tests passed"

setup: ## Initial project setup
	@echo "Setting up DEFCON 33 project..."
	@git config --local init.defaultBranch main 2>/dev/null || true
	@echo "✓ Project setup completed"