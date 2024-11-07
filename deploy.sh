ARG=$1
shift
case $ARG in
  run-play)
    source .venv/bin/activate
    ansible-playbook --become-password-file ./secrets/become_password_file --vault-password-file ./secrets/vault_password_file play.yml $@
    ;;
  check-play)
    source .venv/bin/activate
    ansible-playbook --become-password-file ./secrets/become_password_file --vault-password-file ./secrets/vault_password_file play.yml --check --diff $@
    ;;
  *)
    echo "Only run-play or check-play allowed"
  ;;
esac
