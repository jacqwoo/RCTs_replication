rm(list=ls())       # clear objects in memory
library(ri)         # load the RI package
set.seed(022288)   # random number seed, so that results are reproducible
library(haven)
library(estimatr)
library(dplyr)
library(car)
library(broom)    #exporting regression results to csv

setwd("C:/Users/jacqw/Documents/Columbia/Spring 2019/POS 4768 Experiments/Replication Study/Blattman et al 2014")
yop <- read_dta("yop_analysis.dta") ##this seems to get all the data in without the factor issue of foreign

attach(yop)

##This replicates Table 9, bizassets (full sample)
# Model with interaction effects
fit_int <- lm_robust(bizasset_val_real_p99_e~.,data=subset(yop,select=c(bizasset_val_real_p99_e, assigned, e2, assigned_e2, female, female_e2, age, age_2, age_3, urban, ind_found_b, risk_aversion,
                                                                    lowskill7da_zero, lowbus7da_zero, skilledtrade7da_zero, highskill7da_zero, acto7da_zero, aghours7da_zero, chores7da_zero, zero_hours, nonag_dummy, emplvoc, inschool,
                                                                    admin_cost_us, groupsize_est_e, grantsize_pp_US_est3, group_existed, group_age, ingroup_hetero, ingroup_dynamic, grp_leader, grp_chair, avgdisteduc,
                                                                    D_1, D_2, D_3, D_4, D_5, D_6, D_7, D_8, D_9, D_10, D_11, D_12, D_13,
                                                                    A_emplvoc, S_K, A_S_K, S_H, A_S_H, S_P_m, A_S_P_m)),
                 weights=w_sampling_e,clusters=partid)
summary(fit_int)
tidy_fit_int <- tidy(fit_int)
write.csv(tidy_fit_int,"tidy_fit_int.csv")

fit_int_cash <- lm_robust(profits4w_real_p99_e~.,data=subset(yop,select=c(profits4w_real_p99_e, assigned, e2, assigned_e2, female, female_e2, age, age_2, age_3, urban, ind_found_b, risk_aversion,
                                                                        lowskill7da_zero, lowbus7da_zero, skilledtrade7da_zero, highskill7da_zero, acto7da_zero, aghours7da_zero, chores7da_zero, zero_hours, nonag_dummy, emplvoc, inschool,
                                                                        admin_cost_us, groupsize_est_e, grantsize_pp_US_est3, group_existed, group_age, ingroup_hetero, ingroup_dynamic, grp_leader, grp_chair, avgdisteduc,
                                                                        D_1, D_2, D_3, D_4, D_5, D_6, D_7, D_8, D_9, D_10, D_11, D_12, D_13,
                                                                        A_emplvoc, S_K, A_S_K, S_H, A_S_H, S_P_m, A_S_P_m)),
                     weights=w_sampling_e,clusters=partid)
summary(fit_int_cash)
tidy_fit_int_cash <- tidy(fit_int_cash)
write.csv(tidy_fit_int_cash,"tidy_fit_cash.csv")

##Create null and alt models, non-robust (since F-stat calc is non-robust--under assumption of homoscedasticity)
# Null Model
lm2_b <- lm(bizasset_val_real_p99_e~.,data=subset(yop,select=c(bizasset_val_real_p99_e, assigned, e2, female, age, age_2, age_3, urban, ind_found_b, risk_aversion,
                                                                         lowskill7da_zero, lowbus7da_zero, skilledtrade7da_zero, highskill7da_zero, acto7da_zero, aghours7da_zero, chores7da_zero, zero_hours, nonag_dummy, emplvoc, inschool,
                                                                         admin_cost_us, groupsize_est_e, grantsize_pp_US_est3, group_existed, group_age, ingroup_hetero, ingroup_dynamic, grp_leader, grp_chair, avgdisteduc,
                                                                         D_1, D_2, D_3, D_4, D_5, D_6, D_7, D_8, D_9, D_10, D_11, D_12, D_13,
                                                                         S_K, S_H, S_P_m)),
                      weights=w_sampling_e)
summary(lm2_b)
tidy_lm2 <- tidy(lm2_b)
write.csv(tidy_lm2,"tidy_lm2_b_null.csv")

estate_b <- summary(lm2_b)$coefficients[2]

lm2_c <- lm(profits4w_real_p99_e~.,data=subset(yop,select=c(profits4w_real_p99_e, assigned, e2, female, age, age_2, age_3, urban, ind_found_b, risk_aversion,
                                                               lowskill7da_zero, lowbus7da_zero, skilledtrade7da_zero, highskill7da_zero, acto7da_zero, aghours7da_zero, chores7da_zero, zero_hours, nonag_dummy, emplvoc, inschool,
                                                               admin_cost_us, groupsize_est_e, grantsize_pp_US_est3, group_existed, group_age, ingroup_hetero, ingroup_dynamic, grp_leader, grp_chair, avgdisteduc,
                                                               D_1, D_2, D_3, D_4, D_5, D_6, D_7, D_8, D_9, D_10, D_11, D_12, D_13,
                                                               S_K, S_H, S_P_m)),
            weights=w_sampling_e)
summary(lm2_c)
tidy_lm2_c <- tidy(lm2_c)
write.csv(tidy_lm2_c,"tidy_lm2_c_null.csv")

estate_c <- summary(lm2_c)$coefficients[2]

# Alt model
lm1_b <- lm(bizasset_val_real_p99_e~.,data=subset(yop,select=c(bizasset_val_real_p99_e, assigned, e2, assigned_e2, female, female_e2, age, age_2, age_3, urban, ind_found_b, risk_aversion,
                                                                        lowskill7da_zero, lowbus7da_zero, skilledtrade7da_zero, highskill7da_zero, acto7da_zero, aghours7da_zero, chores7da_zero, zero_hours, nonag_dummy, emplvoc, inschool,
                                                                        admin_cost_us, groupsize_est_e, grantsize_pp_US_est3, group_existed, group_age, ingroup_hetero, ingroup_dynamic, grp_leader, grp_chair, avgdisteduc,
                                                                        D_1, D_2, D_3, D_4, D_5, D_6, D_7, D_8, D_9, D_10, D_11, D_12, D_13,
                                                                        A_emplvoc, S_K, A_S_K, S_H, A_S_H, S_P_m, A_S_P_m)),
                     weights=w_sampling_e)
summary(lm1_b) ##similar estimates but generally smaller SEs (non-robust), significant at the same levels
summary(lm1_b)$res
tidy_lm1_b <- tidy(lm1_b)
write.csv(tidy_lm1_b,"tidy_lm1_b_alt.csv")

lm1_c <- lm(profits4w_real_p99_e~.,data=subset(yop,select=c(profits4w_real_p99_e, assigned, e2, assigned_e2, female, female_e2, age, age_2, age_3, urban, ind_found_b, risk_aversion,
                                                               lowskill7da_zero, lowbus7da_zero, skilledtrade7da_zero, highskill7da_zero, acto7da_zero, aghours7da_zero, chores7da_zero, zero_hours, nonag_dummy, emplvoc, inschool,
                                                               admin_cost_us, groupsize_est_e, grantsize_pp_US_est3, group_existed, group_age, ingroup_hetero, ingroup_dynamic, grp_leader, grp_chair, avgdisteduc,
                                                               D_1, D_2, D_3, D_4, D_5, D_6, D_7, D_8, D_9, D_10, D_11, D_12, D_13,
                                                               A_emplvoc, S_K, A_S_K, S_H, A_S_H, S_P_m, A_S_P_m)),
            weights=w_sampling_e)
summary(lm1_c) ##similar estimates but generally smaller SEs (non-robust), significant at the same levels
tidy_lm1_c <- tidy(lm1_c)
write.csv(tidy_lm1_c,"tidy_lm1_c_alt.csv")

###do this for cash earnings as well
#Calculate F test from unrestricted(alt) and restricted(null) model (non-robust calculation)
N <- 3873 #number of obs, I think!
Ftest  <- ((sum(lm2_b$residuals^2)-sum(lm1_b$residuals^2))/6)/(sum(lm1_b$residuals^2)/(N-51))

#Testing H0: Alternative model explains variation better than null model under sharp null
numiter <- 10000   #Repeat this 100K times
Fdist <- rep(NA,numiter) #Create empty dataframe for loop
Y <- bizasset_val_real_p99_e #change this for each obs outcome
Z <- assigned
Y1 <- Y0 <- Y #Let Y1 and Y0 both take the values of observed Ys
Y0 <- Y0 - estate_b*Z  #Let Y0=observed Y - estimated ATE if treated
Y1 <- Y1 + estate_b*(1-Z) #Let Y1=observed Y + estimated ATE if untreated


for (i in 1:numiter) {
  Zri <- sample(Z)  #Random assignment
  Yri <- Y0*(1-Zri) + Y1*Zri
  Zri_e2 <- Zri*e2
  Zri_emplvoc <- Zri*emplvoc
  Zri_S_K <- Zri*S_K
  Zri_S_H <- Zri*S_H
  Zri_S_P_m <- Zri*S_P_m
  lm2ri <- lm(Yri~Zri + e2 + female + age + age_2 + age_3 + urban + ind_found_b + risk_aversion +
                lowskill7da_zero + lowbus7da_zero + skilledtrade7da_zero + highskill7da_zero + acto7da_zero + aghours7da_zero + chores7da_zero + zero_hours + nonag_dummy + emplvoc + inschool +
                admin_cost_us + groupsize_est_e + grantsize_pp_US_est3 + group_existed + group_age + ingroup_hetero + ingroup_dynamic + grp_leader + grp_chair + avgdisteduc +
                D_1 + D_2 + D_3 + D_4 + D_5 + D_6 + D_7 + D_8 + D_9 + D_10 + D_11 + D_12 + D_13 +
                S_K + S_H + S_P_m,
                weights=w_sampling_e)
  lm1ri <- lm(Yri~Zri + e2 + Zri_e2 + female + female_e2 + age + age_2 + age_3 + urban + ind_found_b + risk_aversion +
                lowskill7da_zero + lowbus7da_zero + skilledtrade7da_zero + highskill7da_zero + acto7da_zero + aghours7da_zero + chores7da_zero + zero_hours + nonag_dummy + emplvoc + inschool +
                admin_cost_us + groupsize_est_e + grantsize_pp_US_est3 + group_existed + group_age + ingroup_hetero + ingroup_dynamic + grp_leader + grp_chair + avgdisteduc +
                D_1 + D_2 + D_3 + D_4 + D_5 + D_6 + D_7 + D_8 + D_9 + D_10 + D_11 + D_12 + D_13 +
                Zri_emplvoc + S_K + Zri_S_K + S_H + Zri_S_H + S_P_m + Zri_S_P_m,
                weights=w_sampling_e)
  Fdist[i]  <- ((sum(lm2ri$residuals^2)-sum(lm1ri$residuals^2))/6)/(sum(lm1ri$residuals^2)/(N-51)) #F statistic
}

mean(Fdist >= Ftest) #calculate p-value


##Attempting to replicate inverse probability weighting
write.csv(yop,"yop.csv",row.names = F)
yop_attrition <- yop %>% filter(e1==1 & phase2_notrack_e1!=1)%>% select(ind_unfound_e1,assigned,admin_cost_us,groupsize_est_e,grantsize_pp_US_est3,group_existed,group_age,ingroup_hetero,ingroup_dynamic,avgdisteduc,age,urban,risk_aversion,grp_leader,grp_chair,
                                                                        lowskill7da_zero, lowbus7da_zero, skilledtrade7da_zero, highskill7da_zero, acto7da_zero, aghours7da_zero, chores7da_zero, zero_hours, nonag_dummy, emplvoc, inschool, 
                                                                        education, literate, voc_training, numeracy_numcorrect_m, adl,
                                                                        wealthindex, savings_6mo_p99, cash4w_p99, loan_100k, loan_1mil,
                                                                        D_1, D_2, D_3, D_4, D_5, D_6, D_7, D_8, D_9, D_10, D_11, D_12, D_13,
                                                                        w_sampling_e, group_endline)
lm_attrition <- lm_robust(ind_unfound_e1~assigned+admin_cost_us+groupsize_est_e+grantsize_pp_US_est3+group_existed+group_age+ingroup_hetero+ingroup_dynamic+avgdisteduc+age+urban+risk_aversion+grp_leader+grp_chair+
                          lowskill7da_zero+lowbus7da_zero+skilledtrade7da_zero+highskill7da_zero+acto7da_zero+aghours7da_zero+chores7da_zero+zero_hours+nonag_dummy+emplvoc+inschool+ 
                          education+literate+voc_training+numeracy_numcorrect_m+adl+
                          wealthindex+savings_6mo_p99+cash4w_p99+loan_100k+loan_1mil+
                          D_1+D_2+D_3+D_4+D_5+D_6+D_7+D_8+D_9+D_10+D_11+D_12+D_13,
                          data=yop_attrition, weights=w_sampling_e,clusters=group_endline)
summary(lm_attrition)
##create inverse of the weight
yop <- yop %>% mutate(inv_weight=1/w_sampling_e)
##regress inv_weight on found at baseline + significant characteristics predicting attrition
lm_weights_1 <- lm(inv_weight~ind_found_b+
                age+urban+risk_aversion+grp_leader+lowskill7da_zero+skilledtrade7da_zero+aghours7da_zero+zero_hours+nonag_dummy+emplvoc+inschool+literate+numeracy_numcorrect_m+adl+cash4w_p99,
                yop)
summary(lm_weights_1)
##robust regression of weights on found at baseline + significant characteristics predicting attrition
lm_weights_2 <- lm_robust(inv_weight~ind_found_b+
                     age+urban+risk_aversion+grp_leader+lowskill7da_zero+skilledtrade7da_zero+aghours7da_zero+zero_hours+nonag_dummy+emplvoc+inschool+literate+numeracy_numcorrect_m+adl+cash4w_p99,
                   yop, clusters=group_endline)
summary(lm_weights_2)
##regression of weights on found at baseline + all baseline covariates
lm_weights_3 <- lm(inv_weight~ind_found_b+assigned+admin_cost_us+groupsize_est_e+grantsize_pp_US_est3+group_existed+group_age+ingroup_hetero+ingroup_dynamic+avgdisteduc+age+urban+risk_aversion+grp_leader+grp_chair+
                     lowskill7da_zero+lowbus7da_zero+skilledtrade7da_zero+highskill7da_zero+acto7da_zero+aghours7da_zero+chores7da_zero+zero_hours+nonag_dummy+emplvoc+inschool+ 
                     education+literate+voc_training+numeracy_numcorrect_m+adl+
                     wealthindex+savings_6mo_p99+cash4w_p99+loan_100k+loan_1mil+
                     D_1+D_2+D_3+D_4+D_5+D_6+D_7+D_8+D_9+D_10+D_11+D_12+D_13,
                   yop)
summary(lm_weights_3)
##only select out double-sampling data
yop_double <- yop %>% filter(w_sampling_e != 1)
lm_weights_4 <- lm(inv_weight~ind_found_b+
                     age+urban+risk_aversion+grp_leader+lowskill7da_zero+skilledtrade7da_zero+aghours7da_zero+zero_hours+nonag_dummy+emplvoc+inschool+literate+numeracy_numcorrect_m+adl+cash4w_p99,
                   yop_double)
summary(lm_weights_4)
lm_weights_5 <- lm(inv_weight~ind_found_b+assigned+admin_cost_us+groupsize_est_e+grantsize_pp_US_est3+group_existed+group_age+ingroup_hetero+ingroup_dynamic+avgdisteduc+age+urban+risk_aversion+grp_leader+grp_chair+
                     lowskill7da_zero+lowbus7da_zero+skilledtrade7da_zero+highskill7da_zero+acto7da_zero+aghours7da_zero+chores7da_zero+zero_hours+nonag_dummy+emplvoc+inschool+ 
                     education+literate+voc_training+numeracy_numcorrect_m+adl+
                     wealthindex+savings_6mo_p99+cash4w_p99+loan_100k+loan_1mil+
                     D_1+D_2+D_3+D_4+D_5+D_6+D_7+D_8+D_9+D_10+D_11+D_12+D_13,
                   yop_double)
summary(lm_weights_5)
