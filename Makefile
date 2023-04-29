
# Configuration
RMLMAPPER_VERSION=6.1.3-r367-all

#
# Overall targets
#
.PHONY: all clean
all: data/icd10-to-snomed-mappings.ttl

clean:
	rm -rf node_modules
	rm -f data/icd10-to-snomed-mappings.rml
	rm -f data/icd10-to-snomed-mappings.ttl

#
# DEPENDENCIES
#

# Install all NPM packages.
data/npm-installed:
	npm install && touch $@

# We need rmlmapper.jar to actually apply the RML rules.
bin/rmlmapper.jar:
	wget "https://github.com/RMLio/rmlmapper-java/releases/download/v6.1.3/rmlmapper-6.1.3-r367-all.jar" -O $@

#
# DATA GENERATION
#
data/icd10-to-snomed-mappings.rml: icd10-snomed-mappings-to-rdf.yaml data/ICD_SNOMED_Map.csv data/npm-installed
	npm run yarrrml-parser -- -i icd10-snomed-mappings-to-rdf.yaml -o $@

data/icd10-to-snomed-mappings.ttl: data/icd10-to-snomed-mappings.rml data/ICD_SNOMED_Map.csv bin/rmlmapper.jar 
	java -jar bin/rmlmapper.jar -m data/icd10-to-snomed-mappings.rml -o $@
