#!/usr/bin/env bash

set -o errexit

IMAGE=${IMAGE:-gds-vale:latest}

cd test

cat > expected.output <<EOF
test.md:3:21:General.UnexpandedAcronym:'TLA' has no definition
test.md:3:28:General.UnexpandedAcronym:'MYD' has no definition
EOF

docker run --rm -v "$PWD":/repo "$IMAGE" --output line test.md > actual.output

if ! diff --brief *.output; then
  echo "Actual output did not match expected output!"
  diff *.output
  exit 1
fi

echo "All tests passed"

exit 0
