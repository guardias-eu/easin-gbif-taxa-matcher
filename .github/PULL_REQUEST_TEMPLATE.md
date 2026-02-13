## Brief description

This is an **automatically generated PR**. 
The following steps are all automatically performed:

- Fetch EASIN Catalogue data and save the output in `./data/output/easin_catalogue_taxa.csv`. See file [`./src/match_easin_catalogue.R`](https://github.com/guardias-eu/easin-gbif-taxa-matcher/blob/main/src/match_easin_catalogue.R).
- Map EASIN Catalogue to GBIF Taxonomy Backbone and save the output in `./data/output/easin_gbif_match.csv`. See file [`./src/match_easin_catalogue.R`](https://github.com/guardias-eu/easin-gbif-taxa-matcher/blob/main/src/match_easin_catalogue.R).
- Run some tests. See [`./tests/test_output_match.R`](https://github.com/guardias-eu/easin-gbif-taxa-matcher/blob/main/tests/test_output_match.R).

Note to the reviewer: please, check the output thoroughly before merging to `main`. In case, update the matching script [`./src/match_easin_catalogue.R`](https://github.com/guardias-eu/easin-gbif-taxa-matcher/blob/main/src/match_easin_catalogue.R) or  the GitHub workflow  [`.github/workflows/check_taxon_info.yaml`](https://github.com/guardias-eu/easin-gbif-taxa-matcher/blob/main/.github/workflows/check_taxon_info.yaml).
