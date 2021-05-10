suppressPackageStartupMessages({
  library(arrow)
  library(tidyverse)
  library(lubridate)
  library(rvest)
  library(usethis)
})

ui_info("Retrieving path...")
path <-
  read_html("https://www.football-data.co.uk/japan.php") %>%
  html_node(css = "a:contains('CSV')") %>%
  html_attr("href") %>%
  map_chr( ~ str_c("https://www.football-data.co.uk/", .))
ui_info("OK")

ui_info("Retrieving results...")
results <- read_csv(
  path,
  col_types = cols(
    .default = col_skip(),
    Season = col_character(),
    Date = col_character(),
    Time = col_character(),
    Home = col_character(),
    Away = col_character(),
    HG = col_integer(),
    AG = col_integer(),
    Res = col_character()
  )
) %>%
  drop_na(Date)
ui_info("OK")

ui_info("Parsing dates...")
results <- results %>%
  mutate(
    DateTime = Date %>%
      str_c(replace_na(Time, ""), sep = " ") %>%
      parse_date_time(c("dmy", "dmy HM"), tz = "GMT"),
    Date = NULL,
    Time = NULL
  ) %>%
  select(Season, DateTime, everything())
ui_info("OK")

ui_info("Saving results...")
unlink("data", recursive = TRUE)
dir.create("data")
write_parquet(results, "data/results.parquet")
write_csv(results, "data/results.csv")
ui_info("OK")
