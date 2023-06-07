options(conflicts.policy = list(warn = FALSE))

library(tidyverse)

version_tags <- readRDS("tags.rds")

# commits_list <-
#   map(version_tags$commit$sha, ~ gh::gh(paste0("/repos/cran/igraph/commits/", .x)))

graphs <- readRDS("graphs-linux.rds")

result <-
  graphs |>
  map("result") |>
  enframe(value = "result") |>
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
  mutate(compare = map2(result, prev_result, waldo::compare)) |>
  filter(!same)

delta

version_ranges |>
  filter(change_id %in% delta$prev_change_id[delta$prev_change_id != delta$change_id])

important_bad_versions <-
  version_results |>
  filter(change_id %in% delta$prev_change_id[delta$prev_change_id != delta$change_id])

important_bad_versions$name
# 1.0.0
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
# 0.1.2
# 0.1.1

important_bad_versions |>
  pull(result) |>
  map(attr, "condition") |>
  map_chr(conditionMessage) |>
  strsplit("\n") |>
  map(tail, 20) |>
  map(fansi::strip_sgr)
