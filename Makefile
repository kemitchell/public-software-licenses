LAMOS=$(wildcard *.lamos)
JSON=$(LAMOS:.lamos=.json)

.PHONY: validate

validate: $(JSON) schema.json | $(AJV)
	for json in $(JSON); do $(AJV) validate -s schema.json -d $$json ; done

.INTERMEDIATE: $(JSON)

%.json: %.lamos
	$(L2J) < $< > $@

L2J=node_modules/.bin/lamos-to-json
AJV=node_modules/.bin/ajv

$(AJV) $(L2J):
	npm install
