#!/bin/sh
echo "db creating..."
rails db:create && rails db:migrate

echo "start rails server with exec."
set -e
rm -f ./tmp/pids/server.pid
exec bundle exec rspec
