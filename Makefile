.PHONY: clean

build:
	latexmk -pv

watch:
	latexmk -pvc

clean:
	latexmk -c 
