#!/bin/sh

set -e

bundle exec sidekiq

exec "$@"