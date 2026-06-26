---
title: "PQC Hybrid Commitment (PQCHC) X.509 Extension"
abbrev: "PQCHC"
docname: draft-vicente-lamps-pqchc-02
submissiontype: IETF
number:
date: 2026-06-26
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
    email: brian@sanctumsecops.io

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

Post-quantum migration in X.509 PKI introduces a class of attack that
current certificate structures cannot address: a relying party that
observes a certificate renewal cannot cryptographically verify that
the algorithm change was intended and authorized by the original
certificate holder rather than silently substituted by an adversary.

The PQC Hybrid Commitment (PQCHC) extension provides a mechanism by
which a certificate subject declares, at issuance time, a
cryptographic commitment to the key material it intends to present at
next renewal. The commitment is advisory and non-authoritative; it
does not create a binding obligation but provides a verifiable signal
that relying parties and monitors can check.

## Requirements Language

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
"SHOULD", "SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and
"OPTIONAL" in this document are to be interpreted as described in
BCP 14 {{RFC2119}} {{RFC8174}} when, and only when, they appear in
all capitals, as shown here.

# Extension Overview

The PQCHC extension is an X.509 v3 non-critical extension that
certificate subjects MAY include to signal their intended
post-quantum algorithm migration path. The extension contains:

- A validity flag indicating whether the commitment is currently active.
- The committed algorithm identifier the subject intends to use in the
  successor certificate.
- An optional future key commitment consisting of a hash of the
  anticipated SubjectPublicKeyInfo (SPKI) and the hash algorithm used.
- A commitment expiry time (commitmentNotAfter) after which the
  commitment SHOULD be treated as expired.
- An optional policy URI for relying party reference.

The extension MUST be marked non-critical. Implementations that do
not recognize the extension MUST ignore it per {{RFC5280}} Section 4.2.

# ASN.1 Definition

The following ASN.1 module defines the PQCHC extension syntax.

~~~ asn1
PQCHC-2026
  { iso(1) identified-organization(3) dod(6) internet(1)
    security(5) mechanisms(5) pkix(7) id-mod(0) TBD1 }

DEFINITIONS IMPLICIT TAGS ::= BEGIN

IMPORTS
    EXTENSION
        FROM PKIX-CommonTypes-2009
            { iso(1) identified-organization(3) dod(6) internet(1)
              security(5) mechanisms(5) pkix(7) id-mod(0) 57 }
    AlgorithmIdentifier{}
        FROM PKIX1Algorithms2008
            { iso(1) identified-organization(3) dod(6) internet(1)
              security(5) mechanisms(5) pkix(7) id-mod(0) 45 }
    id-pe
        FROM PKIX1Explicit-2009
            { iso(1) identified-organization(3) dod(6) internet(1)
              security(5) mechanisms(5) pkix(7) id-mod(0) 51 } ;

-- Production OID (pending IANA assignment):
-- id-pe-pqchc ::= { id-pe TBD2 }

-- Experimental OID (Sanctum SecOps LLC PEN arc 1.3.6.1.4.1.65953):
id-pe-pqchc-experimental OBJECT IDENTIFIER ::=
    { 1 3 6 1 4 1 65953 1 1 }

ext-PQCHC EXTENSION ::= {
    SYNTAX        PQCHCommitment
    IDENTIFIED BY id-pe-pqchc-experimental }

PQCHCommitment ::= SEQUENCE {
    commitmentValid      BOOLEAN,
    committedAlgorithm   AlgorithmIdentifier { ALGORITHM, {...} },
    futureKeyCommitment  FutureKeyCommitment OPTIONAL,
    commitmentNotAfter   GeneralizedTime,
    policyURI            IA5String OPTIONAL
}

FutureKeyCommitment ::= SEQUENCE {
    hashAlgorithm        AlgorithmIdentifier { DIGEST-ALGORITHM, {...} },
    spkiHash             OCTET STRING,
    keyAlgorithmHint     AlgorithmIdentifier { ALGORITHM, {...} } OPTIONAL
}

END
~~~

# Extension Semantics

## commitmentValid

The commitmentValid field is a BOOLEAN that indicates whether the
subject considers the commitment currently active. A value of TRUE
indicates the commitment is active and the successor certificate is
expected to contain the committed algorithm and, if present, the
committed key material. A value of FALSE indicates the commitment
has been withdrawn or is no longer operative.

Relying parties SHOULD treat a FALSE value as equivalent to absence
of the extension.

## committedAlgorithm

The committedAlgorithm field carries an AlgorithmIdentifier
identifying the algorithm the subject intends to use in the successor
certificate. This SHOULD be a NIST-standardized post-quantum algorithm
({{FIPS203}}, {{FIPS204}}, {{FIPS205}}) or an approved hybrid
combination thereof.

## futureKeyCommitment

The futureKeyCommitment field, when present, binds the commitment to
specific key material. The spkiHash field contains the hash of the
complete DER-encoded SubjectPublicKeyInfo the subject intends to
present in the successor certificate. The hashAlgorithm field
identifies the hash algorithm used. SHA-256 or SHA-384 are RECOMMENDED.

When this field is absent, the commitment is algorithm-only. Relying
parties MUST NOT require this field to be present.

## commitmentNotAfter

The commitmentNotAfter field specifies the time after which the
commitment SHOULD be treated as expired. This time SHOULD be set to
no later than the notAfter of the containing certificate. Relying
parties MAY reject commitments whose commitmentNotAfter has passed.

## policyURI

The optional policyURI field provides a URI at which the issuer or
subject publishes commitment policy documentation. This field is
informational only.

# Verification Procedure

A relying party that wishes to verify a PQCHC commitment upon receipt
of a successor certificate MUST perform the following steps:

1. Locate the PQCHC extension in the predecessor certificate.

2. Verify that commitmentValid is TRUE and that the current time is
   before commitmentNotAfter.

3. Verify that the algorithm in the successor certificate's
   SubjectPublicKeyInfo matches the committedAlgorithm OID.

4. If futureKeyCommitment is present, compute the hash of the
   DER-encoded SubjectPublicKeyInfo from the successor certificate
   using the hashAlgorithm specified in the futureKeyCommitment
   field, and verify that it matches spkiHash.

5. If all checks pass, the relying party MAY record the commitment
   as verified. If any check fails, the relying party SHOULD treat
   the successor certificate as unverified with respect to the
   commitment and MAY reject it per local policy.

Relying parties that do not implement PQCHC verification MUST NOT
reject certificates solely on the basis of this extension.

# Implementation and Validation Status

This section is non-normative.

This draft remains a work in progress and has not been reviewed or
endorsed by the IETF, the LAMPS Working Group, or any standards body.

Experimental implementation artifacts exist for the mechanisms
described in this document. These artifacts are maintained under the
Sanctum SecOps LLC Public Enterprise Number (PEN) arc
`1.3.6.1.4.1.65953` and are published in the companion repository
for documentation and claim provenance purposes only.

The following OIDs within the Sanctum SecOps LLC PEN arc are
tracked as publication-time, priority-bearing PEN assignments
associated with this draft:

- `1.3.6.1.4.1.65953.1.1.1` — PQCHC extension mechanism
- `1.3.6.1.4.1.65953.1.100.1` — hash-based auxiliary mechanism

The `1.3.6.1.4.1.65953.1.2.x` family is listed as validated
EXPERIMENTAL implementation evidence only and is not a subject of
the standards claim surface of this draft.

All artifacts are non-normative, do not constitute test vectors for
conformance testing, and are excluded from any normative claim surface
of this document. For further detail, see the repository artifact
index and claim provenance statement.

# Security Considerations

The PQCHC extension is advisory and non-authoritative. Its security
properties depend on the integrity of the certificate issuance
process. The following considerations apply.

## Commitment Binding Strength

When futureKeyCommitment is present and a collision-resistant hash
algorithm is used, the binding between the predecessor certificate
and the expected successor SPKI is as strong as the hash algorithm.
Implementors MUST NOT use MD5 or SHA-1. SHA-256 is the minimum
recommended strength; SHA-384 or SHA-512 are preferred for
long-lived certificates.

## Commitment Revocation

If a private key associated with a committed future key is compromised
prior to issuance of the successor certificate, the subject MUST
either revoke the predecessor certificate or issue a successor
certificate with commitmentValid set to FALSE. There is no in-band
mechanism to update a commitment without reissuance.

## Algorithm Agility

The committedAlgorithm field uses a full AlgorithmIdentifier, allowing
future algorithm changes without modification to this extension
structure. Implementors SHOULD NOT hardcode algorithm OID values.

## Downgrade Attack Resistance

The primary threat model this extension addresses is covert algorithm
downgrade during certificate renewal. An attacker who controls the
certificate issuance path but cannot forge a valid predecessor
certificate cannot undetectably substitute a weaker algorithm in the
successor certificate without causing verification step 3 of
Section 5 to fail.

This extension does not protect against an attacker who can modify
or suppress the predecessor certificate itself.

# IANA Considerations

This document requests that IANA assign an object identifier for the
PQCHC extension in the "SMI Security for PKIX Certificate Extension"
registry (id-pe arc, RFC 5280):

| Decimal | Description | Reference |
|---------|-------------|------------|
| TBD     | id-pe-pqchc | This RFC   |

Until a permanent OID is assigned, implementations MUST use the
experimental OID `1.3.6.1.4.1.65953.1.1` under the Sanctum SecOps
LLC PEN arc for testing purposes only.

--- back

# Appendix A: Example Commitment (Informative)

The following is a non-normative example illustrating a PQCHC
extension where the subject commits to a future ML-DSA-65 key.

~~~ asn1
-- Example PQCHCommitment (DER pseudocode, values illustrative)
PQCHCommitment ::= {
    commitmentValid      TRUE,
    committedAlgorithm   { algorithm id-ML-DSA-65 },
    futureKeyCommitment  {
        hashAlgorithm    { algorithm id-sha384 },
        spkiHash         <SHA-384 hash of future SPKI DER>
    },
    commitmentNotAfter   "20270101000000Z",
    policyURI            "https://pki.example.com/pqchc-policy"
}
~~~

# Acknowledgments
{:numbered="false"}

The author thanks Tirumaleswar Reddy.K, John Gray, and Yaron Sheffer
for their work on draft-reddy-lamps-x509-pq-commit, which addresses
an adjacent problem and informed the threat model articulated in this
document.
