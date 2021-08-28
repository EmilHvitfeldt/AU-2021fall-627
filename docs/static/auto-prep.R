library(tidyverse)
Auto <- readr::read_delim("~/Downloads/Auto.data", " ", skip = 1, col_names = FALSE)

readr::read_lines("~/Downloads/Auto.data", n_max = 1) %>%
  str_split("\t") %>%
  .[[1]] %>%
  .[1:7]

var_names <- readr::read_lines("~/Downloads/Auto.data", n_max = 2) %>%
  str_split("[\t ]") %>%
  .[[1]] %>%
  .[1:7]

meanimpute <- function(x) {
  mean_x <- mean(x, na.rm = TRUE)
  x[is.na(x)] <- mean_x
  x
}

auto <- Auto %>%
  select(X1:X7) %>%
  mutate(across(.fns = as.numeric)) %>%
  mutate(across(.fns = meanimpute)) %>%
  set_names(var_names) %>%
  mutate(mpg = ifelse(mpg >= median(mpg), "high", "low"),
         mpg = factor(mpg, levels = c("high", "low")))

readr::write_csv(auto, here::here("data", "auto.csv"))
