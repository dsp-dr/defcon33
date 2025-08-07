# DEF CON 33 Analysis Notes

## AI/LLM Security Presentations

### Key Talks on AI/ML Exploitation

1. **"Loading Models, Launching Shells: Abusing AI File Formats for Code Execution"** - Cyrus Parzian
   - Focus on exploiting AI model file formats for arbitrary code execution
   - Critical for understanding supply chain attacks via ML models
   - Implications for model sharing platforms and ML pipelines

2. **"Invitation Is All You Need: Invoking Gemini for Workspace Agents with a Simple Google Calendar Invite"** - Ben Nassi, Or Yair, Stav Cohen
   - Novel attack vector using calendar invites to trigger AI agents
   - Demonstrates social engineering meets AI exploitation
   - Shows how benign features become attack surfaces with AI integration

3. **"Hackers Dropping Mid-Heist Selfies: LLM Identifies Information Stealer Infection Vector and Extracts IoCs"** - Olivier Bilodeau, Estelle Ruellan
   - Using LLMs for defensive security analysis
   - Automated IoC extraction from malware samples
   - Demonstrates positive security applications of LLMs

4. **"Voice Cloning Air Traffic Control Vulnerabilities at Runway Crossings"** - Andrew Logan
   - Audio deepfake threats to critical infrastructure
   - Real-world implications of voice synthesis attacks
   - Safety-critical systems vs AI-generated content

## Automation & Analysis Topics

- **"De-Virtualizing the Dragon: Automated Unpacking and Deobfuscation"** - Agostino Panico
  - Symbolic execution and taint tracking for automated analysis
  - Could be reimplemented in functional programming paradigm

- **"Jailbreaking the Hivemind: Finding and Exploiting Kernel Vulnerabilities"** - Agostino Panico
  - eBPF subsystem exploitation
  - Distributed system vulnerabilities

## Functional Programming Relevance

### Concepts Applicable to Scheme/Lisp:
- Symbolic execution (naturally fits s-expression manipulation)
- Taint tracking (can be modeled with monadic approaches)
- Pattern matching for IoC extraction
- Formal verification of AI model behaviors

## Key Takeaways

1. **AI Attack Surface Expansion**: Every AI integration point becomes a potential vulnerability
2. **Supply Chain Risks**: Model files are code - treat them as such
3. **Social Engineering Evolution**: AI agents can be manipulated through their training/prompting
4. **Defensive AI Use**: LLMs effective for security analysis and IoC extraction

## Research Directions

- Implement symbolic execution engine in Guile Scheme for malware analysis
- Create functional programming patterns for taint tracking
- Build LLM interaction safety checks using formal methods
- Develop Scheme-based tools for AI model format parsing

## Notable Quotes & Insights

*To be filled as presentations are analyzed in detail*

---

*Last Updated: August 2025*