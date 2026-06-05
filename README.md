# draft-vicente-lamps-pqchc

**IETF Internet-Draft: PQC Hybrid Commitment (PQCHC) X.509 Extension**

| Field | Value |
|---|---|
| Draft name | `draft-vicente-lamps-pqchc-00` |
| Working Group | LAMPS (Limited Additional Mechanisms for PKIX and SMIME) |
| Area | Security |
| Status | Individual Submission — Informational |
| Author | Brian Vicente, Sanctum SecOps LLC |
| Target WG list | `spasm@ietf.org` |
| Datatracker | https://datatracker.ietf.org/doc/draft-vicente-lamps-pqchc/ |

## What This Draft Does

Defines the **PQCHC X.509 v3 extension** — a non-critical, backward-compatible
extension that allows a certificate subject to make a cryptographically bound
forward commitment to the specific post-quantum or PQ/T hybrid key material they
intend to present in their *next* certificate renewal. PQCHC-aware relying parties
can detect downgrade-at-renewal attacks where an adversary substitutes a classical
certificate during the PQC migration window.

## Key Features

- `FutureKeyCommitment` — SHA-384/SHA-512 hash of the future SPKI, CA-signed at issuance
- `committedAlgorithm` — AlgorithmIdentifier for the intended PQ algorithm (ML-DSA, SLH-DSA, composite)
- `commitmentNotAfter` — machine-processable expiry deadline for the commitment
- `commitmentValid` — explicit rescission flag
- ACME-ARI integration (RFC 9773) for scheduled commitment-aware renewal
- Non-critical per RFC 5280; legacy relying parties unaffected

## Repository Structure

```
draft-vicente-lamps-pqchc-00.md   # Master RFCXML/markdown source
ASN.1/
  pqchc-2026.asn1                 # ASN.1 module
tools/
  verify.sh                       # Verification & build script (kramdown-rfc / xml2rfc)
  validate_asn1.py                # ASN.1 structural validator
  qs_dev_plugin.md                # QuantaScript QS-dev integration spec
CHANGELOG.md
IP-PROTECTION-NOTICE.md
LICENSE
```

## Building

```bash
bash tools/verify.sh
```

Requires: `kramdown-rfc`, `xml2rfc`, `python3`

## IP Notice

See [IP-PROTECTION-NOTICE.md](IP-PROTECTION-NOTICE.md).
This draft is scoped exclusively to the **standardization interface** —
the X.509 extension syntax, semantics, and wire format. It does **not** disclose
any Sanctum SecOps LLC internal implementation, automation architecture,
or trade secret material covered by the Provisional Patent Application filed 2026.
