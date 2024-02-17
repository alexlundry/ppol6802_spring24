# values, objects, functions
1
state <- "Florida"
"2023-06-30"

x <- 22/7

x

x <- c(22/7, "dog", 3)

round(x, digits = 3)

# is this a number?
is.numeric(1)
is.numeric("1")
is.numeric("one")
is.numeric(x)
is.numeric(3.14)

# which of these will work?
one <- 1

# log(1)
# log("1”)
# log("one")
# log(one)


# libraries
install.packages("tidyverse") # you do this once per computer
library("tidyverse") # you do this once per R session

# hit tab after 3 characters and RStudio will give you suggestions
log

# This is how you comment code.
# Anything on the same line as a hashtag will not be run.
# 22 / 7
# round(x, digits = 3)


# compute a GPA
library(tidyverse)
gpa2 <- (4 + 3.3 + 3.5 + 2) / 4


# tidyverse demo
install.packages("nycflights13")

delays <- nycflights13::flights %>%
  select(year:day, ends_with("delay"), distance, air_time, origin, dest) %>%
  mutate(speed = distance / air_time * 60,
         dc_airport = ifelse(dest %in% c("DCA", "IAD", "BWI"), 1, 0)) %>%
  group_by(dest) %>%
  summarize(count = n(),
            dist = mean(distance, na.rm = T),
            delay = mean(arr_delay, na.rm = T)) %>%
  filter(count > 20,
         dest != "HNL")


# how to filter
library(gapminder)
View(gapminder)

gapminder %>%
  filter(year == 2007) %>%
  ggplot(aes(x = lifeExp, y = pop)) + # notice that I didn't have to declare the data here, because it is being piped in
  geom_point()

# tidyverse challenge
nycflights13::flights %>%
  select(year:day, contains("arr"), distance, air_time, origin, dest) %>%
  mutate(distance_km = distance * 1.609344,
         shuttle = ifelse(dest == "DCA" &
                            origin %in% c("JFK", "LGA"), TRUE, FALSE)) %>%
  filter(shuttle == TRUE) %>%
  group_by(origin) %>%
  summarize(avg_arr_delay = mean(arr_delay, na.rm = T))


# tidyverse challenge 2
airquality %>%
  mutate(wind_km = Wind * 1.609344) %>%
  group_by(Month) %>%
  summarize(avg_wind_km = mean(wind_km, na.rm = T)) %>%
  arrange(desc(avg_wind_km))
