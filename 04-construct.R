library(tidyverse)

delta <- readRDS("igraph-versions.rds")

fs::dir_create("old")

# White lie
delta$result[[1]][[10]]$myid <- "0fb28c05-9cc1-4a24-ba62-f5c319a3051b"
delta$result[[2]][[10]]$myid <- "0fb28c05-9cc1-4a24-ba62-f5c319a3051b"

code <-
  delta |>
  select(version, result) |>
  deframe() |>
  map(
    constructive::construct,
    constructive::opts_environment("new_environment", predefine = TRUE),
    pipe = "magrittr"
  ) |>
  map(capture.output) |>
  enframe() |>
  mutate(value = map_chr(value, ~ paste0("  ", .x, collapse = "\n"))) |>
  mutate(value = paste0(
    "oldsample_", str_replace_all(name, fixed("."), "_"), " <- function() {\n",
    value, "\n",
    "}"
  )) |>
  mutate(expr = map(value, rlang::parse_expr)) |>
  mutate(path = fs::path("old", paste0("old-", str_replace_all(name, fixed("."), "_"), ".R")))

code

code |>
  select(text = value, path) |>
  pmap(brio::write_lines)
