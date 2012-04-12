apply = puppet apply --noop --modulepath=tests/modules

smoke:
	$(apply) tests/init.pp
	$(apply) tests/conf.pp

test: tests/*.pp
	find tests -name \*.pp | xargs -n 1 -t $(apply)

vm:
	vagrant up
