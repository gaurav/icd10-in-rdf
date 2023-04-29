# icd10-to-snomed

This repository contains code for working with ICD-10 identifiers in RDF,
including:

- icd10-snomed-mappings-to-rdf.yaml: YARRRML file for converting ICD-10-to-SNOMED mappings
  in a CSV file into RDF triples.

Makefile targets:
- `data/icd10-to-snomed-mappings.nq`: n-quads generated from `data/ICD_SNOMED_Map.csv`