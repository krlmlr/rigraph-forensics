# pak::pak(c("purrr", "tibblify", "gh", "dplyr", "callr"))

options(conflicts.policy = list(warn = FALSE))

library(purrr)
library(dplyr)

tags_list <- gh::gh("/repos/cran/igraph/tags", .limit = Inf)
tags <- tibblify::tibblify(tags_list)

version_tags <-
  tags |>
  filter(grepl("^[0-9]", name))

create_ring <- function(tag) {
  withr::local_temp_libpaths()

  try({
    pak::pak(paste0("igraph@", tag))
    library(igraph)

    # Old name for make_ring()
    g <- graph.ring(3)

    try({
      E(g)$foo <- letters[1:3]
      V(g)$bar <- LETTERS[1:3]
    })

    g
  })
}

my_tags <- set_names(version_tags$name)

graphs <- map(map(my_tags, as.list), safely(callr::r, quiet = FALSE), func = create_ring, .progress = TRUE)

saveRDS(graphs, "graphs-linux.rds")
