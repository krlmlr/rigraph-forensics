# pak::pak(c("purrr", "tibblify", "gh", "dplyr", "callr"))

options(conflicts.policy = list(warn = FALSE))

library(purrr)

version_tags <- dir("/rlib")

create_ring <- function(tag) {
  withr::local_libpaths(file.path("/rlib", tag))

  try({
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

print_graph <- function(tag) {
  withr::local_libpaths(file.path("/rlib", tag))

  library(igraph)
  graph <- readRDS("ring.rds")
  print(graph)
  stop("Deliberate")
}

new_ring <- create_ring("1.5.0")
saveRDS(new_ring, "ring.rds")

my_tags <- set_names(version_tags)[1:3]

output <- map(map(my_tags, as.list), safely(callr::r, quiet = FALSE), func = print_graph, .progress = TRUE)

saveRDS(output, "back-linux.rds")
