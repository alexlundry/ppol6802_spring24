
#####################
### Libraries
# you must first install packages from the internet onto your machine
# you only need to do this once per computer
# install.packages("tidyverse") # you do this once per computer
# install.packages("gapminder") # you do this once per computer

# but then you must load the library in each R session that you intend to use it
library(tidyverse) # you do this once per R session
library(gapminder) # you do this once per R session

#####################
### Reading in Data
# Use read_csv instead of read.csv
# make sure you have the file in your working directory, or use the complete file path. Use setwd() if you need to.
setwd("~/Dropbox/Teaching/PPOL 6802/")
cces <- read_csv("cces_sample.csv")

class(cces)         # read_csv produces a tibble rather than a dataframe.
vignette("tibble")  # tibbles are a tidyverse friendly version of dataframe

# if you need to switch back and forth between tibble and dataframe for some reason
cces_dataframe <- as.data.frame(cces)
cces_tibble <- as_tibble(cces_dataframe)

# quick overview of a tibble
glimpse(cces)

#####################
### Filtering
# create a dataset of only female respondents
women <- filter(cces, gender == 2)

# remember the other logical operators
# >
# <
# <=
# >=
# &
# |
# %in%

republican_women <- filter(cces, gender == 2 & pid7 > 4)

#####################
### Selecting Variables
small_cces <- select(republican_women, "educ", "employ")

#####################
### Combine Multiple Commands Using Piping
# x %>% f(y) is the same as f(x, y)
# y %>% f(x, ., z) is the same as f(x, y, z)

# keyboard shortcut to make the pipe is CMD-SHIFT-m (for PCs use control)
# the command below is the same as the previous two commands we ran
small_cces <- cces %>%
  filter(gender == 2 & pid7 > 4) %>%
  select("educ","employ")

#####################
### Rename Variables
cces <- cces %>%
  rename(trump_approval2=CC18_310a)

#####################
### Mutate Variables
recoded_cces <- cces %>%
  mutate(female = ifelse(gender == 2, "Female", "Male"),  # simple if/else logic
         pid7_alt = recode(pid7, `1`="Strong Democrat",  # recode command
                       `2`="Weak Democrat",
                       `3`="Lean Democrat",
                       `4`="Independent",
                       `5`="Lean Republican",
                       `6`="Weak Republican",
                       `7`="Strong Republican"),
         pid3 = case_when(pid7 <= 3 ~ "Democrat",
                          pid7 == 4 ~ "Independent",
                          pid7 >= 5 ~ "Republican"))

#####################
### Simple Frequency Tables
count(recoded_cces, pid7_alt)                 # simple frequency
count(recoded_cces, pid7_alt, sort = T)         # you can sort by number of cases
count(recoded_cces, pid7_alt, wt = wt_var, sort = T)  # you can also count using a weight variable
count(recoded_cces, pid3, pid7_alt)         # you can put multiple vars for a crosstab

#####################
##### Summarize the data
cces %>%
  summarize(mean_pid7 = mean(pid7),
            mean_faminc = mean(faminc_new))

#####################
### Grouping Data
grouped_gender_pid7 <- cces %>% group_by(gender,pid7)
grouped_gender_pid7

###remove grouping with ungroup
ungroup(grouped_gender_pid7)

###when you summarize grouped data, you get summaries by group
grouped_gender <- cces %>% group_by(gender)

grouped_gender %>%
  summarize(mean_pid7 = mean(pid7),
            mean_faminc = mean(faminc_new))

# you can also just combine both these using the pipe
cces %>%
  group_by(gender) %>%
  summarise(mean_pid7 = mean(pid7),
            mean_faminc = mean(faminc_new))


#####################
##### Reorder rows by column values
grouped_gender %>%
  summarise(mean_pid7 = mean(pid7),
            mean_faminc = mean(faminc_new)) %>%
  arrange(desc(mean_pid7))


#####################
## Stringr
## part of the tidyverse

####create an example string
my_strings <- c(
  "123apple",
  " 456apple",
  "358orange   "
)

#### logical test for whether a string contains a pattern
str_detect(my_strings, "orange")

#### indicate which string in a vector of strings contains a value
str_which(my_strings, "apple")
str_which(my_strings, "3")

#### count the number of matches in a string
str_count(my_strings, "p")

#### indicate the positions of a pattern in a string
str_locate(my_strings, "apple")

#### extract a substring from a character vector
str_sub(my_strings, start=4, end=6)

#### return the strings in a vector of strings that contain a pattern
str_subset(my_strings, "apple")

#### return a specified pattern from all strings in a vector containing the pattern
str_extract(my_strings, "apple")

#### return the length of strings
str_length(my_strings)

#### add blank character spaces up to given number
str_pad(my_strings, 12, side="right")

#### remove blank space in a vector from the left and/or right sides
my_strings <- str_trim(my_strings, "both")
my_strings

#### substitute a range of characters in a strings with new values
str_sub(my_strings, 1, 3) <- "___"
my_strings

#### replace one pattern in strings with another pattern
###see also str_replace_all
str_replace(my_strings, "apple", "grape")

#### change case of letters in strings
#see also str_to_lower and str_to_title
str_to_upper(my_strings)

#### joining strings across columns
my_strings1<-c(
  "app", "gra"
)
my_strings2<-c(
  "le", "pe"
)

joining_strings <- tibble(my_strings1, my_strings2)
joining_strings

str_c(joining_strings$my_strings1, joining_strings$my_strings2)

#### joining strings down rows
my_strings<-c(
  "app","le"
)
my_strings

str_c(my_strings,collapse="")

#### split a string at a given pattern match
my_strings<-c(
  "appleX123X456",
  "orangeX456",
  "tomatoX789")
my_strings

#  create a list with the split substrings
str_split(my_strings, "X")

# create a matrix of substrings
str_split_fixed(my_strings, "X", 2)

#### be careful with regular expressions
my_strings<-c(
  "apple.123",
  "orange.456",
  "tomato.789")

str_split(my_strings, "\\.")


#####################
## Lubridate

# Lubridate is a library that makes it easier to work with dates and times.

# Turn strings that have unformatted date/time data into date/time objects
# Identify the order in which the year, month, and day appears in your dates.
# Now arrange “y”, “m”, and “d” in the same order. This is the name of the
# function in lubridate that will parse your dates.
ymd("20110604")
mdy("06-04-2011")
dmy("04/06/2011")

arrive <- ymd_hms("2011-06-04 12:00:00", tz = "Pacific/Auckland")
arrive
leave <- ymd_hms("2011-08-10 14:00:00", tz = "Pacific/Auckland")
leave

# Extract information from date times with the functions second, minute, hour,
# day, wday, yday, week, month, year, and tz.
hour(arrive)
month(arrive)
wday(arrive)
wday(arrive, label = TRUE)

# You can do math on date/time data to create an interval
leave - arrive


#####################
## Forcats

#### Forcats
# A factor is a categorical variable in which the factors have some kind of relationship with each other.

# Imagine a dataset that looks like this:
groups<-rep(c("GroupA", "GroupB", "GroupC"), 2)
time<-c(1,1,1,2,2,2)
relative_score<-c("High", "Medium", "Low", "Low", "High", "Medium")
exact_score<-c(93,87,72,71,98,83)

dat <- tibble(groups,time, relative_score, exact_score)
dat

# Exact Score is a numeric variable; you can perform mathematical operations on it
# But Relative Score is a categorical variable, describing three different conditions.
# Those conditions have an order to them, in which one category can be higher or lower than the other.
# "High" is greater than "Low", but you cannot perform any mathematical operations on them.
# Right now, "relative_score" is a character vector, so in the dataset there is no inherent order to the values.

# In order to give the variable an inherent order, we turn it into a special kind of variable - a factor
dat$relative_score <- factor(dat$relative_score)

# To determine the "levels" of the factor or their values relative to each other, let's just call up that column.
dat$relative_score

# The output shows that there are now "levels" to the factor, which indicate their relative values.
# However, right now, those factors are in the wrong order (it defaulted to alphabetical order). We need to "relevel" the factor.
dat <- dat %>%
  mutate(relative_score = fct_relevel(relative_score, "Low", "Medium", "High"))

dat$relative_score

# There are lots of quick functions for changing the order of the factors like this. See the cheat sheet for more examples.
# However, one of the most useful is fct_reorder, which allows you to reorder a factor based on the levels' relationship with another variable.

# Consider this example:
groups <- c("c","d","e","b","a")
values <- c(5,2,3,4,1)

dat <- tibble(groups,values)
dat

dat %>%
  ggplot(aes(x=groups,y=values))+
  geom_bar(stat="identity")

# By default, ggplot is organizing the bars alphabetically, but you might want to sort the bars in the ascending or descending value.
# The easiest way to do is the reorder the groups variable as a factor.

# relevel groups ascending by values
dat <- dat %>%
  mutate(groups = fct_reorder(groups, values))

dat %>%
  ggplot(aes(x=groups,y=values))+
  geom_bar(stat="identity")

# or by descending if you prefer
dat <- dat %>%
  mutate(groups = fct_reorder(groups, desc(values)))

dat %>%
  ggplot(aes(x=groups,y=values))+
  geom_bar(stat="identity")


#####################
#### Pivots and Joins

# A data table can be either "wide" or long" - typically the tidyverse prefers using "long" data.
# To switch between long and wide, you want to use pivot functions

# Example of "wide" data
units <- c("a","b","c")
time1 <- c(1,2,3)
time2 <- c(4,5,6)
time3 <- c(7,8,9)

wide_dat <- tibble(units, time1, time2, time3)
wide_dat

# Example of the same data, but "tall"
units <- c(rep("a", 3), rep("b", 3), rep("c", 3))
time <- c(rep(c("time1", "time2", "time3"), 3))
score <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)

tall_dat <- tibble(units, time, score)
tall_dat

# wide_dat has one case per row, but there are three observations per row, not as tidy as we would prefer. We want one row for each observation.
# tall_dat has one case per row, and one row for each observation.

# Fortunately, there is a function in the tidyverse that let's you easily pivot data
# from wide to tall, or tall to wide, depending upon what you need in the moment.

# pivot_longer to go from wide to long
dat_long <- pivot_longer(
  data = wide_dat, # identify the data
  cols = c(time1, time2, time3), # select the columns we want to stretch
  names_to = "time", # name a new column that will be home to the pivoted column titles (this will have time1, time2, and time3 in it),
  values_to = "score" # name a new column that will be home to the pivoted row values. This will be the sequences of numbers
)

dat_long

# pivot_wider to go from long to wide
pivot_wider(
  dat_long,
  names_from=time,
  values_from=score
)

#####################
#### Joining multiple data sets together.
# You are going to have to do this frequently, both in this class AND in real life.

# Let's imagine we have data on these four cities in one spreadsheet, which when we import it looks like this:
cities <- c("New York","London","Canberra","Nairobi")
var1 <- c(runif(4,0,1))

dat_part1 <- tibble(cities, var1)

dat_part1

# We find another spreadsheet with data on cities, and it looks like this:
cities <- c("New York","London","Canberra","Jakarta")
var2 <- c(runif(4,0,1))

dat_part2 <- tibble(cities, var2)
dat_part2

# Joins work based on key values in your data. A key value is an identifier for an observation.
# There is a column with the same title in both datasets, "cities". That is the key.
# We have several basic options for how to merge these datasets together

# Left Join: keep all of the rows the FIRST table in the function, matching data in the SECOND table as possible
left_join(dat_part1, dat_part2, by="cities")
# Here, there is missing data for Nairobi, because there is no Nairobi key value in the second table

# Right Join: keep all of the rows in the SECOND table in the function, matching data in the FIRST table as possible
right_join(dat_part1, dat_part2, by="cities")
# Here, we have Jakarta instead of Nairobi, the flip of the the left_join

# Inner Join: keep only those rows where the key value is in BOTH tables
inner_join(dat_part1, dat_part2, by="cities")

# Full join: keep ALL of the rows in the two tables.
full_join(dat_part1, dat_part2, by="cities")

# Joining data is complex and can be tricky
# For more details, you'll want to read Chapter 13 of R for Data Science.
# Also, see the below website for a great visual guide to the different kinds of joins.
# https://www.garrickadenbuie.com/project/tidyexplain/