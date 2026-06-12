# Single Source of Truth and Authority Model

## Purpose

This document defines which source wins when documentation, repository state and operational summaries disagree.

## Authority hierarchy

1. Governance repository documentation
2. Current repository state
3. Approved issue / pull request history
4. Operational summaries
5. Informal notes or chat history

## Rule

If conflict exists, governance docs and repository state override informal summaries.

## Why this matters

AI-generated summaries and operational notes can drift.

The repository must remain the source of enforceable truth for:

- code
- configuration
- scripts
- validation
- governance policies
- evidence templates
