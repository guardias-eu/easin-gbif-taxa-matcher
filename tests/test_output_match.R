library(testthat)
library(readr)

# Read EASIN Catalogue taxa from file ####
taxa <- readr::read_csv(
  file = "data/output/easin_catalogue_taxa.csv",
  show_col_types = FALSE
)

# Read EASIN Catalogue taxa from `main` branch of the repository ####
main_taxa_file <- "https://raw.githubusercontent.com/guardias-eu/easin-gbif-taxa-matcher/refs/heads/main/data/output/easin_catalogue_taxa.csv"
main_taxa <- readr::read_csv(
  file = main_taxa_file,
  na = "",
  show_col_types = FALSE
)

# Read EASIN Catalogue taxa matched to GBIF from file ####
taxa_match <- readr::read_csv(
  file = "data/output/easin_gbif_match.csv",
  guess_max = 100000,
  show_col_types = FALSE,
)

# Read EASIN Catalogue taxa matched to GBIF from `main` branch of the repository ####
main_taxa_match_file <- "https://raw.githubusercontent.com/guardias-eu/easin-gbif-taxa-matcher/refs/heads/main/data/output/easin_gbif_match.csv"
main_taxa_match <- readr::read_csv(
  file = main_taxa_match_file,
  na = "",
  guess_max = 100000,
  show_col_types = FALSE
)

test_that(
  "EASIN Catalogue taxa has the correct number of rows",
  {
    expect_equal(
      nrow(taxa),
      15570
    )
  }
)

test_that(
  "EASIN Catalogue taxa has the same columns as the EASIN Catalogue taxa in `main`",
  {
    expect_equal(
      nrow(taxa),
      15685
    )
    expect_equal(
      names(taxa),
      names(main_taxa)
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

test_that(
  "The match to GBIF data frame has the same columns as the match in `main`", {
  expect_equal(
    names(taxa_match),
    names(main_taxa_match)
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

test_that(
  "The differences with `main` are only in the order of the rows.", {
  # Order rows by EASIN Catalogue taxon ID
  expect_equal(
    taxa[order(taxa$EASINID), ],
    main_taxa[order(main_taxa$EASINID), ]
  )
  expect_equal(
    taxa_match[order(taxa_match$easin_EASINID), ],
    main_taxa_match[order(main_taxa_match$easin_EASINID), ]
  )
})
