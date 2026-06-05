#!/usr/bin/env python3
"""validate_asn1.py
Structural validator for the PQCHC ASN.1 module.
Checks that required identifiers and SEQUENCE definitions are present.
Does NOT perform full ASN.1 compilation (no asn1c dependency required).

Usage: python3 tools/validate_asn1.py ASN.1/pqchc-2026.asn1
"""
import sys
import re

REQUIRED_IDENTIFIERS = [
    r"PQCHCommitment",
    r"FutureKeyCommitment",
    r"commitmentValid",
    r"committedAlgorithm",
    r"futureKeyCommitment",
    r"commitmentNotAfter",
    r"hashAlgorithm",
    r"spkiHash",
    r"id-pe-pqchc-experimental",
    r"65953",  # PEN arc sanity check
]

def validate(path: str) -> None:
    with open(path) as fh:
        src = fh.read()
    failures = []
    for ident in REQUIRED_IDENTIFIERS:
        if not re.search(ident, src):
            failures.append(f"  MISSING: {ident}")
    if failures:
        print("ASN.1 VALIDATION FAILED:")
        for f in failures:
            print(f)
        sys.exit(1)
    print(f"  All {len(REQUIRED_IDENTIFIERS)} required identifiers present.")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <asn1-file>")
        sys.exit(1)
    validate(sys.argv[1])
