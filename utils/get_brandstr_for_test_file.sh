#!/bin/bash

set -euo pipefail

# Constants
GIT_ROOT_DIR="$(git rev-parse --show-toplevel)"

# Variables
cpuid_tool="$GIT_ROOT_DIR/build/cpuid_tool/cpuid_tool"

# Main script
if [[ $# -lt 1 ]]; then
	echo "$(basename "$0") raw.txt"
	exit 1
fi
"$cpuid_tool" --load="$1" --brandstr 2>/dev/null | head -n1 | sed -e 's|([^)]*)||g' -e 's|,||g' -e 's|w/|with|g' | cut -d'@' -f1 | xargs | sed -r 's|\s+|-|g' | tr '[:upper:]' '[:lower:]'
