#!/usr/bin/env bash

SCRIPT_DIR=/docker-entrypoint.d

if [ -d "$SCRIPT_DIR" ]; then
  /bin/run-parts --verbose "$SCRIPT_DIR"
fi

exec "$@"