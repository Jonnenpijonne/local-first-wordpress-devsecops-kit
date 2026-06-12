#!/usr/bin/env python3
from __future__ import annotations

import hashlib
import sys


def stable_pseudonym(value: str, seed: str = "project_seed") -> str:
    return hashlib.sha256(f"{seed}:{value}".encode("utf-8")).hexdigest()[:12]


def main() -> int:
    if len(sys.argv) < 2:
        print("Usage: anonymize-placeholder.py <value>")
        return 1
    print(stable_pseudonym(sys.argv[1]))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
