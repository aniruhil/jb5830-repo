"20171217" -> today1 
"2017-12-17" -> today2 
"2017 December 17" -> today3 
"20171217143241" -> today4 
"2017 December 17 14:32:41" -> today5 
"December 17 2017 14:32:41" -> today6 
"17-Dec, 2017 14:32:41" -> today7 

library(tidyverse)
library(lubridate)

ymd(today1) -> date1
ymd(today2) -> date2 
ymd(today3) -> date3 

date1; date2; date3

ymd_hms(today4) -> date4 
ymd_hms(today5) -> date5 

date4; date5

mdy_hms(today6) -> date6 

date6

dmy_hms(today7) -> date7 

date7

load("data/cmhflights_01092017.RData")

names(cmhflights)

library(janitor)

cmhflights %>%
  clean_names() %>%
  select(
    year, month, dayof_month, day_of_week, flight_date, carrier,
    tail_num, flight_num, origin_city_name, dest_city_name,
    dep_time, dep_delay, arr_time, arr_delay, cancelled, diverted
    ) -> cmh.df

cmh.df %>%
  mutate(
    dayofweek = wday(
      day_of_week,
      abbr = FALSE,
      label = TRUE
      ),
    monthname = month(
      month,
      abbr = FALSE,
      label = TRUE
      ),
    weekend = case_when(
      dayofweek %in% c("Saturday", "Sunday") ~ "Weekend",
      TRUE ~ "Weekday"
      )
    ) -> cmh.df 

cmh.df %>%
  count(monthname, sort = TRUE) # (a)

cmh.df %>%
  count(dayofweek, sort = TRUE) # (b) 

cmh.df %>%
  count(weekend, sort = TRUE) # (c) 

cmh.df %>%
  count(monthname, weekend, sort = TRUE) # (d) 

cmh.df %>%
  unite(
    col = "flight_date_time",
    c(flight_date, dep_time),
    sep = ":",
    remove = FALSE
  ) -> cmh.df

cmh.df %>%
  mutate(
    flt_date_time = ymd_hm(flight_date_time)
      ) -> cmh.df

head(cmh.df$flt_date_time)

cmh.df %>%
  mutate(
    flt_hour = hour(flt_date_time),
    flt_minute = minute(flt_date_time)
    ) -> cmh.df

cmh.df %>%
  count(flt_hour, sort = TRUE)

cmh.df %>%
  count(monthname, flt_hour, sort = TRUE)

cmh.df %>%
  group_by(flt_hour) %>%
  summarise(md.delay = median(dep_delay, na.rm = TRUE)) %>%
  arrange(-md.delay)

cmh.df %>%
  group_by(flt_hour) %>%
  summarise(md.delay = median(dep_delay, na.rm = TRUE)) %>%
  arrange(md.delay)

cmh.df %>%
  group_by(dest_city_name, flt_hour) %>%
  summarise(md.delay = median(dep_delay, na.rm = TRUE)) %>%
  arrange(-md.delay)

cmh.df %>%
  group_by(carrier, dest_city_name, flt_hour) %>%
  summarise(md.delay = median(dep_delay, na.rm = TRUE)) %>%
  arrange(-md.delay)

cmh.df %>%
  filter( # eliminates all rows where both these columns are blank 
    !is.na(tail_num),
    !is.na(flt_date_time) 
    ) %>% 
  group_by(tail_num) %>% 
  arrange(flt_date_time) %>% # each aircraft is now stacked by when it flew
  mutate(n_flew = row_number()) %>% # each time aan aircraft is seen it gets a number, 1, 2, 3, and so on ... 
  select(tail_num, flt_date_time, n_flew) %>%
  arrange(-n_flew) -> cmh.df2 # N396SW is seen the most often in this data-set 

cmh.df2 %>%
  head()

cmh.df2 %>%
  group_by(tail_num) %>%
  arrange(flt_date_time) %>%
  mutate(
    tspan = interval(
      lag(flt_date_time, order_by = tail_num), flt_date_time
      ), # calculate the time span between successive flights recorded and save as new varable tspan
    tspan.minutes = as.duration(tspan)/dminutes(1), # convert tspan into minutes and save as tspan.minutes
    tspan.hours = as.duration(tspan)/dhours(1), # convert tspan into hours and save as tspan.hours
    tspan.days = as.duration(tspan)/ddays(1), # convert tspan into days and save as tspan.days 
    tspan.weeks = as.duration(tspan)/dweeks(1) # convert tspan into weeks and save as tspan.weeks 
    ) -> cmh.df2 

cmh.df2 %>%
    filter(tail_num == "N396SW") %>%
    head(., 10)

cmh.df2 %>%
    filter(tail_num == "N396SW") %>%
    tail(., 10)

library(readr)

read_csv(
    "https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-10/saferparks.csv"
    ) -> safer_parks

read_csv(
  "https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-10/tx_injuries.csv"
  ) -> tx_injuries

read_csv(
  "https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-01-15/launches.csv"
  ) -> launches
