#!/bin/bash

cd /app/files/cardano-token-registry
git checkout master
git pull
cd /app
python3 update.py
