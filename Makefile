all: dev

deploy:
	tar -czf bdw.to.tgz public
	scp bdw.to.tgz alaska:~/
	ssh alaska ./deploy_bdwto
	rm bdw.to.tgz

dev:
	cd public && python -m SimpleHTTPServer
