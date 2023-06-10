make_igraph_call <- function(tag, code) {
  code <- rlang::enexpr(code)
  body <- rlang::expr({
    withr::local_libpaths(file.path("/rlib", !!tag))
    library(igraph)
    !!code
  })
  rlang::new_function(rlang::pairlist2(tag = ), body)
}

run_igraph <- function(tag, code) {
  run_igraph <- make_igraph_call(tag, !!rlang::enexpr(code))
  run_igraph()
}

call_igraph <- function(tag, code) {
  run_igraph <- make_igraph_call(tag, !!rlang::enexpr(code))
  callr::r(run_igraph)
}
