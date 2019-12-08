TRY_LOOP="20"

# Install custom python package if requirements.txt is present
if [ -e "/requirements.txt" ]; then
    $(command -v pip) install --user -r /requirements.txt
fi

wait_for_port() {
  local name="$1" host="$2" port="$3"
  local j=0
  while ! nc -z "$host" "$port" >/dev/null 2>&1 < /dev/null; do
    j=$((j+1))
    if [ $j -ge $TRY_LOOP ]; then
      echo >&2 "$(date) - $host:$port still not reachable, giving up"
      exit 1
    fi
    echo "$(date) - waiting for $name... $j/$TRY_LOOP"
    sleep 5
  done
}

MLFLOW__CORE__SQL_ALCHEMY_CONN="postgresql+psycopg2://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB"
wait_for_port "Postgres" "$POSTGRES_HOST" "$POSTGRES_PORT"

case "$1" in
  server)
    mlflow initdb
    sleep 10
    exec mlflow server
    ;;
  ui)
    sleep 10
    exec mlflow "$@"
    ;;
  version)
    sleep 10
    exec mlflow "$@"
    ;;
  *)
    # The command is something like bash, not an airflow subcommand. Just run it in the right environment.
    exec "$@"
    ;;
esac
