library(tidyverse) 

library(here)

load(
  here("data", "cmhflights_01092017.RData")
  )

dim(cmhflights)

names(cmhflights) # will show you the column names

cmhflights$X110 <- NULL #This command will delete the column named X110 

names(cmhflights)

cmhflights %>% 
  select(Year:DayOfWeek) -> my.df

names(my.df)

cmhflights %>%
  select(Year, Quarter, Month, DayofMonth, DayOfWeek) -> my.df 

names(my.df)

cmhflights %>% 
  select(Year, FlightDate:UniqueCarrier, TailNum) -> my.df 

names(my.df)

cmhflights %>% 
  select(c(1, 3, 5, 7)) -> my.df 

names(my.df)

cmhflights %>% 
  select(c(1:5)) -> my.df 

names(my.df)

cmhflights %>% 
  select(c(1, 6:9, 12)) -> my.df

names(my.df)

cmhflights %>% 
  select(contains("Carrier")) -> my.df

names(my.df)

cmhflights %>% 
  select(starts_with("De")) -> my.df

names(my.df)

cmhflights %>% 
  select(ends_with("Num")) -> my.df

names(my.df)

cmhflights %>%
    select(matches("el")) -> my.df

names(my.df)

head(billboard)

billboard %>%
    select(num_range("wk", 1:5)) -> my.df

names(my.df)

cmhflights %>% 
  filter(Month == 1) -> my.df

table(my.df$Month) # Show me a frequency table for Month in my.df

cmhflights %>% 
  filter(Month == 1, UniqueCarrier == "AA") -> my.df 

table(my.df$Month, my.df$UniqueCarrier) # a simple frequency table

cmhflights %>% 
  filter(Month == 1, UniqueCarrier == "UA", Dest == "CMH") -> my.df

cmhflights %>% 
  filter(
    Month %in% c(1, 2), UniqueCarrier == "UA", Dest %in% c("CMH", "ORD")
    ) -> my.df 

table(my.df$Month) # frequency table of Month

table(my.df$UniqueCarrier) # frequency table of UniqueCarrier

table(my.df$Dest) # frequency table of Dest

cmhflights %>%
    filter(Month >= 3) -> my.df

table(my.df$Month)

cmhflights %>%
filter(is.na(DepDelay)) -> my.df

summary(my.df$DepDelay)

cmhflights %>% 
    select('Year', 'Month', 'DayofMonth', 'FlightDate', 'Carrier', 'TailNum', 'FlightNum', 
           'Origin', 'OriginCityName', 'Dest', 'DestCityName', 'CRSDepTime', 'DepTime', 
           'DepDelay', 'DepDelayMinutes', 'CRSArrTime', 'ArrTime', 'ArrDelay', 'ArrDelayMinutes') %>%
    filter(Dest %in% c("CMH", "ORD")) -> my.df

my.df %>% 
  arrange(DepDelayMinutes) -> my.df2

my.df2

my.df %>% 
  arrange(-DepDelayMinutes) -> my.df2

my.df2

my.df %>% 
  arrange(Dest, -DepDelayMinutes) -> my.df2

my.df2

cmhflights %>% 
  select(Month, UniqueCarrier, Dest, DepDelayMinutes) %>% 
  filter(
    Month %in% c(1, 2), UniqueCarrier == "UA", Dest %in% c("CMH", "ORD")
    ) %>% 
  arrange(Month, Dest, -DepDelayMinutes) -> my.df3

my.df3

cmhflights %>%
  count(Month) # Most flights were in July (n = 4295)

cmhflights %>%
  count(Month, DayOfWeek) # Output is sorted by Month and then DayOfWeek

cmhflights %>%
  summarise(
      mean_arr_delay = mean(ArrDelay, na.rm = TRUE),
      mean_dep_delay = mean(DepDelay, na.rm = TRUE),
      median_arr_delay = median(ArrDelay, na.rm = TRUE),
      median_dep_delay = median(DepDelay, na.rm = TRUE),
      variance_arr_delay = median(ArrDelay, na.rm = TRUE),
      variance_dep_delay = median(DepDelay, na.rm = TRUE),  
      sd_arr_delay = sd(ArrDelay, na.rm = TRUE),
      sd_dep_delay = sd(DepDelay, na.rm = TRUE)
  )

df = data.frame(x = c(2, 4, 9, NA))

df %>%
  summarise(mean.x = mean(x)) # You get no meaningful values 

df %>%
  summarise(mean.x = mean(x, na.rm = TRUE)) # Now you do get something meaningful

cmhflights %>%
    group_by(Carrier) %>%
    summarize(sum(DepDelay, na.rm = TRUE))

cmhflights %>%
  group_by(Month, Carrier) %>%
  tally()

cmhflights %>%
  group_by(Month, Carrier) %>%
  summarize(
    frequency = n()
    )

cmhflights %>%
  group_by(Month, Carrier, Dest) %>%
  tally()

cmhflights %>%
  group_by(Month, Carrier, Dest, DayOfWeek) %>%
  tally()

cmhflights %>%
  group_by(Month, Carrier, Dest, DayOfWeek) %>%
  summarise(mean_dep_delay = mean(DepDelay, na.rm = TRUE))

cmhflights %>%
  group_by(Carrier) %>%
  summarise(mean_dep_delay = mean(DepDelay, na.rm = TRUE)) %>%
  arrange(-mean_dep_delay) # ordered in descending order of delays

cmhflights %>%
  group_by(Carrier, Month) %>%
  summarise(mean_dep_delay = mean(DepDelay, na.rm = TRUE)) %>%
  arrange(mean_dep_delay) # ordered in descending order of delays

cmhflights %>%
  select(c(Carrier, DepDelay)) %>%
  filter(
      Carrier %in% c("AA", "DL", "UA", "WN")
  ) %>%
  mutate(
      late = case_when(
          DepDelay > 0 ~ "Yes",
          DepDelay <= 0 ~ "No"
      )
  ) %>% 
  group_by(Carrier) %>%
  mutate(
      nflights = n()
  ) %>%
  group_by(Carrier, late) %>%
  mutate(
    nlate = n(),
    pct_late = (nlate / nflights) * 100
  ) -> df1

df1

df1 %>%
  filter(late == "Yes") %>%
  ungroup() %>%
  select(Carrier, pct_late) %>%
  distinct() %>%
  arrange(pct_late)

cmhflights %>%
  select(c(Carrier, Month, DepDelay)) %>%
  filter(Carrier %in% c("AA", "DL", "UA", "WN")) %>%
  mutate(late = case_when(
    DepDelay > 0 ~ "Yes",
    DepDelay <= 0 ~ "No"
      )
    ) %>% 
  group_by(Carrier, Month) %>%
  mutate(nflights = n()) %>%
  group_by(Carrier, Month, late) %>%
  mutate(
    nlate = n(),
    pct_late = (nlate / nflights) * 100) %>%
  filter(late == "Yes") %>%
  ungroup() %>%  
  select(Carrier, Month, pct_late) %>%
  distinct() %>%
  arrange(pct_late)

cmhflights %>%
    mutate(
      carrier_name = case_when(
          Carrier == "AA" ~ "American Airlines",
          Carrier == "DL" ~ "Delta Airlines",
          Carrier == "UA" ~ "United Airlines",
          Carrier == "EV" ~ "Express Jet",
          Carrier == "F9" ~ "Frontier Airlines",
          Carrier == "WN" ~ "Southwest Airlines",
          Carrier == "OO" ~ "SkyWest Airlines"
      )
  ) %>%
    select(Carrier, carrier_name) %>%
    group_by(Carrier, carrier_name) %>%
    tally()

cmhflights %>%
  mutate(weekend = case_when(
    DayOfWeek %in% c(7, 1) ~ "Yes",
    TRUE ~ "No"
        )
    ) %>%
  select(DayOfWeek, weekend) %>%
  distinct()

read.table(
  'https://stats.idre.ucla.edu/stat/data/hsb2.csv',
  header = TRUE,
  sep = ","
  ) -> hsb2

hsb2 %>%
  mutate(
    female.f = case_when(
      female == 0 ~ "Male",
      female == 1 ~ "Female"),
    race.f = case_when(
      race == 1 ~ "Hispanic",
      race == 2 ~ "Asian",
      race == 3 ~ "African-American",
      TRUE ~ "White"),
    ses.f = case_when(
      ses == 1 ~ "Low",
      ses == 2 ~ "Medium",
      TRUE ~ "High"),
    schtyp.f = case_when(
      schtyp == 1 ~ "Public",
      TRUE ~ "Private"),
    prog.f = case_when(
      prog == 1 ~ "General",
      prog == 2 ~ "Academic",
      TRUE ~ "Vocational")
    ) -> hsb2

cmhflights %>%
  filter(Origin == "CMH") %>%
  count(Dest, sort = TRUE)

cmhflights %>%
  filter(Origin == "CMH") %>%
  count(Carrier, Dest, sort = TRUE)

cmhflights %>%
  summarise(n_distinct(TailNum))

cmhflights %>%
  group_by(Carrier) %>%
  summarise(num.flights = n_distinct(TailNum)) %>%
  arrange(-num.flights) %>% 
  top_n(4)

cmhflights %>%
  filter(!is.na(TailNum)) %>% # Removing some missing cases 
  group_by(TailNum) %>%
  tally() %>% 
  arrange(-n) %>%
  top_n(4)

tibble(
  Name = c("Tim", "Tammy", "Bubbles", "Panda"),
  Score = c(5, 8, 9, 10)
    ) -> df1

tibble(
  Name = c("Tim", "Tammy", "Bubbles"),
  Age = c(25, 78, 19)
    ) -> df2

tibble(
  Name = c("Tim", "Tammy", "Panda"),
  Education = c("BA", "PhD", "JD")
    ) -> df3

df1; df2; df3

df1 %>%
  full_join(df2, by = "Name") %>%
  full_join(df3, by = "Name") 

df2 %>%
  left_join(df3, by = "Name")  

df3 %>%
  left_join(df2, by = "Name")  

df2 %>%
  anti_join(df3, by = "Name")

df3 %>%
  anti_join(df2, by = "Name")

library(santoku)

cmhflights %>%
  mutate(
    depdelay_groups = chop_equally(DepDelay, groups = 4)
      ) %>%
  group_by(depdelay_groups) %>%
  tally()

cmhflights %>%
  mutate(
    depdelay_groups = chop(DepDelay, breaks = c(0, 15, 30, 45))
      ) %>%
  group_by(depdelay_groups) %>%
  tally()

cmhflights %>%
  filter(!is.na(DepDelay)) %>%
  mutate(
    depdelay_groups = chop_quantiles(
      DepDelay, c(0.2, 0.4, 0.6, 0.8)
    )
  ) %>%
  group_by(depdelay_groups) %>%
  tally()

cmhflights %>%
  filter(!is.na(DepDelay)) %>%
  mutate(
    depdelay_groups = chop_quantiles(
      DepDelay, seq(0.1, 0.9, by = 0.1)
    )
  ) %>%
  group_by(depdelay_groups) %>%
  tally()

cmhflights %>%
  filter(!is.na(DepDelay)) %>%
  mutate(
    depdelay_groups = chop_evenly(
        DepDelay,
        4
    )
  ) %>%
  group_by(depdelay_groups) %>%
  tally()

tibble(
  response = c(
      rep("Agree", 25), 
      rep("Neutral", 30), 
      rep("Disagree", 45)
      )
    ) -> mydf

mydf %>%
  group_by(response) %>%
  tally()

mydf %>%
  mutate(
      ordered.response = ordered(
          response,
          levels = c("Agree", "Neutral", "Disagree")
      )
    ) %>%
  group_by(ordered.response) %>%
  tally()
