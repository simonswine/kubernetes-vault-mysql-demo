IMAGE := simonswine/vault-demo

build:
	docker build -t $(IMAGE) .

push: build
	docker push $(IMAGE)
