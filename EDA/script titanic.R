setwd("C:/Users/Victoria/OneDrive/Escritorio/Intro a datos")
rm(list = ls())
dir()
load("titanic_train.Rdata")

##Loading the packages 

library(ggplot2)
library(dplyr)
library(ggridges)
library(car)
library(Hmisc)

##---------------------------------------------------------------------------------------------------------------------------------
##This EDA has been implemented in order to inspect the dependent variable: "Survive"; i.e., whether a passenger survived. 

str(titanic.train$Survived)
sum(titanic.train$Survived == 1)
sum(titanic.train$Survived == 0)
titanic.train$Survived <- recode(titanic.train$Survived, "0" = "No", "1" = "Yes")

##__________________________________

##Firstly, I inspected the relationship among "fare", "Class" and "survived"

str(titanic.train$Fare)

##a. To storage the fare of survivors on a variable 

aux <- which(titanic.train$Survived == 1)
aux2 <- which(titanic.train$Survived == 0)

survivorsfare <- titanic.train$Fare[aux] 
notsurvivorsfare <- titanic.train$Fare[aux2]
dim(survivorsfare)
dim(notsurvivorsfare)

##b. Graphs 

doble <- ggplot(titanic.train, aes(x = Fare, fill= Survived)) + geom_histogram(aes(y = ..density..), binwidth = 10, colour = "black") + facet_grid(.~Survived) + geom_density(lwd = 1, colour = 3,fill = 4, alpha = 0.25) 

doble + ggtitle("Fare by passenger accoding to survival outcome") + xlab("Fare (thousand)") + ylab("Density") + scale_fill_brewer(name = "Survived", labels = c("NO", "YES"), palette = "Pastel1") + theme_minimal() + coord_cartesian(xlim = c(0,250))
        
graphclassfare <- ggplot(titanic.train, aes(x = Fare, y = Pclass, fill = Survived)) + geom_density_ridges(linetype = 1, alpha = 0.5) 
                                                                                          
graphclassfare +  ggtitle("Fare by passenger class ticket accoding to survival outcome") + xlab("Fare (thousand)") + scale_fill_brewer(name = "Survived", labels = c("NO", "YES"), palette = "Pastel2") + coord_cartesian(xlim = c(0,400)) + theme_minimal()

##___________________________________


## Secondly, Families(Parch > 0) & Survived, by Sex and Age 


str(titanic.train$Parch) ## I left this as an integer to subset the data set afterwards
malewithchildren <- subset(titanic.train, Parch > 0 & Sex == "male") ##a data set with 82 observations
View(malewithchildren)
str(malewithchildren)
str(malewithchildren$Parch)
str(malewithchildren$Age)


##Graphs 

p <- ggplot(malewithchildren, aes(x = Survived, y = Age, fill = Survived))
p + geom_violin(trim = FALSE) + geom_boxplot(width = .1, fill = "black") + stat_summary(fun.data = mean_sdl, geom = "point", fill = "White", shape = 21, size = 2.5) + ggtitle("Age by survival of men or children", subtitle = "Parch > 0, n = 72") + scale_fill_brewer(name = "Survived", labels = c("NO", "YES"), palette = "Pastel1")
p + geom_violin(trim = FALSE) + geom_dotplot(binaxis = "y", stackdir='center', dotsize= 1, fill = "black") + ggtitle("Age by survival of men or children", subtitle = "Parch > 0, n = 72") + scale_fill_brewer(name = "Survived", labels = c("NO", "YES"), palette = "Pastel1")

##statistics: We refer to this table of statistics in the question 4 after the violin plots

surv <- which(malewithchildren$Survived == 1)
notsurv <- which(malewithchildren$Survived == 0)
summary(malewithchildren$Age[surv])
summary(malewithchildren$Age[notsurv])

##Subsetting the data set for repeating the previous steps with Sex == male & Parch == 0

men <- subset(titanic.train, Sex == "male" & Parch == 0)
dim(men)
m <- ggplot(men, aes(x = Survived, y = Age, fill = Survived))
m + geom_violin(trim = FALSE) + geom_boxplot(width = .1, fill = "black") + stat_summary(fun.data = mean_sdl, geom = "point", fill = "White", shape = 21, size = 2.5) + ggtitle("Age by survival of men", subtitle = "Parch == 0, n = 353") + scale_fill_brewer(name = "Survived", labels = c("NO", "YES"), palette = "Pastel1")

##Statistics

survivors <- which(men$Survived == 1)
notsurvivors <- which(men$Survived == 0)
summary(men$Age [survivors])
summary(men$Age [notsurvivors])

##________________________________________________

##Thirdly, Sibp > 0 & Survived, by Sex and splitting data by age. 

##We created a dummy variable where having spouses or siblings scored as 1 and not having scored at 0

travelingpartner <- ifelse(titanic.train$SibSp == 0, 0, 1)
titanic.train$travelingpartner <- travelingpartner
titanic.train$partner <- factor(travelingpartner)
str(titanic.train$travelingpartner)

##We have labeled the dummy variable and for better understanding the graphs 

titanic.train$travelingpartner <- recode(titanic.train$travelingpartner,"0 = 'Spouse or Siblings aboard'; 1 = 'No spouse or siblings aboard'")

##remission to this table in question 5
table(titanic.train$travelingpartner, titanic.train$Sex)
prop.table(table(titanic.train$travelingpartner, titanic.train$Sex), 1)

##Graphs for "travel partner"

titanic.train$travelingpartner <- ifelse(titanic.train$Parch + titanic.train$SibSp > 0, "With Partner", "Without Partner")
titanic.train$Survived <- as.factor(titanic.train$Survived)
titanic.train$Sex <- as.factor(titanic.train$Sex)

# First plot: Survival rate per passenger with/without traveling partner
bar <- ggplot(titanic.train, aes(x = travelingpartner, fill = Survived)) +
  geom_bar(width = 0.5, position = position_fill()) +
  ggtitle("Survival rate per passenger with/without traveling partner") +
  xlab("Traveling Partner") +
  scale_fill_brewer(palette = "Pastel2")
print(bar)

# Second plot: Survival rate per passenger by sex
bar <- ggplot(titanic.train, aes(x = travelingpartner, fill = Survived)) +
  geom_bar(width = 0.7, position = "dodge") +
  ggtitle("Survival rate per passenger with/without traveling partner by sex") +
  xlab("Traveling Partner") +
  scale_fill_brewer(palette = "Pastel2") +
  facet_wrap(~ Sex)
print(bar)


