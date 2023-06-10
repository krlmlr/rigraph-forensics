# pak::pak(c("purrr", "tibblify", "gh", "dplyr", "callr"))

options(conflicts.policy = list(warn = FALSE))

library(purrr)
library(dplyr)

tags_list <- gh::gh("/repos/cran/igraph/tags", .limit = Inf)
tags <- tibblify::tibblify(tags_list)

version_tags <-
  tags |>
  filter(grepl("^[0-9]", name))

saveRDS(version_tags, "tags.rds")
