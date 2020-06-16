.PHONY: all deploy generate_secrets clean

all: generate_secrets deploy


deploy:
	docker stack deploy --resolve-image never -c home.yml home

generate_secrets:
	# This requires that bitwarden is unlocked.
	bw get password postgresql | docker secret create --label com.docker.stack.namespace=home postgresql_password -
	bw get password bitwarden | docker secret create --label com.docker.stack.namespace=home bw_admin_token -
	bw get username "nextcloud instalation" | docker secret create --label com.docker.stack.namespace=home nextcloud_admin_user -
	bw get password "nextcloud instalation" | docker secret create --label com.docker.stack.namespace=home nextcloud_admin_password -
	bw get username "nextcloud database" | docker secret create --label com.docker.stack.namespace=home nextcloud_database_user -
	bw get password "nextcloud database" | docker secret create --label com.docker.stack.namespace=home nextcloud_database_password -
	bw get item "nextcloud database" | jq -r '.fields[].value' | docker secret create --label com.docker.stack.namespace=home nextcloud_database -

clean:
	docker stack rm home
