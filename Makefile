all: dev

.PHONY: deploy
deploy:
	tar -czf bdw.to.tgz public
	scp bdw.to.tgz alaska:~/
	ssh alaska ./deploy_bdwto
	rm bdw.to.tgz

.PHONY: dev
dev:
	open http://localhost:5001
	cd public && python -m SimpleHTTPServer 5001
