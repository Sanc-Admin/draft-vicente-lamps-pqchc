# Claim Provenance Summary for draft-vicente-lamps-pqchc

Generated: 2026-06-25
Maintainer: Brian Vicente
Organization: Sanctum SecOps LLC
PEN: 1.3.6.1.4.1.65953

## Claim tiers

### Tier 1 — Validated only
These mechanisms are based on standard-defined or draft-defined arcs and support only an "independently implemented and validated" claim.

This includes:
- NIST FIPS 203/204/205 arc material
- draft-defined LAMPS composite/interoperability material

No origin or priority claim is asserted for these mechanisms.

### Tier 2 — Quarantined / excluded from Sanctum-origin claims
The following categories are excluded from any Sanctum-origin claim:
- IANA PKIX Algorithm registry assignments under `1.3.6.1.5.5.7.6.*`
- OQS interoperability root material under `1.3.9999*`

These are third-party or interoperability identifiers and are not published here as Sanctum-originated mechanisms.

### Tier 3 — Sanctum PEN mechanisms with publication-time priority anchors
The following OIDs under `1.3.6.1.4.1.65953` are the mechanisms for which publication-time claim provenance is tracked:

- `1.3.6.1.4.1.65953.1.1.1` — PQCHC-associated mechanism
- `1.3.6.1.4.1.65953.1.100.1` — hash-based auxiliary mechanism

These are tracked as publication-time original PEN assignments with supporting implementation evidence and local prior-art review.

## Composite and hybrid family
The `.1.2.x` family is treated as implementation evidence only.

This includes:
- `1.3.6.1.4.1.65953.1.2.1` — ML-DSA-65 + ECDSA-P256
- `1.3.6.1.4.1.65953.1.2.2` — ML-KEM-768 + X25519
- `1.3.6.1.4.1.65953.1.2.3` — ML-DSA-65 + SLH-DSA-128s

These are classified as validated / EXPERIMENTAL implementations of public hybrid or hedge design patterns. No claim is made here that those constructions are new primitives.

## Priority anchors
The public priority anchor for the PQCHC family is the Internet-Draft:

- `draft-vicente-lamps-pqchc-01`

Related drafts may describe operational or migration context but do not change the non-normative status of these artifacts.

## Caveats
1. Internet-Drafts have no formal standing in the IETF standards process.
2. Artifact presence is evidence of implementation activity, not proof of standardization.
3. EXPERIMENTAL status indicates controlled-environment validation only.
