#!/usr/bin/env bash
# verify.sh — Build, validate, and render draft-vicente-lamps-pqchc
# Requires: kramdown-rfc, xml2rfc, python3
# Usage: bash tools/verify.sh [--no-render]

set -euo pipefail

DRAFT="draft-vicente-lamps-pqchc-00"
SRC="${DRAFT}.md"
XML="${DRAFT}.xml"
TXT="${DRAFT}.txt"
HTML="${DRAFT}.html"

echo "=== [1/4] Checking dependencies ==="
for cmd in kramdown-rfc xml2rfc python3; do
  command -v "$cmd" &>/dev/null || { echo "ERROR: $cmd not found"; exit 1; }
done
echo "  OK"

echo "=== [2/4] Generating XML from Markdown ==="
kramdown-rfc "$SRC" > "$XML"
echo "  Wrote: $XML"

echo "=== [3/4] Validating ASN.1 module ==="
python3 tools/validate_asn1.py ASN.1/pqchc-2026.asn1
echo "  ASN.1 validation OK"

if [[ "${1:-}" != "--no-render" ]]; then
  echo "=== [4/4] Rendering to text and HTML ==="
  xml2rfc "$XML" --text --html
  echo "  Wrote: $TXT"
  echo "  Wrote: $HTML"
fi

echo ""
echo "=== BUILD COMPLETE ==="
echo "  Draft:  $DRAFT"
echo "  Source: $SRC"
echo "  XML:    $XML"

# QuantaScript QS-dev verification hook
# If QS_DEV_ENDPOINT is set, push verification summary
if [[ -n "${QS_DEV_ENDPOINT:-}" ]]; then
  echo "=== Sending verification signal to QS-dev ==="
  PAYLOAD=$(jq -nc \
    --arg draft "$DRAFT" \
    --arg status "verified" \
    --arg ts "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
    '{draft:$draft,status:$status,timestamp:$ts}')
  curl -sSf -X POST "$QS_DEV_ENDPOINT/hooks/ietf-draft-verified" \
    -H 'Content-Type: application/json' \
    -d "$PAYLOAD"
fi
