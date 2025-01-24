## data visualization + markdown
library(tidyverse)

## ggplot2
library(ggplot2)


ggplot(data = mtcars, 
       mapping = aes(x=mpg,y=hp)) +
  geom_point()

## cheat sheet ggplot2 in R

# discrete vs continuous
## discrete 
# 1,2,3,4,5 or "M","F" or "high","med","low"
## continuous (measurement)
# 176.523334... => 176


gpa <- c(3.42,3.24,3.5,2,89)

# discrete, factor, categorical data

# character
gender <- c(rep("M",10),rep("F",8))

# factor
gender_factor <- factor(gender,
                        levels = c("M","F"),
                        labels = c("M","F"))

animals <- c("cat","dog","hippo","cat")

animals <- factor(animals)

## ordinal data
## temperature: low < medium < high
## spending: low < med < high

spending <- c("low","high","med","med","high")
#ordinal data
factor(spending,
       levels = c("low","med","high"),
       labels = c("low","med","high"),
       ordered = TRUE)

# factor => 1. nominal data and 2. ordinal data

## one variable - continuous

ggplot(mtcars, aes(mpg)) + 
  geom_histogram(bins = 6)

base <- ggplot(mtcars, aes(mpg))

base + geom_density()
base + geom_histogram(bins = 6, fill = "gold",color = "black")
base + geom_area(stat = "bin")

## one variable = discrete/ categorical  ## this one use only bar charts

mtcars %>%
  select(hp,wt,am) %>%
  mutate(am = ifelse(am==0,"Auto","Manual")) %>%
  ggplot(aes(am)) +
  geom_bar()

mtcars %>%
  select(hp,wt,am) %>%
  mutate(am = ifelse(am==0,"Auto","Manual")) %>%
  count(am)


## two variable - both continuous

base <- ggplot(data = mtcars,
               mapping = aes(hp,mpg))

base + 
  geom_point() + 
  geom_smooth(method = "lm") +
  geom_rug()

## setting vs mapping
#setting
base +
  geom_point(
    col = "red",
    size = 5,
    alpha =0.8, #opacity
    shape = "x"
  )
# mapping
base +
  geom_point(
    mapping = aes(col=factor(am))
  )


base +
  geom_point(aes(col=wt))

## explore data with chart
set.seed(42)
small_df <- diamonds %>%
  sample_frac(0.1) %>%
  filter (cut %in% c("Fair","Premium","Ideal"))

ggplot (small_df, aes(carat,price)) +
  geom_point(alpha = 0.3, col = "blue") +
  theme_minimal()

base2 <- ggplot(small_df,aes(carat,price,col=cut)) +
  geom_point(size = 3, alpha = 0.3) + 
  theme_minimal()

## facet == sub-plot

base2 +
  facet_wrap(~cut, ncol=2)

base2 +
  facet_wrap(~color)

base2 +
  facet_grid(color ~ cut)


ggplot (small_df, aes(carat,price)) +
  geom_point(size = 3, alpha = 0.2) +
  geom_smooth(se = FALSE, col = "red") +
  theme_minimal() + 
  facet_grid(color ~ cut)


## clear outlier
base3 <- ggplot (small_df %>% filter(carat <2.5), 
                 aes(carat,price)) +
  geom_point(size = 3, alpha = 0.2) +
  geom_smooth(se = FALSE, col = "red") +
  theme_minimal() 

## set title, caption, x/y labels
base3 +
  labs(title = "Correlation is very strong",
       subtitle = "Correlation is 0.85",
       caption = "Source : ggplot package",
       x = "Diamonds caret",
       y = "Price $ USD")

## change color manual

df <- data.frame(id = 1:5,
                 fruits = c(rep("orange",3), rep("banana",2)),
                 price = c(20,25,21,24,34),
                 weight = c(5,4,7,6,10)
)


ggplot(df,aes(weight,price, col = fruits)) +
  geom_point(size = 3) + 
  scale_color_manual(values = c("gold","blue")) +
  theme_minimal()




ggplot(df,aes(weight,price, col = price)) +
  geom_point(size = 3) + 
  theme_minimal() +
  scale_color_gradient(low = "gold",high="red")


## final tips - multiple dataframe in one chart

df1 <- df %>% filter(weight < 7)
df2 <- df %>% filter(weight >= 7)

ggplot() +
  theme_minimal() +
  geom_point(data = df1,
             mapping = aes(weight,price),
             color= "salmon", size = 3) +
  geom_point(data = df2, 
             mapping = aes(weight,price),
             color = "blue",size= 3)











