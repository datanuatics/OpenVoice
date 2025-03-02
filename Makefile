build:
	docker build -t openvoice .

bash:
	docker run -it --rm -v $(shell pwd)/resources:/app/resources -v $(shell pwd)/outputs:/app/outputs openvoice bash

run:
	docker run -it --rm -v $(shell pwd)/resources:/app/resources -v $(shell pwd)/outputs:/app/outputs openvoice