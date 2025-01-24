# load library
library(tidyverse)
library(glue)
library(RSQLite)
library(readxl)
library(jsonlite)

## glue => string template

name <- "toy"
age <- 35

glue("Hello my name is {name}, and I'm {age} years old")

## connect SQLite Database
# create connection

con <- dbConnect(SQLite(),"chinook.db")

## how many table
dbListTables(con)

## check columns name 
dbListFields(con,"customers")

## get data from a table
usa_customers <- dbGetQuery(con,"SELECT 
           firstname,
           lastname,
           country,
           email
           FROM customers
           WHERE country = 'USA'")

# write table into a database
branches <- data.frame(
    branch_id = 1:3,
    branch_name = c("BKK","LON","TOK")
)

dbWriteTable(con,"branches",branches)

dbGetQuery(con,"Select branch_name from branches")

# remove table
dbRemoveTable(con,"branches")

## disconnect 
dbDisconnect(con) # now we can't query data


## read file into R 
# read cvs: comma (,)
df1 <- read_csv("https://raw.githubusercontent.com/toyeiei/data-traninig/refs/heads/main/student_01.csv")

# read cvs : semi colon (;)
df2 <- read_csv2("https://raw.githubusercontent.com/toyeiei/data-traninig/refs/heads/main/student_02.csv")

# read txt files
df3 <- read_delim("https://raw.githubusercontent.com/toyeiei/data-traninig/refs/heads/main/student_03.txt", delim = "|")

# read tsv files (tab)
df4 <- read_tsv("https://raw.githubusercontent.com/toyeiei/data-traninig/refs/heads/main/student_04.tsv")

# read excel files (read sheet 1)
df5 <- read_xlsx("student_05.xlsx", sheet = 1)

# read json files into R

my_profile <- fromJSON("my_profile2.json")
df <- fromJSON("df2012.json")

## data transformation 101
library(dplyr)

# delete rownames and create model by rownames 

colnames(mtcars)
car_names <- rownames(mtcars)
mtcars$model <- car_names

rownames(mtcars) <- NULL

# select columns

select(mtcars, hp, wt, am)

select(mtcars , 1:5, 10)

select(mtcars, contains("a"))

## data transformation pipeline

mtcars |>
  select(model, hp, wt, am) |>
  filter(hp >= 200 & wt < 5 & am == 1)


mtcars %>%
  select(model, hp, wt, am) %>%
  filter(hp >= 200 & wt < 5 & am == 1)

mtcars %>%
  select(model, hp, wt, am) %>%
  filter(hp >= 200 | hp <= 90)


mtcars %>%
  select(model, hp, wt, am) %>%
  filter(between(hp,100,180) )

mtcars %>% 
  select(model, hp, wt, am) %>%
  filter(grepl("^M.+",model)) %>%
  arrange(desc(hp)) 

m_cars <- mtcars %>% 
            select(model, hp, wt, am) %>%
            filter(grepl("^M.+",model)) %>%
            arrange(am , desc(hp))

## mutate and summarise

hp_df <- mtcars %>% 
  filter(hp < 100) %>%
  select( model, am, hp) %>%
  mutate(am_label = ifelse(am == 0,"Auto","Manual"),
         hp_scale = hp/ 100,
         hp_double = hp*2)

## summarise
mtcars %>% 
  filter(wt<= 5) %>%
  summarise(mean_hp = mean(hp),
            sum_hp = sum(hp),
            meadian_hp = median(hp),
            sd_hp = sd(hp),
            n = n())



## data transformation pipeline
data %>%
  select() %>%
  filter() %>%
  arrange() %>%
  mutate() %>%
  summarise() %>%
  ...
  
## how to reset data frame
data('mtcars') # back to original













