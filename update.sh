#!/bin/bash

cd /app/files/cardano-token-registry
git checkout main
git pull
cd /app
python3 update.py
