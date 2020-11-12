setup() {
  source ../dotfile
}

@test "1: autocd" {
  skip
}

@test "2: cxe" {
  skip
}

@test "3: mkcd" {
  run mkcd -p newdir
  [ "$status" -eq 0 ]
}

@test "4: touchme" {
  skip
}

@test "5: url shortener tinyurl pipe test" {
  skip
  run echo "google.com" | tinyurl
  [ "$status" -eq 0 ]
}

@test "6: url shortener tinyurl arg test" {
  run tinyurl "www.google.com"
  [ "$status" -eq 0 ]
}

@test "7: sharesomething via shareit pipe test" {
  skip
  run echo "something" | shareit
  [ "$status" -eq 0 ]
}

@test "8: sharesomething via shareit arg test" {
  run shareit "something"
  [ "$status" -eq 0 ]
}

@test "9: base64 decode pipe test" {
  skip
  run printf "%s" "SGVsbG8sIFdvcmxk" | b64decode
  echo "test output status: $status"
  echo "Output:"
  echo "$output"
  echo " --- "
  [[ "$output" == "Hello, World" ]]
}

@test "10: base64 decode arg test" {
  run b64decode "SGVsbG8sIFdvcmxk"
  echo "test output status: $status"
  echo "Output:"
  echo "$output"
  echo " --- "
  [[ "$output" == "Hello, World" ]]
}
