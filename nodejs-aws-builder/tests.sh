#!/bin/ash
# vim: ft=bash.sh
set -o nounset
set -o errexit

function fail() {
  local spec="${1}"
  local expected="${2}"
  local actual="${3}"
  local result="${4}"

  echo 1>&2 "- ${spec} FAILED!"
  echo 1>&2 "      ${expected} does not match ${actual}"
  exit 1
}

function success() {
  local spec="${1}"

  echo "- ${spec} ok"
}

function assert() {
  local spec="${1}"
  local expected="${2}"
  local actual="${3}"
  local result=$(expr "${actual}" : "${expected}")

  if [ $result = 0 ]; then
    fail "${spec}" "${expected}" "${actual}" "${result}"
  else
    success "${spec}"
  fi
}

export SOPS_PGP_FP="85D77543B3D624B63CEA9E6DBC17301B491B3F21,E60892BB9BD89A69F759A1A0A3D652173B763E8F"

echo "Testing nodejs-aws-builder image..."
echo

assert "bash installation" "GNU bash*" "$(bash --version)"
assert "jq installation" "jq-*" "$(jq --version)"
assert "sops installation" "sops *" "$(sops --version)"
assert "sops execution"  "ENC*" $(echo '{"a": 1}' > test.json && sops --encrypt test.json | jq -r '.a')
assert "aws-cli installation" "aws-cli/*" "$(aws --version 2>&1)"
assert "aws-cli + jq integration" "arn:aws:iam:*" "$(aws sts get-caller-identity | jq -r '.Arn')"
assert "stacker installation" "stacker 1.4.1" "$(stacker --version 2>&1)"
assert "nodejs installation" "v8.*" "$(node --version)"
assert "nodejs evaluation" "this is a test" "$(node -e 'console.log("this is a test");')"
assert "npm installation" "5.6.0" "$(npm --version)"
assert "git installation" "git version 2.18.0" "$(git --version)"
assert "zip installation" "This is Zip 3.0*" "$(zip --version | grep 'This is Zip')"

echo
echo "Done."
