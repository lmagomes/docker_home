.PHONY: all deploy generate_secrets clean

all: generate_secrets deploy


deploy:
	docker stack deploy --resolve-image never -c home.yml home

generate_secrets:
	# This requires that bitwarden is unlocked.
	bw get password postgresql | docker secret create --label com.docker.stack.namespace=home postgresql_password -
	bw get password bitwarden | docker secret create --label com.docker.stack.namespace=home bw_admin_token -
	bw get password "grafana" | docker secret create --label com.docker.stack.namespace=home grafana_password -

clean:
	docker stack rm home
