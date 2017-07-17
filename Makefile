all: dev

deploy:
	hugo -t cocoa
	tar -czf bdw.to.tgz public
	scp bdw.to.tgz alaska:~/
	ssh alaska ./deploy_bdwto
	rm bdw.to.tgz

dev:
	hugo server --buildDrafts -t cocoa
