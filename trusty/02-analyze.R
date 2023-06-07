options(conflicts.policy = list(warn = FALSE))

library(tidyverse)

version_tags <- readRDS("bionic/tags.rds")

# commits_list <-
#   map(version_tags$commit$sha, ~ gh::gh(paste0("/repos/cran/igraph/commits/", .x)))

trusty_graphs <- readRDS("trusty/graphs-linux.rds")
graphs <- readRDS("bionic/graphs-linux.rds")

result <-
  c(trusty_graphs, graphs) |>
  map("result") |>
  enframe(value = "result") |>
  filter(row_number() == 1, .by = name) |>
  mutate(success = map_lgl(result, ~ class(.x) == "igraph"))

version_results <-
  version_tags |>
  left_join(result, by = join_by(name)) |>
  mutate(change = (success != lag(success, default = success[[1]]))) |>
  mutate(change_id = cumsum(change))

version_ranges <-
  version_results |>
  group_by(change_id) |>
  summarize(first_version = last(name), last_version = first(name), success = success[[1]]) |>
  ungroup()

version_results |>
  filter(success) |>
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
    g[[10]] <- as.list(g[[10]])
  }
  class(g) <- cl
  g
}

delta <-
  version_results |>
  mutate(
    prev_name = lead(name),
    prev_change_id = lead(change_id),
  ) |>
  filter(success) |>
  select(name, prev_name, result, change_id, prev_change_id) |>
  mutate(result = map(result, scrub_id)) |>
  mutate(prev_result = lead(result), ) |>
  mutate(same = map2_lgl(result, prev_result, identical, ignore.environment = TRUE)) |>
  mutate(compare = map2(prev_result, result, waldo::compare)) |>
  filter(!same, !is.na(prev_name))

delta

version_ranges |>
  filter(change_id %in% delta$prev_change_id[delta$prev_change_id != delta$change_id])

important_bad_versions <-
  version_results |>
  filter(change_id %in% delta$prev_change_id[delta$prev_change_id != delta$change_id])

important_bad_versions$name

# Need an OS and compilers from 2008 to build those...

delta |>
  transmute(transition = paste0(prev_name, " -> ", name), compare) |>
  rev() |>
  deframe()
