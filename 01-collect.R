# To be run in the container

options(conflicts.policy = list(warn = FALSE))

library(purrr)

version_tags <- dir("/rlib")

create_ring <- function(tag) {
  try({
    library(igraph)

    # Old name for make_ring()
    g <- graph.ring(3, directed = TRUE)

    try({
      E(g)$foo <- letters[1:3]
      V(g)$bar <- LETTERS[1:3]
      # Update "me" environment element
      invisible(E(g))
    })

    g
  })
}

my_tags <- set_names(version_tags)

graphs <- map(
  my_tags,
  safely(call_igraph, quiet = FALSE),
  !!body(create_ring),
  .progress = TRUE
)

saveRDS(graphs, "graphs-linux.rds")
