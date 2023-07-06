#!/usr/bin/env sh
set -e

if [ -f /app/app/main.py ]; then
    DEFAULT_MODULE_NAME=app.main
elif [ -f /app/main.py ]; then
    DEFAULT_MODULE_NAME=main
fi
MODULE_NAME=${MODULE_NAME:-$DEFAULT_MODULE_NAME}
VARIABLE_NAME=${VARIABLE_NAME:-app}
export APP_MODULE=${APP_MODULE:-"$MODULE_NAME:$VARIABLE_NAME"}

export PYTHONDONTWRITEBYTECODE=1
export PYTHONUNBUFFERED=1

export APP_PORT=${APP_PORT:-8000}
export WORKER_CLASS=${WORKER_CLASS:-"uvicorn.workers.UvicornWorker"}
export GUNICORN_CMD_ARGS="--bind=0.0.0.0:$APP_PORT --worker-class=$WORKER_CLASS --capture-output --access-logfile - --error-logfile -"

if [ $DEVELOPMENT = "true" ]; then
  echo "*** running in development mode!!! ***"
  uvicorn --reload --host 0.0.0.0 --port $APP_PORT "$APP_MODULE"
else
  echo "*** RUNNING IN PRODUCTION MODE!!! ***"
  gunicorn --check-config $APP_MODULE
  gunicorn "$APP_MODULE"
fi

