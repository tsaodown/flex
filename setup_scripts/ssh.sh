#!/bin/bash

while IFS='=' read -ra line; do
  mkdir -p "${line[1]}"
  gpg --batch -do "${line[1]}/${line[0]}" "./secrets/${line[0]}.gpg"
done < ./secrets/index.txt
