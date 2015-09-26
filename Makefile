all: wheelzoom.min.js

wheelzoom.min.js: wheelzoom.js
	uglifyjs -c -m -o $@ < $<

wheelzoom.js: wheelzoom.coffee
	coffee -c --stdio < $< > $@
