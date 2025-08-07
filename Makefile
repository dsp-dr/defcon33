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
	@echo "$(CYAN)DEF CON 33 - Presentation Analysis & Notes$(RESET)"
	@echo "$(YELLOW)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(RESET)"
	@echo ""
	@echo "$(GREEN)Available commands:$(RESET)"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*## .*' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*## "}; {printf "  $(BLUE)%-15s$(RESET) %s\n", $$1, $$2}'
	@echo ""
	@echo "$(PURPLE)Analysis Tools:$(RESET)"
	@echo "  $(BLUE)ai-talks$(RESET)        List AI/LLM related presentations"
	@echo "  $(BLUE)analyze$(RESET)         Analyze presentations for topics"
	@echo "  $(BLUE)notes$(RESET)           View analysis notes"
	@echo ""
	@echo "$(YELLOW)Usage:$(RESET)"
	@echo "  gmake <command>"
	@echo "  gmake help       Show this help"

deps: ## Install dependencies
	@echo "$(GREEN)Installing Guile dependencies...$(RESET)"
	@command -v guile >/dev/null 2>&1 || { echo "$(RED)Error: Guile not installed$(RESET)"; exit 1; }
	@echo "$(GREEN)✓ Guile $(shell guile --version | head -n1)$(RESET)"
	@echo "$(GREEN)✓ Dependencies ready$(RESET)"

ai-talks: ## List AI/LLM related presentations
	@echo "$(CYAN)AI/LLM Related Presentations:$(RESET)"
	@echo "$(YELLOW)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(RESET)"
	@ls .mirror/ 2>/dev/null | grep -iE "ai|llm|gpt|machine|learn|neural|model" || echo "Run 'gmake mirror' first"

analyze: ## Analyze presentation topics
	@echo "$(PURPLE)Analyzing DEF CON 33 Presentations...$(RESET)"
	@echo "Total presentations: $$(ls .mirror/*.pdf 2>/dev/null | wc -l)"
	@echo "AI/ML talks: $$(ls .mirror/*.pdf 2>/dev/null | grep -iE 'ai|llm|gpt|machine|learn|neural|model' | wc -l)"
	@echo "Crypto talks: $$(ls .mirror/*.pdf 2>/dev/null | grep -iE 'crypto|cipher|encryption' | wc -l)"
	@echo "Network talks: $$(ls .mirror/*.pdf 2>/dev/null | grep -iE 'network|tcp|udp|protocol' | wc -l)"

notes: ## View/edit analysis notes
	@echo "$(CYAN)DEF CON 33 Analysis Notes$(RESET)"
	@if [ -f ANALYSIS.md ]; then \
		cat ANALYSIS.md; \
	else \
		echo "$(YELLOW)No analysis notes yet. Creating...$(RESET)"; \
		echo "# DEF CON 33 Analysis Notes\n\n## AI/LLM Presentations\n\n## Key Insights\n" > ANALYSIS.md; \
	fi

clean: ## Clean build artifacts
	@echo "$(YELLOW)Cleaning build artifacts...$(RESET)"
	@find . -name "*.go" -delete 2>/dev/null || true
	@find . -name "*~" -delete 2>/dev/null || true
	@echo "$(GREEN)✓ Clean complete$(RESET)"

list: ## List all downloaded presentations
	@echo "$(CYAN)Downloaded Presentations:$(RESET)"
	@echo "$(YELLOW)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(RESET)"
	@ls -1 .mirror/*.pdf 2>/dev/null | sed 's|.mirror/||' | sed 's/.pdf//' || echo "No presentations yet. Run 'gmake mirror'"

mirror: ## Mirror DEF CON 33 presentations only
	@echo "$(CYAN)Mirroring DEF CON 33 Presentations...$(RESET)"
	@echo "$(YELLOW)This will download presentations to .mirror/$(RESET)"
	@mkdir -p .mirror
	@cd .mirror && \
		wget -r -np -nH --cut-dirs=2 -R "index.html*" \
		--accept "*.pdf,*.pptx,*.ppt,*.odp" \
		"https://media.defcon.org/DEF%20CON%2033/DEF%20CON%2033%20presentations/"
	@echo "$(GREEN)✓ Presentations mirrored to .mirror/$(RESET)"

sessions: ## Show tomorrow's core sessions
	@echo "$(PURPLE)Tomorrow's Core Sessions$(RESET)"
	@echo "$(YELLOW)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(RESET)"
	@$(GUILE) -L modules -c "(use-modules (sessions core)) (for-each display-session (core-sessions))"

# Non-phony target for logo
defcon-logo.png:
	@echo "$(CYAN)Downloading DEF CON 33 logo...$(RESET)"
	@wget -q -O defcon-logo.webp "https://media.defcon.org/DEF%20CON%2033/DEF%20CON%2033%20logo-1.webp"
	@echo "$(YELLOW)Converting to PNG...$(RESET)"
	@convert defcon-logo.webp defcon-logo.png
	@rm defcon-logo.webp
	@echo "$(GREEN)✓ Logo saved as defcon-logo.png$(RESET)"

defcon-logo: defcon-logo.png ## Download and convert DEF CON 33 logo

.DEFAULT_GOAL := help