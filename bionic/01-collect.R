# pak::pak(c("purrr", "tibblify", "gh", "dplyr", "callr"))

options(conflicts.policy = list(warn = FALSE))

library(purrr)

version_tags <- readRDS("bionic/tags.rds")
# 1.4.3
# 1.4.2
# 1.4.1
# 1.4.0
# 1.3.5
# 1.3.4
# 1.3.3
# 1.3.2
# 1.3.1
# 1.3.0
# 1.2.11
# 1.2.10
# 1.2.9
# 1.2.8
# 1.2.7
# 1.2.6
# 1.2.5
# 1.2.4.2
# 1.2.4.1
# 1.2.4
# 1.2.3
# 1.2.2
# 1.2.1
# 1.1.2
# 1.1.1
# 1.0.1
# 1.0.0
# 0.7.1
# 0.7.0
# 0.6.6
# 0.6.5
# 0.6.5-2
# 0.6.5-1
# 0.6.4
# 0.6
# 0.6-3
# 0.6-2
# 0.6-1
# 0.5.5
# 0.5.5-4
# 0.5.5-3
# 0.5.5-2
# 0.5.5-1
# 0.5.4
# 0.5.4-1
# 0.5.3
# 0.5.2
# 0.5.2-2
# 0.5.1
# 0.5
# 0.4.5
# 0.4.4
# 0.4.3
# 0.4.2
# 0.4.1
# 0.4
# 0.3.3
# 0.3.2
# 0.3.1
# 0.2.1
# 0.2
# 0.1.2
# 0.1.1

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
