TAG=bndw/bdw.to

all: dev

clean:
	rm -rf .build || true
	mkdir -p .build

build: clean
	cp -R root/* .build/
	cp -R public/* .build/var/www/bdw.to/
	docker build -t $(TAG) .

deploy:
	tar -czf bdw.to.tgz public
	scp bdw.to.tgz alaska:~/
	ssh alaska ./deploy_bdwto
	rm bdw.to.tgz

dev: stop build
	docker run -d --name bdw.to -p 5001:80 $(TAG)
	open http://localhost:5001

stop:
	docker kill bdw.to || true
	docker rm bdw.to || true
