# Logistic-Regression-for-Predicting-Heart-Disease


## Goal:
Early and accurate detection of heart disease is essential to saving lives. This project applies logistic regression to the [Cleveland Heart Disease Dataset](https://archive.ics.uci.edu/ml/datasets/heart+Disease) in order to examine predictors of heart disease. 

This data set contains the following features:

- age Age in years
- sex Female or male (1 = male; 0 = female)
- chest_pain_type Chest pain type (1 = typical angina, 2 =atypical angina, 3 = non-angina,  4 =asymptomatic angina)
- resting_blood_pressure Resting blood pressure (mm Hg)
- cholesterol Serum cholesterol (mg/dl)
- fasting_blood_sugar Fasting blood sugar (< 120 mg/dl or > 120 mg/dl) (1 = true; 0 = false)
- rest_ecg Resting electrocardiography results (0 = normal, 1 = ST-T wave abnormality, 2= left ventricular hypertrophy)
- max_heart_rate_achieved Max. heart rate achieved during thalium stress test
- exercise_induced_angina Exercise induced angina (yes or no) (1 = yes; 0 = no)
- st_depression ST depression induced by exercise relative to rest
- st_slope Slope of peak exercise ST segment (1 = upsloping, 2 = flat, 3 = downsloping)
- num_major_vessels Number of major vessels (0-3) colored by fluoroscopy
- thalassemia Thalium stress test result (3=normal, 6 = fixed defect, or 7 = reversible defect)


## Result:

The final model found these variables to be statistically significant at the 0.05 level:
- sex (with males being more at risk than females)
- resting blood pressure (higher = more risk)
- chest pain type (those with asymptomatic angina more at risk than those with typical angina)
- ST segments (with flat sloping having higher risk than those with upward sloping ST segments)
- number of major blood vessels
- and those with a hereditary blood disorder known as reversible defect thalassemia having a greater likelihood of heart disease diagnosis than those without it.

Perhaps the most surprising result from this analyses was cholesterol not being a significant predictor. In terms of limitation, the sample size of the dataset was very small with only 297 cases, making it difficult for the model to be generalised to wider populations. Furthermore, the lack of key attributes such as smoking, physical activity and diabetes missing from the dataset likely reduced the strength of the model.

