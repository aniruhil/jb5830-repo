library(tidyverse)

read_csv(
  "https://www2.census.gov/programs-surveys/popest/datasets/2010-2018/metro/totals/cbsa-est2018-alldata.csv"
  ) -> cbsa

cbsa %>%
  select(NAME) %>%
  glimpse()
  

cbsa %>%
  separate(
    col = NAME, 
    into = c("placename", "stateabb"),
    sep = ", ",
    remove = FALSE
  ) -> cbsa 

cbsa %>%
  select(NAME, placename, stateabb) %>%
  head()

cbsa %>%
    head()

cbsa %>%
  separate(
    col = STCOU, 
    into = c("stfips", "coufips"),
    sep = 2,
    remove = FALSE
  ) -> cbsa

cbsa %>%
  select(STCOU, stfips, coufips) %>%
  head()

read_csv(
  "https://www2.census.gov/programs-surveys/popest/datasets/2010-2018/counties/totals/co-est2018-alldata.csv"
  ) -> coudf

coudf %>%
  filter(COUNTY != "000") -> coudf2

coudf2 %>%
  select(STNAME, CTYNAME) %>%
  head()

coudf2 %>%
  unite(
    col = "countystate",
    c("CTYNAME", "STNAME"),
    sep = ", ",
    remove = FALSE
  ) -> coudf2

coudf2 %>%
  select(CTYNAME, STNAME, countystate) %>%
  head()

read_csv(
  "https://www2.census.gov/programs-surveys/popest/datasets/2010-2018/metro/totals/cbsa-est2018-alldata.csv"
  ) -> cbsa

cbsa %>%
  select(c(4, 8:16)) -> cbsa01

cbsa01 %>%
  head()

cbsa01 %>%
  group_by(NAME) %>%
  pivot_longer(
    names_to = "variable",
    values_to = "POPULATION",
    cols = 2:10
  ) -> cbsa01.long

cbsa01.long %>%
  head()

cbsa01.long %>%
  separate(
    col = variable,
    into = c("todiscard", "toyear"),
    sep = 11,
    remove = TRUE) -> cbsa01.long2

cbsa01.long2 %>%
  mutate(YEAR = as.numeric(toyear)) %>%
    select(c(NAME, YEAR, POPULATION)) -> cbsa01.long3

cbsa01.long3 %>%
  head()

cbsa01.long %>%
    mutate(
    Year = stringr::str_remove_all(variable, "POPESTIMATE")
    ) -> cbsa.long4

cbsa.long4 %>%
    select(-variable) %>%
    head()

us_rent_income %>%
  head()

us_rent_income %>%
  group_by(GEOID, NAME) %>%
  pivot_wider(
    names_from = variable,
    values_from = c(estimate, moe)
  ) -> usri.wide

usri.wide %>%
  head()

cbsa %>%
  select(3:5, 8:88) %>%
  group_by(NAME) %>%
  pivot_longer(
    names_to = "variable",
    values_to = "estimate",
    cols = 4:84
    ) -> cbsa.01

cbsa.01 %>%
  head(., 20)

cbsa.01 %>%
  separate(
    col = "variable",
    into = c("vartype", "year"),
    sep = "(?=[[:digit:]])",
    extra = "merge",
    remove = FALSE
  ) -> cbsa.02

cbsa.02 %>%
  head()

names(cbsa)

cbsa.02 %>%
  select(c(2, 5:7)) %>%
  group_by(NAME, year) %>%
  pivot_wider(
    names_from = "vartype",
    values_from = "estimate"
  ) -> cbsa.03

cbsa.03 %>%
  glimpse()

read.delim(
 file = "http://stat405.had.co.nz/data/weather.txt",
 stringsAsFactors = FALSE
 ) -> weather

weather


