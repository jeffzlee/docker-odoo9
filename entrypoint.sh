
#!/bin/bash

set -e

# set odoo database host, port, user and password
#: ${PGHOST:=$DB_PORT_5432_TCP_ADDR}
#: ${PGPORT:=$DB_PORT_5432_TCP_PORT}
#: ${PGUSER:=$DB_ENV_POSTGRES_USER}
#: ${PGPASSWORD:=$DB_ENV_POSTGRES_PASSWORD}
: ${PGHOST:=0.0.0.0}
: ${PGPORT:=5432}
: ${PGUSER:=odoo}
: ${PGPASSWORD:=odoo}
export PGHOST PGPORT PGUSER PGPASSWORD

case "$1" in
	--)
		shift
		exec openerp-server "$@"
		;;
	-*)
		exec openerp-server "$@"
		;;
	*)
		exec "$@"
esac

exit 1
