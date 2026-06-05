# IP Protection Notice
## Sanctum SecOps LLC — draft-vicente-lamps-pqchc

### What This Repository Contains

This repository contains **only** the IETF Internet-Draft specification for the
PQC Hybrid Commitment (PQCHC) X.509 v3 extension:

- The wire format (ASN.1 DER structure)
- Processing rules for certificate issuance, consumption, and renewal verification
- IANA considerations and OID assignments
- Requirements and security analysis

### What This Repository Does NOT Contain

The following are **trade secrets and/or subject to provisional patent protection**
filed with the USPTO by Sanctum SecOps LLC (Brian Vicente, inventor, 2026):

| Protected Asset | Classification |
|---|---|
| Sanctum Quanta PKI engine internals | Trade Secret + Patent Pending |
| Drift-Gated Issuance algorithm and implementation | Patent Pending |
| Per-Transaction Semantic Consistency Verification | Patent Pending |
| Topology-Aware Certificate Rotation scheduler | Patent Pending |
| Multi-Tenant CA orchestration architecture | Patent Pending |
| QuantaScript DSL compiler and runtime | Trade Secret |
| QS-dev internal APIs and data structures | Trade Secret |
| Sanctum MCP SecOps orchestration layer | Trade Secret |
| Atera / WatchGuard / UniFi automation adapters | Trade Secret |

None of the above are referenced, described, or inferable from this draft.

### IETF IP Policy

This contribution is made under the IETF Trust Legal Provisions (TLP) and
the contributor's statement required by RFC 8179. The PQCHC extension
specification is contributed to the IETF standards process subject to the
royalty-free licensing requirements of BCP 78 and BCP 79.

**The forward-commitment mechanism described in this draft is distinct from
all internal Sanctum SecOps implementations.** The draft describes a standards
interface; the implementation is not published here.

### Patent Notice

A USPTO Provisional Patent Application covering multi-tenant PKI with
drift-gated issuance, semantic consistency verification, and topology-aware
PQC certificate rotation was filed by Sanctum SecOps LLC in 2026.

The PQCHC X.509 extension defined in this draft describes a **relying-party
verification interface** — the data carried in the extension and how to check it.
This is distinct from the patented internal CA automation architecture.

Per IETF BCP 79, any implementation of this specification may require a
separate patent license if it incorporates the patented internal architecture.
Contact: legal@sanctumsecops.com
