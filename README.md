# DEF CON 33 - Conference Tooling Infrastructure

[![DEF CON 33](https://img.shields.io/badge/DEF%20CON-33-black?style=for-the-badge&logo=def-con)](https://defcon.org)
[![Guile Scheme](https://img.shields.io/badge/Guile-Scheme-blue?style=for-the-badge&logo=gnu)](https://www.gnu.org/software/guile/)
[![Conference Tools](https://img.shields.io/badge/Conference-Tools-green?style=for-the-badge)](https://github.com/dsp-dr/defcon33)
[![Infrastructure](https://img.shields.io/badge/Tooling-Infrastructure-purple?style=for-the-badge)](https://github.com/dsp-dr/defcon33)

> Automated conference management and attendee tools powered by Guile Scheme

## Overview

This repository contains the tooling infrastructure for DEF CON 33, providing automation utilities for:

- Conference schedule management
- Attendee registration and tracking
- Presentation and workshop coordination
- Event automation and notifications
- Badge system integration
- CTF infrastructure support

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

Private repository - Internal use only