library(ggplot2movies)
data(movies)
names(movies)

library(tidyverse)
data(starwars)
names(starwars)
# str(starwars)

library(ggplot2)

options(repr.plot.width = 16, repr.plot.height = 8) 

ggplot(
  data = starwars
  )

ggplot(
  data = starwars,
  mapping = aes(
    x = eye_color
    )
  ) 

ggplot(
  data = starwars,
  mapping = aes(
    x = eye_color
    )
  ) +
  geom_bar()

ggplot(
  data = starwars,
  mapping = aes(
    x = eye_color,
    color = eye_color
    )
  ) +
  geom_bar()

ggplot(
  data = starwars,
  mapping = aes(
    x = eye_color,
    fill = eye_color
    )
  ) +
  geom_bar()

ggplot(
  data = starwars,
  mapping = aes(
    x = eye_color,
    fill = eye_color
    )
  ) +
  geom_bar() +
  labs(
    x = "Eye Color",
    y = "Frequency (n)",
    title = "Bar-chart of Eye Colors",
    subtitle = "(of Star Wars characters)",
    caption = "My little work of art!!"
    )

ggplot(
  data = starwars,
  mapping = aes(
    x = eye_color,
    fill = eye_color
    )
  ) +
  geom_bar() +
  labs(
    x = "Eye Color",
    y = "Frequency (n)",
    title = "Bar-chart of Eye Colors",
    subtitle = "(of Star Wars characters)",
    caption = "My little work of art!!"
    ) +
  theme(legend.position = "none")

c(
  "black", "blue", "slategray", "brown", "gray34", "gold",
  "greenyellow", "navajowhite1", "orange", "pink", "red",
  "magenta", "thistle3", "white", "yellow"
  ) -> mycolors

ggplot(
  data = starwars,
  mapping = aes(
    x = eye_color
    )
  ) + 
  geom_bar(
    fill = mycolors
    ) + 
  labs(
    x = "Eye Color",
    y = "Frequency (n)",
    title = "Bar-chart of Eye Colors",
    subtitle = "(of Star Wars characters)",
    caption = "My little work of art!!"
    ) +
  theme(legend.position = "none")

ggplot(
  data = starwars,
  mapping = aes(
    x = gender
    )
  ) + 
  geom_bar(
    aes(fill = gender)
    ) + 
  labs(
    x = "Gender",
    y = "Frequency",
    title = "Bar-chart of Gender",
    subttitle = "(of Star Wars characters)",
    caption = "(Source: The dplyr package)") +
  scale_fill_brewer(
    palette = "Pastel1"
    )

ggplot(
  data = starwars,
  mapping = aes(
    x = gender
    )
  ) + 
  geom_bar(
    aes(fill = gender)
    ) + 
  labs(
    x = "Gender",
    y = "Frequency",
    title = "Bar-chart of Gender",
    subttitle = "(of Star Wars characters)",
    caption = "(Source: The dplyr package)") +
  scale_fill_brewer(
    palette = "Set1"
    )

ggplot(
  data = subset(starwars, !is.na(gender)),
  mapping = aes(
    x = gender
    )
  ) + 
  geom_bar(
    aes(fill = gender)
    ) + 
  labs(
    x = "Gender",
    y = "Frequency",
    title = "Bar-chart of Gender",
    subttitle = "(of Star Wars characters)",
    caption = "(Source: The dplyr package)") +
  scale_fill_brewer(
    palette = "Set1"
    )

starwars %>%
  filter(!is.na(gender)) -> my.data

ggplot(
  data = my.data,
  mapping = aes(
    x = gender
    )
  ) + 
  geom_bar(
    aes(fill = gender)
    ) + 
  labs(
    x = "Gender",
    y = "Frequency",
    title = "Bar-chart of Gender",
    subttitle = "(of Star Wars characters)",
    caption = "(Source: The dplyr package)") +
  scale_fill_brewer(
    palette = "Set1"
    )

ggplot(
  data = my.data,
  mapping = aes(
    x = gender
    )
  ) + 
  geom_bar(
    aes(fill = gender)
    ) + 
  labs(
    x = "Gender",
    y = "Frequency",
    title = "Bar-chart of Gender",
    subttitle = "(of Star Wars characters)",
    caption = "(Source: The dplyr package)") +
  scale_fill_viridis_d(
    option = "viridis"
    )

ggplot(
  data = my.data,
  mapping = aes(
    x = gender
    )
  ) + 
  geom_bar(
    aes(fill = gender)
    ) + 
  labs(
    x = "Gender",
    y = "Frequency",
    title = "Bar-chart of Gender",
    subttitle = "(of Star Wars characters)",
    caption = "(Source: The dplyr package)") +
  scale_fill_viridis_d(
    option = "magma"
    )

ggplot(
  data = my.data,
  mapping = aes(
    x = gender
    )
  ) + 
  geom_bar(
    aes(fill = gender)
    ) + 
  labs(
    x = "Gender",
    y = "Frequency",
    title = "Bar-chart of Gender",
    subttitle = "(of Star Wars characters)",
    caption = "(Source: The dplyr package)") +
  scale_fill_viridis_d(
    option = "plasma"
    )

ggplot(
  data = my.data,
  mapping = aes(
    x = gender
    )
  ) + 
  geom_bar(
    aes(fill = gender)
    ) + 
  labs(
    x = "Gender",
    y = "Frequency",
    title = "Bar-chart of Gender",
    subttitle = "(of Star Wars characters)",
    caption = "(Source: The dplyr package)") +
  scale_fill_viridis_d(
    option = "cividis"
    )

library(ggthemes)

ggplot(
  data = starwars,
  mapping = aes(
    x = eye_color
    )
  ) +
  geom_bar() +
  theme_tufte() 

ggplot(
  data = starwars,
  mapping = aes(
    x = eye_color
    )
  ) +
  geom_bar() +
  theme_economist() 

ggplot(
  data = starwars,
  mapping = aes(
    x = eye_color
    )
  ) +
  geom_bar() +
  theme_fivethirtyeight() 

ggplot(
  data = movies,
  mapping = aes(
    x = mpaa
    )
  ) + 
  geom_bar()

ggplot() + 
  geom_bar(
    data = movies,
    mapping = aes(x = mpaa)
    )

movies %>% 
  filter(mpaa != "") -> movies2 

ggplot() + 
  geom_bar(
    data = movies2,
    mapping = aes(x = mpaa)
    )

df = tibble(x = c(rep("A", 2), rep("B", 4), rep("C", 1)))

ggplot() + 
  geom_bar(
    data = df, 
    mapping = aes(x = x)
  )

library(scales)

ggplot() + 
  geom_bar(
    data = movies2,
    mapping = aes(
      x = mpaa,
      y = (..count..)/sum(..count..)
      )
    ) + 
  scale_y_continuous(labels = percent) + 
  labs(
    x = "MPAA Rating",
    y  = "Relative Frequency (%)"
    ) 

read.table(
  'https://stats.idre.ucla.edu/stat/data/hsb2.csv',
  header = TRUE,
  sep = ","
  ) -> hsb2

factor(hsb2$female,
       levels = c(0, 1),
       labels = c("Male", "Female")
       ) -> hsb2$female 

factor(hsb2$race,
       levels = c(1:4),
       labels = c("Hispanic", "Asian", "African American", "White")
       ) -> hsb2$race

factor(hsb2$ses,
       levels = c(1:3),
       labels = c("Low", "Middle", "High")
       ) -> hsb2$ses

factor(hsb2$schtyp,
       levels = c(1:2),
       labels = c("Public", "Private")
       ) -> hsb2$schtyp

factor(hsb2$prog,
       levels = c(1:3),
       labels = c("General", "Academic", "Vocational")
       ) -> hsb2$prog

save(
  hsb2, file = here::here("data", "hsb2.RData")
  )

ggplot() + 
  geom_bar(
    data = hsb2,
    mapping = aes(x = ses)) +
  labs(x = "Socioeconomic Status")

ggplot() + 
  geom_bar(
    data = hsb2,
    mapping = aes(
      x = ses,
      group = female, 
      fill = female
      )
    ) +
  labs(
    x = "Socioeconomic Status",
    y = "Frequency"
  )

ggplot() + 
  geom_bar(
    data = hsb2,
    mapping = aes(
      x = ses,
      group = female, 
      fill = female
      ),
    position = "dodge"
    ) +
  labs(
    x = "Socioeconomic Status",
    y = "Frequency"
  )

ggplot() + 
  geom_bar(
    data = hsb2, 
    aes(
      x = ses, 
      group = female,
      fill = female, 
      y = ..prop..
      ),
    position = "dodge") +
  scale_y_continuous(labels = scales::percent) + 
  labs(
    x = "Socioeconomic Status",
    y = "Relative Frequency (%)"
    )

ggplot() + 
  geom_bar(
    data = hsb2, 
    aes(
      x = female, 
      group = ses,
      fill = ses, 
      y = ..prop..
      ),
    position = "dodge") +
  scale_y_continuous(labels = scales::percent) + 
  labs(
    x = "Socioeconomic Status",
    y = "Relative Frequency (%)"
    )

ggplot() + 
  geom_bar(
    data = hsb2, 
    aes(
      x = female, 
      group = ses,
      fill = ses, 
      y = ..prop..
      ),
    position = "dodge") +
  scale_y_continuous(labels = scales::percent) + 
  labs(
    x = "Socioeconomic Status",
    y = "Relative Frequency (%)"
    ) 

ggplot() + 
  geom_histogram(
    data = hsb2,
    aes(x = read), 
    fill = "cornflowerblue",
    color = "white"
    ) + 
  labs(
    title = "Histogram of Reading Scores",
    x = "Reading Score",
    y = "Frequency"
    )

ggplot() + 
  geom_histogram(
    data = hsb2,
    aes(x = read), 
    fill = "cornflowerblue",
    color = "white",
    bins = 5
    ) + 
  labs(
    title = "Histogram of Reading Scores",
    subtitle = "(with bins = )",
    x = "Reading Score",
    y = "Frequency"
    )

ggplot() + 
  geom_histogram(
    data = hsb2,
    aes(x = read), 
    fill = "cornflowerblue",
    color = "white",
    binwidth = 5
    ) + 
  labs(
    title = "Histogram of Reading Scores",
    subtitle = "(with binwidth = )",
    x = "Reading Score",
    y = "Frequency"
    )

ggplot() + 
  geom_histogram(
    data = hsb2,
    aes(x = read), 
    fill = "cornflowerblue",
    color = "white",
    bins = 5
    ) + 
  labs(
    title = "Histogram of Reading Scores",
    subtitle = "(broken out for Male vs. Female students)",
    x = "Reading Score",
    y = "Frequency"
    ) +
  facet_wrap(~ female)

ggplot() + 
  geom_histogram(
    data = hsb2,
    aes(x = read), 
    fill = "cornflowerblue",
    color = "white",
    bins = 5
    ) + 
  labs(
    title = "Histogram of Reading Scores",
    subtitle = "(broken out for Male vs. Female students)",
    x = "Reading Score",
    y = "Frequency"
    ) +
  facet_wrap(~ female, ncol = 1)

ggplot() + 
  geom_histogram(
    data = hsb2,
    aes(x = read), 
    fill = "cornflowerblue",
    color = "white",
    bins = 5
    ) + 
  labs(
    title = "Histogram of Reading Scores",
    subtitle = "(broken out by Socioeconomic Status)",
    x = "Reading Score",
    y = "Frequency"
    ) +
  facet_wrap(~ ses, ncol = 1)

ggplot() + 
  geom_histogram(
    data = hsb2,
    aes(x = read), 
    fill = "cornflowerblue",
    color = "white",
    bins = 5
    ) + 
  labs(
    title = "Histogram of Reading Scores",
    subtitle = "(broken out by Socioeconomic Status and School Type)",
    x = "Reading Score",
    y = "Frequency"
    ) +
  facet_wrap(ses ~ schtyp, ncol = 3)

ggplot() + 
  geom_histogram(
    data = hsb2,
    aes(x = read), 
    fill = "cornflowerblue",
    color = "white",
    bins = 5
    ) + 
  labs(
    title = "Histogram of Reading Scores",
    subtitle = "(broken out by Socioeconomic Status and School Type)",
    x = "Reading Score",
    y = "Frequency"
    ) +
  facet_wrap(schtyp ~ ses, ncol = 3) +
  ylim(c(0, 23))

load(
  here::here("data", "cmhflights_01092017.RData")
  )

ggplot() + 
  geom_boxplot(
    data = cmhflights,
    mapping = aes(
      y = ArrDelay,
      x = ""
      ),
    fill = "cornflowerblue"
    ) 

ggplot() + 
  geom_boxplot(
    data = cmhflights,
    mapping = aes(
      y = ArrDelay,
      x = ""
      ),
    fill = "cornflowerblue"
    ) +
  coord_flip()

read_csv(
  "http://whitlockschluter.zoology.ubc.ca/wp-content/data/chapter02/chap02e3cHumanHemoglobinElevation.csv"
  ) -> hemoglobin

ggplot() +
  geom_boxplot(
    data = hemoglobin,
    mapping = aes(
      x = population,
      y = hemoglobin,
      fill = population
      )
    ) +
  coord_flip() +
  labs(
    x = "Population",
    y = "Hemoglobin Concentration",
    title = "Hemoglobin Concentration in Adult Males",
    subtitle = "(Andes, Ethiopia, Tibet, USA)"
    ) +
  theme(legend.position = "none")

ggplot() + 
  geom_boxplot(
    data = cmhflights,
    mapping = aes(
      y = ArrDelay,
      x = Carrier
      ),
    fill = "cornflowerblue"
    ) +
  coord_flip() +
  facet_wrap(~ Month)

library(plotly)
data(economics)
names(economics)
ggplot() +
  geom_line(
    data = economics, 
    mapping = aes(
      x = date,
      y = uempmed
      )
    ) + 
  labs(
    x = "Date",
    y = "Unemployment Rate"
  )

load(
  here::here("data", "gap.df.RData")
  )

gap.df %>%
    ungroup() %>%
    ggplot() +
    geom_line(
    mapping = aes(
      x = year,
      y = LifeExp,
      group = continent,
      color = continent
      )
    ) + 
  geom_point(
    mapping = aes(
      x = year,
      y = LifeExp,
      group = continent,
      color = continent
      )
    ) + 
  labs(
    x = "Year",
    y = "Median Life Expectancy (in years)",
    color = ""
  ) + 
  theme(legend.position = "bottom") 

ggplot() + 
  geom_point(
    data = hsb2, 
    mapping = aes(
      x = write,
      y = science
      )
    ) +
  labs(
    x = "Writing Scores", 
    y = "Science Scores"
    ) 

ggplot() +
  geom_point(
    data = hsb2,
    mapping = aes(
      x = write,
      y = science,
      color = ses
      )
    ) + 
  labs(
    x = "Writing Scores", 
    y = "Science Scores",
    color = ""
    ) + 
  theme(legend.position = "bottom") 

ggplot() +
  geom_point(
    data = hsb2,
    mapping = aes(
      x = write,
      y = science
      )
    ) + 
  labs(
    x = "Writing Scores", 
    y = "Science Scores"
    ) + 
  facet_wrap(~ ses) 

ggplot() +
  geom_point(
    data = hsb2,
    mapping = aes(
      x = write,
      y = science
      )
    ) + 
  labs(
    x = "Writing Scores", 
    y = "Science Scores"
    ) + 
  facet_wrap(ses ~ female, ncol = 2) 

readr::read_csv(
    "https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-05-14/nobel_winners.csv"
    ) -> nobel_winners 

library(readxl)
url <- "https://aniruhil.github.io/avsr/teaching/dataviz/greatlakes.xlsx"
destfile <- "greatlakes.xlsx"
curl::curl_download(url, destfile)
read_excel(destfile, col_types = c("date", 
     "numeric", "numeric", "numeric", "numeric", 
     "numeric")) -> greatlakes 

greatlakes %>%
    head()

library(readxl)
url <- "https://aniruhil.github.io/avsr/teaching/dataviz/CountyHealthRankings2017.xlsx"
destfile <- "CountyHealthRankings2017.xlsx"
curl::curl_download(url, destfile)
read_excel(destfile) -> chr.df 

chr.df %>%
    head()

load("data/unemprate.RData")

urate %>%
    head()
