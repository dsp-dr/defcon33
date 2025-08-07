# DEF CON 33 - Conference Notes and Exploration

[![DEF CON 33](https://img.shields.io/badge/DEF%20CON-33-black?style=for-the-badge&logo=def-con)](https://defcon.org)
[![Guile Scheme](https://img.shields.io/badge/Guile-Scheme-blue?style=for-the-badge&logo=gnu)](https://www.gnu.org/software/guile/)
[![Conference Notes](https://img.shields.io/badge/Conference-Notes-green?style=for-the-badge)](https://github.com/dsp-dr/defcon33)
[![Hacker Culture](https://img.shields.io/badge/Hacker-Culture-purple?style=for-the-badge)](https://github.com/dsp-dr/defcon33)

> Analyzing DEF CON presentations through the lens of Guile Scheme - conference notes, session tools, and hacker culture exploration

## Overview

This repository explores DEF CON 33 through Guile Scheme, documenting:

- Conference session notes and analysis
- Presentation content through a Scheme lens
- Hacker culture and community observations
- Technical demonstrations in functional programming
- Village activities and workshop notes
- Security research methodologies

![DEF CON 33 Logo](defcon-logo.png)

## Quick Start

```bash
# Download presentations from DEF CON media server
gmake mirror

# List AI/LLM related talks
gmake ai-talks

# Analyze presentation topics
gmake analyze

# View/edit analysis notes
gmake notes

# Show all available commands
gmake help
```

## Project Structure

```
defcon33/
├── .mirror/          # Downloaded presentations (gitignored)
├── modules/          # Guile Scheme analysis modules
├── bin/              # Utility scripts
├── ANALYSIS.md       # Conference analysis notes
└── defcon-logo.png   # DEF CON 33 logo
```

## Analysis Focus

- **AI/LLM Security**: Tracking presentations on AI exploitation, LLM vulnerabilities
- **Functional Programming**: Analyzing security concepts through Scheme/Lisp perspective
- **Hacker Culture**: Documenting community insights and technical innovations
- **Emerging Threats**: Identifying new attack vectors and defense strategies

## Requirements

- GNU Guile 3.0+
- GNU Make
- Git

## License

Public repository - Conference notes and educational content