all: uncreate create goin

create:
	scripts/create.sh

goin:
	sudo scripts/goin.sh

uncreate:
	scripts/uncreate.sh
