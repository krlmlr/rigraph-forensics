# pak::pak(c("purrr", "tibblify", "gh", "dplyr", "callr"))

options(conflicts.policy = list(warn = FALSE))

library(purrr)

version_tags <- readRDS("tags.rds")

create_ring <- function(tag) {
  withr::local_temp_libpaths()

  try({
    remotes::install_version("igraph", tag)
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

my_tags <- set_names(c(
  "1.0.0", "0.5", "0.4.5", "0.4.4", "0.4.3", "0.4.2", "0.4.1", "0.4", "0.3.3",
  "0.3.2", "0.3.1", "0.1.2", "0.1.1"
))

graphs <- map(map(my_tags, as.list), safely(callr::r, quiet = FALSE), func = create_ring, .progress = TRUE)

saveRDS(graphs, "graphs-linux.rds")
