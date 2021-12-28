library(tidyverse)

read.csv(
    "data/ImportDataCSV.csv",
    sep = ",",
    header = TRUE
    ) -> df.csv 

read.csv(
  "data/ImportDataTAB.txt",
  sep = "\t",
  header = TRUE
  ) -> df.tab

names(df.csv) 

glimpse(df.csv)

# And now we repeat the preceding commands for the df.tab file

names(df.tab)

glimpse(df.tab)

library(readxl)

read_excel(
  "data/ImportDataXLS.xls"
  ) -> df.xls 

read_excel(
  "data/ImportDataXLSX.xlsx"
  ) -> df.xlsx

names(df.xls)

glimpse(df.xls)

names(df.xlsx)

glimpse(df.xlsx)

library(haven)

read_stata(
  "data/ImportDataStata.dta"
  ) -> df.stata

read_sas(
  "data/ImportDataSAS.sas7bdat"
  ) -> df.sas

read_sav(
  "data/ImportDataSPSS.sav"
  ) -> df.spss

# Check the files

names(df.stata)

glimpse(df.sas)

read.fwf(
  "data/fwfdata.txt",
  widths = c(4, 9, 2, 4),
  header = FALSE,
  col.names = c("Name", "Month", "Day", "Year")
  ) -> df.fw 

glimpse(df.fw)

read.table(
  "http://data.princeton.edu/wws509/datasets/effort.dat"
  ) -> fpe 

fpe # This command asks R to show us what fpe contains 

read.table(
  "https://stats.idre.ucla.edu/stat/data/test.txt",
  header = TRUE
  ) -> test.txt 

read_csv(
  "https://stats.idre.ucla.edu/stat/data/test.csv"
  ) -> test.csv

read_sav(
  "https://stats.idre.ucla.edu/stat/data/hsb2.sav"
  ) -> hsb2.spss 

read.table(
  'https://stats.idre.ucla.edu/stat/data/hsb2.csv',
  header = TRUE,
  sep = ","
  ) -> hsb2

summary(hsb2)

factor(hsb2$female,
       levels = c(0, 1),
       labels = c("Male", "Female")
       ) -> hsb2$female.f 

factor(hsb2$race,
       levels = c(1:4),
       labels = c("Hispanic", "Asian", "African American", "White")
       ) -> hsb2$race.f

factor(hsb2$ses,
       levels = c(1:3),
       labels = c("Low", "Middle", "High")
       ) -> hsb2$ses.f

factor(hsb2$schtyp,
       levels = c(1:2),
       labels = c("Public", "Private")
       ) -> hsb2$schtyp.f

factor(hsb2$prog,
       levels = c(1:3),
       labels = c("General", "Academic", "Vocational")
       ) -> hsb2$prog.f

summary(hsb2)

save(hsb2, file = "data/hsb2.RData")

load("data/hsb2.RData")

summary(hsb2)

install.packages('palmerpenguins')

library(palmerpenguins)

data(penguins, package = 'palmerpenguins')

head(penguins)

library(ggplot2)

data(diamonds, package = 'ggplot2')

head(diamonds)
