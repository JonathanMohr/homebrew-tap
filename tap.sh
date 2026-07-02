#!/usr/bin/env bash

brew tap local/tap $(pwd)

# Trust only local tap
brew trust local/tap
