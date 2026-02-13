library(testthat)
library(readr)

# Read EASIN Catalogue taxa from file ####
taxa <- readr::read_csv(
  file = "data/output/easin_catalogue_taxa.csv",
  show_col_types = FALSE
)

# Read EASIN Catalogue taxa matched to GBIF from file ####
taxa_match <- readr::read_csv(
  file = "data/output/easin_gbif_match.csv",
  show_col_types = FALSE
)

test_that(
  "EASIN Catalogue taxa has the correct number of rows",
  {
    expect_equal(
      nrow(taxa),
      15686
    )
  }
)

test_that(
  "The match to GBIF data frame has the same number of rows as the EASIN Catalogue taxa", {
  expect_equal(
    nrow(taxa_match),
    nrow(taxa)
  )
})

test_that("EASINID is always present and unique in the EASIN Catalogue taxa", {
  expect_false(
    any(is.na(taxa$EASINID))
  )
  expect_equal(
    length(unique(taxa$EASINID)),
    nrow(taxa)
  )
})

test_that(
  "EASINID is always present and unique in the EASIN Catalogue taxa matched to GBIF", {
  expect_false(
    any(is.na(taxa_match$easin_EASINID))
  )
  expect_equal(
    length(unique(taxa_match$easin_EASINID)),
    nrow(taxa_match)
  )
})
