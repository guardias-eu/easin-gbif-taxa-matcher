installed <- rownames(installed.packages())
required <- c(
  "dplyr",
  "purrr",
  "readr",
  "reasin",
  "rgbif",
  "testthat"
)
if (!all(required %in% installed)) {
  # reasin is not on CRAN, so we need to install it from GitHub
  if (!"reasin" %in% installed) {
    remotes::install_github("inbo/reasin")
  }
  required <- required[required != "reasin"]
  pkgs_to_install <- required[!required %in% installed]
  install.packages(pkgs_to_install)
}
