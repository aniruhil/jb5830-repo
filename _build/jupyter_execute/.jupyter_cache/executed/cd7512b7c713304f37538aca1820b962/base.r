#install.packages(c("patchwork", "tidylog", "leaflet", "htmltools", "highcharter"))

library(patchwork)
library(tidyverse)
library(tidylog)

options(repr.plot.width = 16, repr.plot.height = 8)

ggplot() +
  geom_bar(data = diamonds,
           aes(x = cut, fill = cut)
           ) +
  labs(x = "Cut of the Diamond", y = "Frequency") +
  theme(legend.position = "none") -> p1

ggplot() +
  geom_bar(data = diamonds,
           aes(x = color, fill = color)
           ) +
  labs(x = "Color of the Diamond", y = "Frequency") +
  theme(legend.position = "none") -> p2

ggplot() +
  geom_point(data = diamonds,
           aes(x = carat, y = price, color = cut)
           ) +
  labs(x = "Weight of the Diamond", y = "Price of the Diamond", color = "") +
  theme(legend.position = "bottom") -> p3

ggplot() +
  geom_boxplot(data = diamonds,
           aes(x = price, y = clarity, fill = cut)
           ) +
  labs(y = "Clarity of the Diamond", x = "Price of the Diamond", fill = "") +
  theme(legend.position = "bottom") -> p4

p1; p2; p3; p4

p1 + p2 + p3 

(p1 + p2) / p3

p1 | (p2 + p3)

p1 | (p2 / p3)

options(repr.plot.width = 16, repr.plot.height = 16)

(p1 + p2) / (p3 + p4)

(p1 + p2) / (p3 + p4) +
  plot_annotation(
  title = 'The surprising truth about diamonds',
  subtitle = 'These plots will reveal untold secrets about one of our beloved data-sets',
  caption = 'Disclaimer: None of these plots are insightful',
  tag_levels = c('a', '1'),
  tag_prefix = 'Fig. ',
  tag_sep = '.',
  tag_suffix = ':'
  ) &
  theme(
    plot.tag.position = c(0, 1),
    plot.tag = element_text(size = 9, hjust = 0, vjust = 0, color = "steelblue")
    )

options(repr.plot.width = 16, repr.plot.height = 8)

(p1 + plot_spacer() + p2 + plot_spacer() + p3)

options(repr.plot.width = 16, repr.plot.height = 16)

p1 + p2 + p3 + p4 + 
  plot_layout(widths = c(2, 1))

p1 + p2 + p3 + p4 + 
  plot_layout(
    widths = c(2, 1),
    heights = unit(c(5, 1), c('cm', 'null'))
    )

layout <- "
##BBBB
AACCDD
##CCDD
"
p2 + p3 + p4 + p1 + 
  plot_layout(design = layout)

layout <- c(
  area(t = 2, l = 1, b = 5, r = 4),
  area(t = 1, l = 3, b = 3, r = 5)
  )

p3 + p4 + 
  plot_layout(design = layout)

layout <- '
A##
#B#
##C
'
wrap_plots(A = p1, B = p2, C = p3, design = layout)

library(urbnmapr)

ggplot() +
  geom_polygon(
    data = states, 
    aes(x = long, y = lat, group = group, fill = state_abbv)
    ) +
  coord_fixed(1.3) +
  ggthemes::theme_map() + 
  theme(legend.position = "none") +
  labs(title = "Fixed!!") -> mymap

mymap + p1 + p2 + p3

head(states)

head(counties)

ggplot() +
  geom_polygon(
      data = states, 
      aes(
          x = long, 
          y = lat, 
          group = group),
      fill = "white", 
      color = "steelblue"
  ) +
  coord_fixed(1.3) 

ggplot() +
  geom_polygon(
      data = states, 
      aes(
          x = long, 
          y = lat, 
          group = group, 
          fill = state_name),
      color = "white"
      ) +
  coord_fixed(1.3) +
  ggthemes::theme_map() +
  theme(legend.position = "none")

head(statedata)

states %>%
  left_join(
      statedata, 
      by = c("state_fips", "state_name")
  ) -> state.df

head(state.df)

options(repr.plot.width = 24, repr.plot.height = 16)

ggplot() +
  geom_polygon(
      data = state.df, 
      aes(
          x = long, 
          y = lat, 
          group = group, 
          fill = medhhincome
          ),
          color = "white"
  ) +
  coord_fixed(1.3) +
  ggthemes::theme_map() +
  labs(
    title = "Median Household Income in the States (2015)",
    fill = "Median Household Income"
        ) +
  scale_fill_viridis_c(option = "magma") +
  theme(
      legend.position = "bottom",
      legend.text = element_text(size = 14),
      legend.key.width = unit(5, 'cm'),
      title = element_text(size = 20, face = "bold")
  ) 

counties %>%
  left_join(
      countydata, 
      by = c("county_fips")
  ) -> county.df

ggplot() +
  geom_polygon(data = county.df, 
               aes(x = long, y = lat, group = group, fill = medhhincome),
               color = "white", size = 0.05) +
  coord_fixed(1.3) +
  ggthemes::theme_map() +
  theme(
      legend.position = "bottom",
      legend.text = element_text(size = 14),
      legend.key.width = unit(5, 'cm'),
      title = element_text(size = 20, face = "bold")
  ) +
  labs(
    title = "Median Household Income in the Counties (2015)",
    fill = "Median Household Income"
        ) +
  scale_fill_viridis_c(option = "magma")

county.df %>%
  filter(state_abbv == "FL") %>%
  ggplot() +
  geom_polygon(
               aes(x = long, y = lat, group = group,
                   fill = medhhincome),
               color = "white", size = 0.05
               ) +
  coord_fixed(1.3) +
  ggthemes::theme_map() +
  theme(
      legend.position = "bottom",
      legend.text = element_text(size = 14),
      legend.key.width = unit(5, 'cm'),
      title = element_text(size = 20, face = "bold")
  ) +
  labs(
    title = "Median Household Income in Floria Counties (2015)",
    fill = "Median Household Income"
        ) +
  scale_fill_viridis_c(option = "plasma")

library(tigris)
options(tigris_use_cache = TRUE)

places(
  state = "NH", cb = TRUE, year = 2018, progress_bar = FALSE
  ) -> places.nh

places.nh %>%
    head()

places.nh %>%
  fortify(region = "GEOID") -> nh.df

names(nh.df)

nh.df %>%
    head()

ggplot() +
    geom_polygon(
        data = subset(state.df, state_name == "New Hampshire"),
        aes(x = long, y = lat, group = group),
        fill = "white", color = "black"
        ) + 
    geom_sf(
        data = nh.df,
        aes(fill = GEOID)
        ) +
  ggthemes::theme_map() +
  theme(legend.position = "none")

load("data/nh.data.RData")

head(nh.data)

nh.df %>%
  left_join(
      nh.data, 
      by = c("GEOID" = "GEOID")
  ) -> nh

head(nh)

ggplot() +
  geom_polygon(
    data = subset(
        state.df, 
        state_name == "New Hampshire"
    ),
    aes(
        x = long, 
        y = lat, 
        group = group
    ),
      fill = "white", 
      color = "black"
    ) +
  geom_sf(
    data = nh,
    aes(fill = population)
    ) +
  coord_sf() +
  scale_fill_viridis_c(option = "viridis") + 
  ggthemes::theme_map() +
  theme(
      legend.position = "bottom",
      legend.text = element_text(size = 14),
      legend.key.width = unit(5, 'cm'),
      title = element_text(size = 20, face = "bold")  
  ) +
  labs(
    fill = "Population Size",
    title = "Population Distribution in New Hampshire's Places",
    subtitle = "(American Community Survey, 2014-2018)"
       )

readr::read_csv(
    "https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-03/tickets.csv"
    ) %>%
  mutate(
    year = lubridate::year(issue_datetime),
    month = lubridate::month(issue_datetime)
         ) %>%
  filter(month == 12, lon > -75.5) %>%
  sample_frac(0.2) -> tickets

tickets %>%
  unite(
      display, 
      c(issuing_agency, issue_datetime, fine),
      sep = "; ", 
      remove = FALSE
  ) -> tickets

library(leaflet)
library(htmltools)
library(widgetframe)

lst <- list()

leaflet(tickets) %>%
  addTiles() %>%
  addCircles(
      lng = ~ lon, 
      lat = ~ lat, 
      popup = ~htmlEscape(display),
      color = "steelblue", 
      opacity = 0.10
  ) -> leaf01

leaf01 -> lst

htmltools::tagList(lst)

readr::read_csv(
    "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv"
    ) -> covid 

covid %>%
  filter(
      state == "Ohio", date == "2020-04-17"
  ) -> cov19

library(housingData)

geoCounty %>%
  filter(state == "OH") %>%
  separate(
      county,
      into = c("countyname", "extra"),
      sep = " County",
      remove = TRUE
  ) %>%
  mutate(
      countyname = stringr::str_to_sentence(countyname)
  ) -> oh

oh %>%
  left_join(
      cov19, 
      by = c("countyname" = "county")
  ) -> ohcov19

head(ohcov19)

ohcov19 %>%
  unite(
      display, 
      c(countyname, cases), 
      sep = ": ",
      remove = FALSE
  ) -> ohcov19

head(ohcov19)

lst <- list()

leaflet(ohcov19) %>%
  addTiles() %>%
  addCircleMarkers(
    lng = ~ lon, 
    lat = ~ lat, 
    popup = ~htmlEscape(display),
    color = "salmon", 
    opacity = 0.10, 
    radius = ~sqrt(cases)
    ) -> leaf02

leaf02 -> lst

htmltools::tagList(lst)

lst <- list()

leaflet(ohcov19) %>%
  addTiles() %>%
  addCircleMarkers(
      lng = ~ lon, 
      lat = ~ lat, 
      popup = ~htmlEscape(display),
      color = "salmon", 
      opacity = 0.10, 
      radius = ~cases
    ) -> leaf02bad

leaf02bad -> lst

htmltools::tagList(lst)

library(plotly)

lst <- list()

ggplot() +
  geom_point(
    data = mpg,
    mapping = aes(
        x = cty, 
        y = hwy, 
        color = trans)
    ) +
  labs(
      x = "City Mileage",
      y = "Highway Mileage",
      color = "Transmission"
  ) -> pl01

ggplotly(pl01) -> lst

htmltools::tagList(lst)

library(highcharter)

covid %>%
  filter(
      date == "2020-04-17"
  ) %>%
  rename(
      State = state, 
      `Total Cases` = cases
  ) -> tab1

lst <- list()

hchart(
    tab1, 
    "bar", 
    hcaes(
        x = State, 
        y = `Total Cases`
        )
    ) -> hc01

hc01 -> lst
htmltools::tagList(lst)

covid %>%
  filter(
      state %in% c("Ohio", "Florida", "California", "New Jersey", "Ohio", "New York"),
      date >= "2020-03-01"
  ) %>%
  group_by(state, date) %>%
  mutate(
      log_cases = log(sum(cases))
  ) %>%
    ungroup() -> tab2

head(tab2)

tab2 %>%
    select(state, date, log_cases) %>%
    distinct() -> tab2_nodups

head(tab2_nodups)

lst <- list()

hchart(
    tab2_nodups, 
    "line", 
    hcaes(
        x = date, 
        y = log_cases, 
        group = state
        )
    ) -> hc02

hc02 -> lst
htmltools::tagList(lst)

covid %>%
  group_by(county, state, fips) %>%
  filter(date == "2021-11-15") %>% 
  unite(
      Location, 
      c(county, state), 
      sep = ", ", 
      remove = TRUE
  ) -> tab3

head(tab3)

library(urbnmapr)

data(counties)

head(counties)

counties %>%
  separate(
      county_fips, 
      into = c("stfips", "fips"), 
      sep = 2, 
      remove = FALSE
      ) %>%
  mutate(
      leader = "us", 
      stlower = stringr::str_to_lower(state_abbv)
      ) %>%
  unite(
      code, 
      c(leader, stlower, fips), 
      sep = "-"
      ) -> cdf

head(cdf)

cdf %>%
  select(code, county_fips) %>%
  distinct() -> cdf2

head(cdf2)

tab3 %>%
  left_join(
      cdf2, 
      by = c("fips" = "county_fips")
  ) -> tab4

head(tab4)

library(viridis)

lst <- list()

hcmap("countries/us/us-all-all", 
      data = tab4,
      name = "COVID-19 Cases", value = "cases",
      joinBy = c("hc-key", "code"),
      borderColor = "steelblue") %>%
  hc_colorAxis(stops = color_stops(10, rev(magma(10)))) %>% 
  hc_legend(layout = "horizontal", align = "right",
            floating = TRUE, valueDecimals = 0, valueSuffix = ""
           ) -> hc03

hc03 -> lst

htmltools::tagList(lst)

tab4 %>%
  filter(
      grepl("-oh-", code)
  ) -> tab5

head(tab5)

lst <- list()

hcmap("countries/us/us-oh-all", 
      data = tab5,
      name = "COVID-19 Cases", value = "cases",
      joinBy = c("hc-key", "code"),
      borderColor = "steelblue") %>%
  hc_colorAxis(stops = color_stops(10, rev(magma(10)))) %>% 
  hc_legend(layout = "horizontal", align = "right",
            floating = TRUE, valueDecimals = 0, valueSuffix = ""
           ) -> hc04

hc04 -> lst

htmltools::tagList(lst)

library(tidyverse)

data(USArrests)
names(USArrests)
USArrests$statename <- rownames(USArrests)

head(USArrests)
