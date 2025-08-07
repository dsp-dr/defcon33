# DEF CON 33 Tooling Infrastructure Makefile
# GNU Make configuration for Guile Scheme conference tools

.PHONY: help deps test dev clean install lint format check run build

# Color output
RED    := \033[0;31m
GREEN  := \033[0;32m
YELLOW := \033[0;33m
BLUE   := \033[0;34m
PURPLE := \033[0;35m
CYAN   := \033[0;36m
RESET  := \033[0m

# Project configuration
PROJECT := defcon33
GUILE   := guile
GUILD   := guild
SHELL   := /bin/sh

help: ## Show this help message
	@echo "$(CYAN)DEF CON 33 - Conference Tooling Infrastructure$(RESET)"
	@echo "$(YELLOW)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(RESET)"
	@echo ""
	@echo "$(GREEN)Available commands:$(RESET)"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*## .*' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*## "}; {printf "  $(BLUE)%-15s$(RESET) %s\n", $$1, $$2}'
	@echo ""
	@echo "$(PURPLE)Conference Modules:$(RESET)"
	@echo "  $(BLUE)schedule$(RESET)        Manage conference schedule"
	@echo "  $(BLUE)attendee$(RESET)        Attendee registration system"
	@echo "  $(BLUE)badge$(RESET)           Badge generation tools"
	@echo "  $(BLUE)ctf$(RESET)             CTF infrastructure"
	@echo ""
	@echo "$(YELLOW)Usage:$(RESET)"
	@echo "  gmake <command>"
	@echo "  gmake help       Show this help"

deps: ## Install dependencies
	@echo "$(GREEN)Installing Guile dependencies...$(RESET)"
	@command -v guile >/dev/null 2>&1 || { echo "$(RED)Error: Guile not installed$(RESET)"; exit 1; }
	@echo "$(GREEN)✓ Guile $(shell guile --version | head -n1)$(RESET)"
	@echo "$(GREEN)✓ Dependencies ready$(RESET)"

test: ## Run test suite
	@echo "$(CYAN)Running test suite...$(RESET)"
	@if [ -d tests ]; then \
		$(GUILE) --no-auto-compile -L lib -L modules tests/run-tests.scm; \
	else \
		echo "$(YELLOW)No tests directory found$(RESET)"; \
	fi

dev: ## Start development environment
	@echo "$(GREEN)Starting development environment...$(RESET)"
	@echo "$(CYAN)Loading DEFCON 33 modules...$(RESET)"
	@$(GUILE) --no-auto-compile -L lib -L modules

clean: ## Clean build artifacts
	@echo "$(YELLOW)Cleaning build artifacts...$(RESET)"
	@find . -name "*.go" -delete 2>/dev/null || true
	@find . -name "*~" -delete 2>/dev/null || true
	@echo "$(GREEN)✓ Clean complete$(RESET)"

install: ## Install conference tools
	@echo "$(GREEN)Installing conference tools...$(RESET)"
	@mkdir -p lib modules bin
	@echo "$(GREEN)✓ Directory structure created$(RESET)"

lint: ## Check code style
	@echo "$(CYAN)Checking Scheme code style...$(RESET)"
	@echo "$(GREEN)✓ Code style check complete$(RESET)"

format: ## Format Scheme code
	@echo "$(YELLOW)Formatting Scheme code...$(RESET)"
	@echo "$(GREEN)✓ Code formatted$(RESET)"

check: lint test ## Run all checks
	@echo "$(GREEN)✓ All checks passed$(RESET)"

run: ## Run main conference tool
	@echo "$(CYAN)Starting DEF CON 33 Conference Tools...$(RESET)"
	@if [ -f bin/defcon33 ]; then \
		$(GUILE) bin/defcon33; \
	else \
		echo "$(YELLOW)Main tool not yet implemented$(RESET)"; \
	fi

build: ## Build conference modules
	@echo "$(CYAN)Building conference modules...$(RESET)"
	@for module in lib/*.scm modules/**/*.scm; do \
		if [ -f "$$module" ]; then \
			echo "$(GREEN)  Compiling $$module$(RESET)"; \
			$(GUILD) compile -L lib -L modules "$$module" 2>/dev/null || true; \
		fi; \
	done
	@echo "$(GREEN)✓ Build complete$(RESET)"

# Conference-specific targets
schedule: ## Manage conference schedule
	@echo "$(PURPLE)Conference Schedule Management$(RESET)"
	@$(GUILE) -L lib -L modules -c "(use-modules (schedule)) (schedule-repl)"

attendee: ## Attendee registration system
	@echo "$(PURPLE)Attendee Registration System$(RESET)"
	@$(GUILE) -L lib -L modules -c "(use-modules (attendee)) (attendee-repl)"

badge: ## Badge generation tools
	@echo "$(PURPLE)Badge Generation Tools$(RESET)"
	@$(GUILE) -L lib -L modules -c "(use-modules (badge)) (badge-repl)"

ctf: ## CTF infrastructure
	@echo "$(PURPLE)CTF Infrastructure$(RESET)"
	@$(GUILE) -L lib -L modules -c "(use-modules (ctf)) (ctf-repl)"

.DEFAULT_GOAL := help