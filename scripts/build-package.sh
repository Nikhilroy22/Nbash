name: Echo Workflow

on:
  push:
    branches:
      - main

jobs:
  echo-job:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Echo Hello Message
        run: echo "👋 হ্যালো, এটা আমার প্রথম GitHub Actions!"