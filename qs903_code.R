# 0. clear all objects from workspace
rm(list=ls())

library(arm)

# 1. Downloading Data

if (!file.exists("processed.cleveland.data")) {
  download.file(url = "http://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.cleveland.data", destfile = "processed.cleveland.data")
}
require(tools)

md5sum("processed.cleveland.data")


# 2. Loading Data
heart.data <- read.csv("processed.cleveland.data", header = FALSE)


# 3. Explore data

nrow(heart.data) # number of rows should be 303
ncol(heart.data) # number of columns should be 14

head(heart.data) # show first 6 rows

# 4. Add Column names based on the description file in the documentation i.e. the heart-disease.names file found here https://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/

names(heart.data) <- c("age", "sex", "chest_pain_type", "resting_blood_pressure", "cholesterol", "fasting_blood_sugar", "rest_ecg", "max_heart_rate_achieved", "exercise_induced_angina", "st_depression", "st_slope", "num_major_vessels", "thalassemia", "disease")


# 5. Removing missing values - it seems that 'ca' and 'thal' columns have '?' in them. We need to replace these '?' with NA's

str(heart.data)

heart.data$num_major_vessels[heart.data$num_major_vessels == "?"] <- NA
heart.data$thalassemia[heart.data$thalassemia == "?"] <- NA

summary(heart.data) # checking to see if that worked


# 6. Next we need to convert categorical varibales such as sex into factors

heart.data$sex <- factor(heart.data$sex)
levels(heart.data$sex) <- c("female", "male")
heart.data$chest_pain_type <- factor(heart.data$chest_pain_type)
levels(heart.data$chest_pain_type) <- c("typical","atypical","non-anginal","asymptomatic")
heart.data$fasting_blood_sugar <- factor(heart.data$fasting_blood_sugar)
levels(heart.data$fasting_blood_sugar) <- c("false", "true")
heart.data$rest_ecg <- factor(heart.data$rest_ecg)
levels(heart.data$rest_ecg) <- c("normal","stt","hypertrophy")
heart.data$exercise_induced_angina <- factor(heart.data$exercise_induced_angina)
levels(heart.data$exercise_induced_angina) <- c("no","yes")
heart.data$st_slope <- factor(heart.data$st_slope)
levels(heart.data$st_slope) <- c("upsloping","flat","downsloping")
heart.data$num_major_vessels <- factor(heart.data$num_major_vessels) # not doing level conversion because its not necessary
heart.data$thalassemia <- factor(heart.data$thalassemia)
levels(heart.data$thalassemia) <- c("normal","fixed","reversable")
heart.data$disease <- factor(heart.data$disease) # not doing level conversion because its not necessary


str(heart.data) # check to see if that worked

# 7. convert depedent variable from degrees of heart disease to binary outcome i.e. 0 for no heart disease and 1 for heart disease

heart.data$disease <- ifelse((heart.data$disease != 0),1,0)

table(heart.data$disease) # looks like we have a good split of heart disease vs no heart disease in our data


# 8. Create a new dataset without missing values 
heart.data <- na.omit(heart.data)

nrow(heart.data) # final dataset consists of 297 rows
ncol(heart.data) # final dataset consists of 14 columns



##############################################################
#             Fitting models    #

# 9. Fitting and summarsing model_1 with high risk factors

model_1 <- glm(heart.data$disease ~ heart.data$age + heart.data$sex + heart.data$cholesterol + heart.data$resting_blood_pressure, data=heart.data, family=binomial(link="logit"))


summary(model_1) 



# 10. interpreting the effect of a one year increase in age from the mean age of 55 on the probability of being diagnosed with heart disease
invlogit(cbind(1, mean(heart.data$age)+1,1,mean(heart.data$cholesterol),mean(heart.data$resting_blood_pressure))%*%coef(model_1)) - invlogit(cbind(1, mean(heart.data$age),1,mean(heart.data$cholesterol),mean(heart.data$resting_blood_pressure))%*%coef(model_1))

# 11. interpreting effect of sex on heart disease holding all other factors constanct
invlogit(cbind(1, mean(heart.data$age),1,mean(heart.data$cholesterol),mean(heart.data$resting_blood_pressure))%*%coef(model_1)) - invlogit(cbind(1, mean(heart.data$age),0,mean(heart.data$cholesterol),mean(heart.data$resting_blood_pressure))%*%coef(model_1))

# 12.1 plotting binned residuals for model_1
binnedplot(model_1$fitted, model_1$y-model_1$fitted,
           nclass=40)

#12.2 plotting binned residuals with respect to age variable

binnedplot(heart.data$age, model_1$y-model_1$fitted,
           nclass=40, xlab="Age")

# 12.3 plotting binned residuals with respect to cholesterol variable
binnedplot(heart.data$cholesterol, model_1$y-model_1$fitted,
           nclass=40, xlab="Cholesterol")

# 12.4 plotting binned residuals with respect to blood pressure variable
binnedplot(heart.data$resting_blood_pressure, model_1$y-model_1$fitted,
           nclass=40, xlab="Resting Blood Pressure")



# 13. Fitting and summarsing model_2 with high risk factors + remaining factors

model_2 <- glm(heart.data$disease ~ heart.data$age + heart.data$sex + heart.data$cholesterol + heart.data$resting_blood_pressure + heart.data$chest_pain_type + heart.data$fasting_blood_sugar + heart.data$rest_ecg + heart.data$max_heart_rate_achieved + heart.data$exercise_induced_angina + heart.data$st_depression + heart.data$st_slope + heart.data$num_major_vessels + heart.data$thalassemia, data=heart.data, family=binomial(link="logit"))


summary(model_2) 


# 14 plotting binned residuals for model_2
binnedplot(model_2$fitted, model_2$y-model_2$fitted,
           nclass=40)


