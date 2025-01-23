#####################
### Basic Math
2+2
2-2
2/2
2*2

#####################
### Running Code
# Run each line by either:
# (1) setting the cursor at the end of the line and hitting control+enter on a PC or cmd+enter on Mac or click in the run button in the menu bar above or
# (2) selecting the line(s) of code you want to execute and then using the keyboard short cut or clicking run

#####################
### Commenting Code
# You can use pound signs/hashtags to tell R to ignore lines of code
# Cmd-Shift-C will add or remove a hashtag to selected lines of code

#2-2
2+2

#####################
### Errors
# If you tell R to do something it doesn't understand, it will throw an error. R is very picky about punctuation, case, spelling etc.
# these commands will not do anything
2234r*S&F(SD&F234)
c(c))

#####################
### Hanging R
# If you run a partial command, R will "hang"
# To get out of the hang, click into the console section and hit the "ESC" button
2+2+

#####################
### Logical Operators
# R can also do logical tests using logical operators.

# Is equal?
2==2
2==3

# Is not equal?
2!=2
2!=3

# Greater than and less than
2>1
2<1

# Greater than or equal to, less than or equal to
3>=1
3<=1

#####################
## Strings

# R can work with character strings
"apple"

# It is ok to use spaces in character strings.
"an apple"

# You can use logical operators to see whether character strings exactly match each other

"apple"=="apple"
"apple"=="appla"
"apple"=="banana"
"apple"!="banana"

# If you try to use inequalities with characters, R will compare how long the character string is

"apple" < "apples"
"apple">"apples"


#####################
## Objects

# You can store values and commands in objects
# these are named variables that exist in your R environment for the duration of your session
# you do this by using the assignment symbol, a less than sign followed by a dash.
# there is a handy keyboard shortcut for this: option and "-"

# save a value to an object
age <- 21
state <- "New Jersey"

# save the output of a command to an object
a <- 2+2
my_a <- 2+2
my.a <- 2+2

# Don't do this. It won't work.
# You can't start objects with a number and you can't use spaces
9a <- 2+2
my object <- 2+2

# See what is in the object by "running" the object
age
state
a

#####################
## Vectors

# you can save series of numbers or strings and put them into vectors using the combine function, c().
numbers <- c(1,2,3)
numbers
fruits <- c("apple","banana")
fruits
numbers2 <- c(4:6)
numbers2

true_false <- c(TRUE,FALSE,TRUE)
true_false

# You can combine vectors together
numbers3 <- c(7:9)
all_numbers <- c(numbers,numbers2,numbers3)
all_numbers


# You can select certain elements of a vector
x <- c(-1,10,11,12,13,14,15,16,17,18,19)

## By position in the vector
x[4]        # The fourth element.
x[-4]       # All but the fourth.
x[2:4]      # Elements two to four.
x[-(2:4)]   # All elements except two to four.
x[c(1, 5)]  # Elements one and five.

## By Value
x[x == 10]              # Elements which are equal to 10.
x[x < 0]                # all elements less than zero.
x[x %in% c(10, 12, 15)] # Elements in the set 2, 4, 7.

#####################
## Classes

# When you save different kinds of data, that data is given a "class" that describes what kind of data are in the vector
class(numbers)
class(fruits)
class(true_false)

# If you combine numbers and character vectors together, the numbers will convert to characters
fruits_numbers <- c(numbers,fruits)
fruits_numbers

# Generally for data visualization purposes, it is good to not mix characters and numbers in the same vector.
# You can change the class of a vector using as.logical,as.numeric,as.character, and as.factor

# here's an example with 1s and 0s
my_vector <- c(1,0,1,0)

my_vector_character <- as.character(my_vector)
my_vector_character
class(my_vector_character)

my_vector_logical <- as.logical(my_vector)
my_vector_logical
class(my_vector_logical)

my_vector_factor<-as.factor(my_vector)
my_vector_factor
class(my_vector_factor)

my_vector_numeric_again <- as.numeric(my_vector_character)
my_vector_numeric_again
class(my_vector_numeric_again)

#####################
## Functions

add <- function(x,y){
  x+y
}

add(2,3)

# The last expression is returned
add_and_multiply_version1 <- function(x,y){
  x+y
  x*y
}

add_and_multiply_version1(2,3)

# you can force R to return a specific object
add_and_multiply_version2 <- function(x,y){
  total <- x+y
  product <- x*y
  total_and_product <- c(total,product)

  subtract<- x-y

  return(total_and_product)
}

add_and_multiply_version2(2,3)


## R has many basic mathematical functions already built in that can be applied to numbers and vectors of numbers
# add two or more numbers
sum(c(2,3,5))

# add all the numbers in two vectors
sum(c(1,2),c(4,5))

# this does the same thing, just saving the vector to an object
my_vector <- c(1,2,3,4,5)
sum(my_vector)

# There are many other functions for doing basic math and descriptive statistics
max(my_vector)
min(my_vector)
median(my_vector)
mean(my_vector)
sd(my_vector)       # standard deviation
summary(my_vector)  # a five number summary

# Other functions will sort vectors or tell you information about the vector
my_vector<-c(2,2,1,3,5)
sort(my_vector)   # sort the elements
rev(my_vector)    # reverse the order of the elements
table(my_vector)  # create a table of the elements
unique(my_vector) # show just the unique elements
length(my_vector) # what is the length of the vector

# hit tab after 3 characters and RStudio will give you suggestions
log

# create data fast
seq(1,5)
seq(1,9,by=2)

rep("a",5)
rep(10,5)

#####################
## Importing Data in R

# Using GUI Import Dataset
# Environment tab > Import Dataset

# Import CSV
cces_sample <- read.csv("~/Dropbox/Teaching/PPOL 6802/cces_sample.csv")

# Using TAB autocomplete
cces_sample <- read.csv()

# Write CSV
write.csv(cces_sample,"~/Dropbox/Teaching/PPOL 6802/test.csv")

# type in your directory path in setwd() or use the Session-->Set Working Directory menu options
getwd()
setwd("~/Dropbox/Teaching/PPOL 6802/")

# Don't need the whole file path now
cces_sample <- read.csv("cces_sample.csv")

# the data you've read in is now a special class called a data frame
class(cces_sample)

## creating dataframes
variable1 <- c(1,2,3,4,5)
variable2 <- c(6,7,8,9,10)

data.frame(variable1,variable2)

my_dat <- data.frame("height"=variable1,"weight"=variable2)

my_dat

#####################
## Manipulating Data Frames

# get a single column of a dataframe
my_dat$weight

# use a column in a function
mean(my_dat$weight)

# save a column to another object
my_weights <- my_dat$weight
my_weights

## selecting data from dataframes
# remember you specify row, then column in the brackets
my_dat[1,]      # first row, all columns
my_dat[,1]      # first column, all rows
my_dat[1,1]     # first column, first row,
my_dat[1:3,1]   # first column, first three rows


## creating new columns
# single value repeated
my_dat$variable3 <- 100
my_dat

# add vector with same length
my_dat$variable4 <- c("apple","orange","grape","cherry","melon")
my_dat

# this won't work because the vector is too short - needs to be same length as other vectors/columns in the dataframe
my_dat$variable5 <- c("banana","mango")


## get information about a dataframe
dim(my_dat)   # dimensions of dataframe (rows and columns)
str(my_dat)   # the structure of the data frame (sort of a summary)
nrow(my_dat)  # number of rows
ncol(my_dat)  # number of columns
names(my_dat) # get dataframe column names
head(my_dat)  # see the first rows
tail(my_dat)  # see the last rows
View(my_dat)  # spreadsheet view

## Missing data
# Missing data can cause lots of problems. Some functions "break" and throw errors if you include missing data
with_missing <- c(1,2,3,NA)
sum(with_missing)

# You should look at the documentation for a function to understand how it handles missing data.
# Sometimes you can use an argument with a function to tell it how to deal with the missing data, often telling the function to ignore the missing cells.
?sum

sum(with_missing, na.rm=TRUE)

## combining dataframes

# adding a column
my_dat2 <- data.frame("variable4"=400:499,"variable5"=500:599)
all_dat<- cbind(my_dat,my_dat2)
head(all_dat)

# adding a row
new_row <- c(1000,2000,3000,4000, 5000, 6000)
all_dat_plus_new_row <- rbind(all_dat,new_row)
tail(all_dat_plus_new_row)

# combining two dataframes with rbind
# you have to make sure the two dataframes have the same column names and order
# this won't work
my_dat <- data.frame("variable1"=1:100,"variable2"=200:299)
my_dat2 <- data.frame("variable4"=400:499,"variable5"=500:599)
rbind(my_dat,my_dat2)

# this will work
my_dat <- data.frame("variable1"=1:100,"variable2"=200:299)
my_dat2 <- data.frame("variable1"=400:499,"variable2"=500:599)
rbind(my_dat,my_dat2)
