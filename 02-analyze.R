options(conflicts.policy = list(warn = FALSE))

library(tidyverse)

graphs <- readRDS("bionic/graphs-linux.rds")

result <-
  graphs |>
  map("result") |>
  enframe(value = "result") |>
  mutate(success = map_lgl(result, ~ class(.x) == "igraph"))

stopifnot(all(result$success))

result_dict <-
  result |>
  select(-success) |>
  arrange(desc(as.package_version(name)))

result_vec <-
  result_dict |>
  deframe()

result_dict |>
  select(name, result) |>
  mutate(prev_result = lead(result)) |>
  mutate(same = map2_lgl(result, prev_result, identical)) |>
  mutate(compare = map2(result, prev_result, waldo::compare)) |>
  pull()

scrub_id <- function(g) {
  cl <- class(g)
  g <- unclass(g)
  if (length(g) >= 10) {
    if (!is.null(g[[10]]$myid)) {
      g[[10]]$myid <- "<myid>"
    }
    if (!is.null(g[[10]]$me)) {
      g[[10]]$me <- "<me>"
    }
    g[[10]] <- as.list(g[[10]], all.names = TRUE)
  }
  class(g) <- cl
  g
}

delta <-
  result_dict |>
  mutate(prev_name = lead(name)) |>
  select(name, prev_name, result) |>
  mutate(result = map(result, scrub_id)) |>
  mutate(prev_result = lead(result)) |>
  mutate(same = map2_lgl(result, prev_result, identical, ignore.environment = TRUE)) |>
  mutate(compare = map2(prev_result, result, waldo::compare)) |>
  filter(!same)

delta

delta |>
  transmute(transition = paste0(prev_name, " -> ", name), compare) |>
  head(-1) |>
  deframe()

unclass(result_vec$"1.0.0")[[10]] |>
  as.list(all.names = TRUE)

unclass(result_vec$"1.4.3")[[10]] |>
  as.list(all.names = TRUE)

delta |>
  select(
    version = name,
    prev_version = prev_name,
    result
  ) |>
  saveRDS("bionic/igraph-versions.rds")
