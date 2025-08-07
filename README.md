![DEF CON 33 Logo](defcon-logo.png)

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

## Features

- **Scheme-Powered Automation**: Built on GNU Guile for powerful, extensible scripting
- **Modular Architecture**: Composable tools that work independently or together
- **Conference-Ready**: Battle-tested tools for managing large-scale technical conferences
- **Security-First**: Designed with DEF CON's security requirements in mind

## Quick Start

```bash
# Install dependencies
gmake deps

# Show available commands
gmake help

# Run tests
gmake test

# Start development environment
gmake dev
```

## Architecture

```
defcon33/
├── bin/              # Executable scripts
├── lib/              # Guile Scheme libraries
├── modules/          # Conference modules
│   ├── schedule/     # Schedule management
│   ├── attendee/     # Attendee systems
│   ├── badge/        # Badge generation
│   └── ctf/          # CTF infrastructure
├── tests/            # Test suites
└── docs/             # Documentation
```

## Requirements

- GNU Guile 3.0+
- GNU Make
- Git

## License

Public repository - Conference notes and educational content