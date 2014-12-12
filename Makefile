PRES=index

.PHONY: tidy clean

all: $(PRES).html 

BVIMGNAMES=const-bias-variance.png error-vs-degree.png lin-bias-variance.png seventh-bias-variance.png tenth-bias-variance.png twentyth-bias-variance.png
BVIMGS=$(addprefix ./assets/img/bias-variance/,$(BVIMGNAMES))
CVIMGS=./assets/img/crossvalidation/CV-polynomial.png

IMGS=$(BVIMGS) $(CVIMGS)

%.md %.html: %.Rmd $(IMGS)
	Rscript -e "library(slidify); slidify('$<',knit_deck=TRUE,save_payload=TRUE)"

$(BVIMGS): scripts/regression/biasvariance.py
	python $<

$(CVIMGS): scripts/regression/crossvalidation.py
	python $<

tidy:
	rm -f *~
	rm -f scripts/*.pyc
	rm -f scripts/*~
	rm -f scripts/regression/*.pyc
	rm -f scripts/regression/*~

clean:
	rm -f $(PRES).html $(PRES).md $(IMGS)