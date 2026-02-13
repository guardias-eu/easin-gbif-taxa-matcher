# Load libraries ####
library(dplyr)
library(purrr)
library(readr)
library(reasin)
library(rgbif)

# Get taxa of the EASIN Catalogue ####
statuses <- reasin::statuses() %>% dplyr::pull(status_code)
taxa <- purrr::map(
  statuses,
  purrr::in_parallel(
    function(s) {
      reasin::get_species(status = s)
    }
  )
)
taxa <- purrr::list_rbind(taxa)

# Save EASIN Catalogue taxa to a file ####
readr::write_csv(
  x = taxa,
  file = "data/output/easin_catalogue_taxa.csv",
  na = ""
)

# Create scientific names ####
taxa <- taxa %>%
  dplyr::mutate(
    scientificName = paste(Name, Authorship, sep = " ")
  ) %>%
  # Set column `Kingdom` lowercase for matching with GBIF
  dplyr::rename(
    kingdom = Kingdom
  )

# Match taxa to GBIF ####
taxa_match <- rgbif::name_backbone_checklist(
  taxa %>%
    dplyr::select(scientificName, kingdom, EASINID),
  strict = TRUE
)

# Prepare column names from both datasets for joining ####
## Add prefix `easin_` to all columns from the EASIN Catalogue ####
taxa <- taxa %>%
  dplyr::rename_with(
    ~ paste0("easin_", .x)
  )
## `verbatim_` prefix must become `easin_` for all columns from the GBIF match #### 
taxa_match <- taxa_match %>%  
  # Column `verbatim_name` must become `verbatim_scientificName`
  dplyr::rename(
    verbatim_scientificName = verbatim_name
  ) %>%
  dplyr::rename_with(
    ~ gsub("verbatim_", "easin_", .x),
    starts_with("verbatim_")
  ) 
  

# Add all columns from the EASIN Catalogue to the GBIF match by joining ####
taxa_match <- taxa_match %>%
  dplyr::left_join(
    taxa,
    dplyr::join_by(
      easin_EASINID,
      easin_scientificName,
      easin_kingdom
    )
  )

# Save the taxa to a file ####
readr::write_csv(
  x = taxa_match,
  file = "data/output/easin_gbif_match.csv",
  na = ""
)
