#!/bin/bash

# Resolve absolute paths
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR/templates"
PROJECT_ROOT="$SCRIPT_DIR/../cfn-guard-granular-gh-action"

# Build the Docker image from the project root
docker build -t cfn-guard-granular-gh-action "$PROJECT_ROOT"

# Run the container with the test templates mounted
docker run --rm \
  -e INPUT_DATA_DIRECTORY="/app/templates" \
  -e INPUT_RULE_SET_URL="https://raw.githubusercontent.com/QuantumNeuralCoder/cfn-guard-rules-repo/refs/heads/main/trust_scope_rules.guard" \
  -e INPUT_SHOW_SUMMARY="fail" \
  -e INPUT_OUTPUT_FORMAT="single-line-summary" \
  -v "$TEMPLATE_DIR:/app/templates" \
  cfn-guard-granular-gh-action
