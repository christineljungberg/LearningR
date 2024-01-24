# Loading packages --------------------------------------------------------

library(tidyverse)
library(NHANES)

glimpse(NHANES)
str(NHANES)

# Select specific columns -------------------------------------------------

select(NHANES, Age, Weight, BMI)
select(NHANES, -HeadCirc)
select(NHANES, starts_with("BP"))
select(NHANES, ends_with("Day"))
select(NHANES, contains("age"))


# Renaming ----------------------------------------------------------------


nhanes_small <- rename_with(NHANES, snakecase::to_snake_case)


# Renaming specific columns -----------------------------------------------

nhanes_small <- rename(NHANES_small, sex = gender)


# Chaining the functions with the pipe ------------------------------------

colnames(nhanes_small)
nhanes_small %>%
  colnames()

nhanes_small %>%
  select(phys_active) %>%
  rename(physically_active = phys_active)


# Exercise 7.8 ------------------------------------------------------------


nhanes_small %>%
  select(bp_sys_ave, education)

nhanes_small %>%
  rename(
    bp_sys = bp_sys_ave,
    bp_dia = bp_dia_ave
  )

nhanes_small %>%
  select(bmi, contains("age"))


blood_pressure <- nhanes_small %>%
  select(starts_with("bp_")) %>%
  rename(bp_systolic = bp_sys_ave)


# Filtering data by row ---------------------------------------------------

filter(nhanes_small, phys_active=="No")
nhanes_small %>%
    filter(phys_active=="No")

nhanes_small %>%
    filter(phys_active!="No")

nhanes_small %>%
    filter(bmi==25)

nhanes_small %>%
    filter(bmi>=25)

T&T
T&F
F&F
T|T
T|F
F|F

nhanes_small %>%
    filter(bmi==25 & phys_active=="No") %>%
    select(bmi, phys_active)

nhanes_small %>%
    filter(bmi==25 | phys_active=="No") %>%
    select(bmi, phys_active)


# Arranging the rows ------------------------------------------------------

nhanes_small %>%
    arrange(age)


nhanes_small %>%
    arrange(education) %>%
    select(education)

nhanes_small %>%
    arrange(desc(age))%>%
    select(age)

nhanes_small %>%
    arrange(age, education)

# Transform or add columns ------------------------------------------------

nhanes_small %>%
    mutate(age=age*12)

nhanes_small %>%
    mutate(age=age*12,
           logged_bmi=log(bmi))%>%
    select(age, logged_bmi)

nhanes_small%>%
    mutate(old=ifelse(age>=30, "Yes", "No"))%>%
    select(old)

# Exercise 7.12 -----------------------------------------------------------

# 1. BMI between 20 and 40 with diabetes
nhanes_small %>%
    # Format should follow: variable >= number or character
    filter(bmi >= 20 & bmi <= 40 & diabetes == "Yes")

# Pipe the data into mutate function and:
nhanes_modified <- nhanes_small %>% # Specifying dataset
    mutate(
        # 2. Calculate mean arterial pressure
        mean_aterial_bloodpresure = ((2*bp_dia_ave)+bp_sys_ave)/3,
        # 3. Create young_child variable using a condition
        young_child = if_else(age<6, "Yes", "No")
    )

nhanes_modified
