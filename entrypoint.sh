
#!/bin/bash

set -e

# set odoo database host, port, user and password
: ${PGHOST:=$DB_PORT_5432_TCP_ADDR}
: ${PGPORT:=$DB_PORT_5432_TCP_PORT}
: ${PGUSER:=$DB_ENV_POSTGRES_USER}
: ${PGPASSWORD:=$DB_ENV_POSTGRES_PASSWORD}

export PGHOST PGPORT PGUSER PGPASSWORD

case "$1" in
	--)
		shift
		exec gosu openerp-server "$@"
		;;
	-*)
		exec gosu openerp-server "$@"
		;;
	*)
		exec gosu "$@"
esac

exit 1
