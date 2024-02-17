# load necessary libraries
library(tidyverse)
library(scales)

# load data
d1 <- read_csv("code_demos/datasets/global_power_plant_database_v_1_3/global_power_plant_database.csv")

# filter to USA and 2019
d2 <- d1 %>%
  filter(country == "USA",
         year_of_capacity_data == 2019) %>%
  select(country:primary_fuel, commissioning_year:year_of_capacity_data, generation_gwh_2019)

# reorder primary fuel in frequency order and create fossil fuel flag
p1 <- d2 %>%
  mutate(primary_fuel = fct_infreq(primary_fuel) %>% fct_rev(),
         fossil_fuel = ifelse(primary_fuel %in% c("Coal", "Oil", "Petcoke"), TRUE, FALSE)) %>%
  count(fossil_fuel, primary_fuel)

# unlabelled bar chart
p1 %>%
  ggplot(aes(primary_fuel, n, fill = fossil_fuel)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("TRUE" = "grey", "FALSE" = "lightgreen")) +
  labs(title = "Count of US Power Plants by Fuel Type",
       x = "",
       y  = "N",
       fill = "Fossil Fuel") +
  coord_flip()

# bar chart with simple labelled bars
p1 %>%
  ggplot(aes(primary_fuel, n, fill = fossil_fuel)) +
  geom_bar(stat = "identity") +
  # adding text, simple
  geom_text(aes(label = n)) +
  #
  scale_fill_manual(values = c("TRUE" = "grey", "FALSE" = "lightgreen")) +
  labs(title = "Count of US Power Plants by Fuel Type",
       x = "",
       y  = "N",
       fill = "Fossil Fuel") +
  coord_flip()

# more complex labelled bar chart
p1 %>%
  ggplot(aes(primary_fuel, n, fill = fossil_fuel)) +
  geom_bar(stat = "identity") +
  # adding text, complex
  geom_text(aes(label = ifelse(n > 1000, comma(n), "")), hjust = 1) + # make one type of horizontal adjustment for large numbers
  geom_text(aes(label = ifelse(n <= 1000, comma(n), "")), hjust = 0.1) + # make a different horizontal adjustment for smaller numbers
  #
  scale_fill_manual(values = c("TRUE" = "grey", "FALSE" = "lightgreen")) +
  scale_y_continuous(labels = label_comma()) + # changing the Y axis label formatting
  labs(title = "Count of US Power Plants by Fuel Type",
       x = "",
       y  = "N",
       fill = "Fossil Fuel") +
  coord_flip()

# In the above code, there are two geom_text layers used to add labels to the bars,
# differentiated by the size of the value n:
#
# For large numbers (n > 1000): hjust = 1 is used, meaning the text labels for
# large numbers are right-aligned with their specified position on the bars.
# This typically places these labels at the end (right side) of the bars when
# using coord_flip(), making it clear and avoiding overlap with the bar itself
# or other labels.
#
# For smaller numbers (n < 1000): hjust = 0.1 is slightly off from a strict left
# alignment (0), nudging the labels a bit to the right from the start of the
# bars. This subtle adjustment helps in placing these smaller labels inside or
# just at the beginning of the bars, ensuring they are readable and visually
# distinct from labels for larger numbers.

###################
# What is "hjust"?
# hjust stands for horizontal justification. It controls the
# horizontal alignment of text elements relative to their specified position
# (e.g., left, center, right alignment). In ggplot2, hjust values range from 0
# to 1, where:

# 0 aligns the text to the left (or start) of the specified position.

# 0.5 centers the text on the specified position. 1 aligns the text to
# the right (or end) of the specified position.

# Values outside 0 to 1 are permissible, causing the text to align beyond
# the immediate start or end points relative to the positioning point.

###################
# What is "comma?
# The comma() function call, as used above, is part of the scales
# package in R, which provides functions for formatting axis labels and other
# text elements in plots. When you use comma() in your ggplot expressions,
# here's what it essentially does:
#
# Formats Numbers with Commas: The comma() function formats
# numeric values by adding commas as thousand separators, making large numbers
# easier to read. For example, 1000 becomes 1,000, and 1000000 becomes
# 1,000,000.
#
# Improves Readability: Especially in visualizations like bar charts,
# where exact numeric values are displayed, formatting numbers with commas helps
# viewers quickly grasp the scale and differences between values.
#
# There are similar formatting functions in the scales() library:
# dollar() currency() date() scientific()
