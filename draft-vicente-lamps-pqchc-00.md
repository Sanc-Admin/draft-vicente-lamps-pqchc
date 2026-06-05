---
title: "PQC Hybrid Commitment (PQCHC) X.509 Extension"
abbrev: "PQCHC"
docname: draft-vicente-lamps-pqchc-00
submissiontype: IETF
number:
date:
consensus: true
v: 3
area: "Security"
workgroup: "LAMPS Working Group"
keyword:
 - post-quantum cryptography
 - X.509
 - certificate extension
 - key commitment
 - hybrid cryptography
 - migration
venue:
  group: "LAMPS"
  type: "Working Group"
  mail: "spasm@ietf.org"
  arch: "https://mailarchive.ietf.org/arch/browse/spasm/"
  github: "Sanc-Admin/draft-vicente-lamps-pqchc"
  latest: "https://Sanc-Admin.github.io/draft-vicente-lamps-pqchc/draft-vicente-lamps-pqchc.html"

author:
 -
    fullname: Brian Vicente
    organization: Sanctum SecOps LLC
    email: brian@sanctumsecops.com

normative:
  RFC2119:
  RFC5280:
  RFC8174:
  RFC9794:
  FIPS203:
    title: "Module-Lattice-Based Key-Encapsulation Mechanism Standard"
    author:
      org: "NIST"
    date: 2024-08
    target: https://doi.org/10.6028/NIST.FIPS.203
  FIPS204:
    title: "Module-Lattice-Based Digital Signature Standard"
    author:
      org: "NIST"
    date: 2024-08
    target: https://doi.org/10.6028/NIST.FIPS.204
  FIPS205:
    title: "Stateless Hash-Based Digital Signature Standard"
    author:
      org: "NIST"
    date: 2024-08
    target: https://doi.org/10.6028/NIST.FIPS.205

informative:
  RFC9773:
  RFC9763:
  NIST-IR-8547:
    title: "Transition to Post-Quantum Cryptography Standards"
    author:
      org: "NIST"
    date: 2024-11
    target: https://csrc.nist.gov/pubs/ir/8547/ipd
  I-D.ietf-lamps-pq-composite-sigs:
  I-D.ietf-lamps-pq-composite-kem:
  I-D.reddy-lamps-x509-pq-commit:
    title: "X.509 Certificate Extension for Post-Quantum Hosting Continuity"
    author:
      - ins: T. Reddy.K
        name: Tirumaleswar Reddy.K
        org: Nokia
      - ins: J. Gray
        name: John Gray
        org: Entrust
      - ins: Y. Sheffer
        name: Yaron Sheffer
        org: Intuit
    date: 2026-02-25
    target: https://datatracker.ietf.org/doc/draft-reddy-lamps-x509-pq-commit/
  I-D.ounsworth-lamps-pq-external-pubkeys:
  I-D.ietf-lamps-certdiscovery:
  CNSA2:
    title: "Commercial National Security Algorithm Suite 2.0"
    author:
      org: "NSA"
    date: 2022-09
    target: https://www.nsa.gov/Cybersecurity/Post-Quantum-Cybersecurity-Resources/

--- abstract

The current Internet Public Key Infrastructure (PKI) lacks a
machine-verifiable, cryptographically bound mechanism for certificate
holders to commit, at issuance time, to the specific post-quantum (PQ)
or PQ/T hybrid key material they intend to present at the next
certificate renewal. Without such a mechanism, relying parties cannot
distinguish a legitimate algorithm migration from a covert downgrade
attack.

This document defines the PQC Hybrid Commitment (PQCHC) X.509 v3
extension. The extension carries an advisory, non-authoritative
commitment encoded as a cryptographic hash of the future
SubjectPublicKeyInfo the certificate subject intends to present in
the successor certificate, together with the intended committed
algorithm identifier and an expiry time for the commitment.

--- middle

# Introduction

[NOTE TO RFC EDITOR: This is the -00 individual submission. Full draft
content is maintained in the repository. This header establishes
docname, authorship, and working group target for Datatracker submission.]

{::include draft-vicente-lamps-pqchc-body.md}

--- back

# Acknowledgments
{:numbered="false"}

The author thanks Tirumaleswar Reddy.K, John Gray, and Yaron Sheffer for
their work on draft-reddy-lamps-x509-pq-commit.
