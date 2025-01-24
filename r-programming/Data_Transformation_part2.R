library(tidyverse)


df <- mtcars %>% 
        rownames_to_column(var = "model") %>%
        tibble()

# ramdom sample
set.seed(42) # lock result sampling
df %>% 
  sample_n(3)

df %>% 
  sample_frac(0.2) # sample_frac = probably percent 
  

df %>% 
  select(model,am) %>%
  mutate(am = ifelse(am == 0, "auto","manual")) %>%
  count(am) %>%
  mutate( percent = n/sum(n) )

model_names <- df %>% 
  select(model,am) %>%
  mutate(am = ifelse(am == 0, "auto","manual")) %>%
  distinct(model) %>%
  pull() # pull() extract to vector

model_names[1:10]
model_names[grepl("Maz.+",model_names)]


## join table
# inner,left,right,full

band_members %>%
  inner_join(band_instruments, by = "name")

band_members %>%
  left_join(band_instruments, by = "name")

band_members %>%
  right_join(band_instruments, by = "name")

band_members %>%
  full_join(band_instruments, by = "name")

# drop NA

band_members %>%
  full_join(band_instruments, by = "name") %>%
  drop_na()

# replace na
band_members %>%
  full_join(band_instruments, by = "name") %>%
  mutate(plays = replace_na(plays,"drum"),
         band = replace_na(band,"Aerosmith"))
  

# union data (like SQL)
df1 <- data.frame(id = 1:3,
                  name = c("toy","john","mary"))
df2 <- data.frame(id = 3:5,
                  name = c("mary","joe","david"))

df3 <- data.frame(id = 6:8,
                  name = c("a","b","c"))
df4 <- data.frame(id = 9:10,
           name = c("e","d"))

## when we have multiple dataframes
list_df <- list(df1,df2,df3,df4)

list_df %>%
  bind_rows() %>%
  distinct()

# bind rows and then remove duplicates
df1 %>%
  bind_rows(df2) %>%
  distinct()

# join table when key name is not the same
band_members %>%
  rename(friend = name) %>%
  left_join(band_instruments, by = c("friend" = "name"))


# basic data vizualization

library(tidyverse)

qplot(mpg,data = mtcars, geom = "histogram", bins = 10)

qplot(mpg,data = mtcars, geom = "density")

qplot(x = hp, y = mpg, data = mtcars, geom = "point")





















