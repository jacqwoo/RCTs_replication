///////////////
// 1.0 SETUP //
////////////////

	// 1.1 DIRECTORIES
					
			clear
			clear matrix 
			clear mata
		//	set maxvar 8000 **STATA IC has maxvar of 2,047, so hoping for the best!
			set more off  
			
		// SET PERSONAL DIRECTORY
		
			gl NUSAF "\\sipaxafsc\users\jzw2108\Documents\Experiments\Replication"
		 
		// SET OUTPUT DIRECTORY
			cd "$NUSAF/Output"	
	
			
		// OPEN DATASET
			use "$NUSAF/yop_analysis"
	
		
		// SET SURVEY DESIGN **svyset declares survey design
			svyset [pw=w_sampling_e], strata(district) psu(group_endline)	//strata sets the strata, psu sets primrarily sampling unit
	
	// 1.2 SET ANALYSIS GLOBALS 
		
		// BASELINE CONTROLS
				
			gl districts "D_1-D_13"
			gl ctrl_indiv "age age_2 age_3 urban ind_found_b risk_aversion"
			gl H "education literate voc_training numeracy_numcorrect_m adl"
			gl K "wealthindex savings_6mo_p99 cash4w_p99 loan_100k loan_1mil" //capital
			gl K2 "wealthindex2 lsavings cash4w_ln loan_100k loan_1mil"  //nonlinear capital
			gl E "lowskill7da_zero lowbus7da_zero skilledtrade7da_zero highskill7da_zero acto7da_zero aghours7da_zero chores7da_zero zero_hours nonag_dummy emplvoc inschool"
			gl G "admin_cost_us groupsize_est_e grantsize_pp_US_est3 group_existed group_age ingroup_hetero ingroup_dynamic grp_leader grp_chair avgdisteduc"
		
			
			gl R "mosquitonet_resc wakalonenight_resc q123_resc q126_resc q127_resc q129_resc q131_resc q132_resc"

			gl controls "$ctrl_indiv $H $K $E $G $districts" //all above except K2
	 	
			gl S "family_caring family_disputes social_support_all prosocial groups_in hrs_bizz_advice"
			gl I "jumpy q157 q162 quarrelsome unloved q166 dishonest takethings disobeyparents curse threaten disputes"
			gl W "violence_by violence_against violence_others violence_witnessed"
			gl P_e "pptemptresist_time_e ppmedwait_time_e pptakewarnings_time_e ppstopdoing_time_e pppostponeact_time_e ppspendmoney_time_e ppactquickly_time_e ppregretpast_time_e pptaskfirst_time_e ppchoosemed_time_e pptimepref1_e pptimepref2_e pptimepref3_e pptimepref4_e pptimepref5_e pptimepref6_e ppmakespend_e ppmakekeep_e pppatient_e ppatientcomp_e"
			gl P_m "pptemptresist_time_e_m ppmedwait_time_e_m pptakewarnings_time_e_m ppstopdoing_time_e_m pppostponeact_time_e_m ppspendmoney_time_e_m ppactquickly_time_e_m ppregretpast_time_e_m pptaskfirst_time_e_m ppchoosemed_time_e_m"
			gl P_m2 "pptemptresist_time_e_m ppmedwait_time_e_m pptakewarnings_time_e_m ppstopdoing_time_e_m pppostponeact_time_e_m ppspendmoney_time_e_m ppactquickly_time_e_m ppregretpast_time_e_m pptaskfirst_time_e_m ppchoosemed_time_e_m pptimepref1_e_m pptimepref2_e_m pptimepref3_e_m pptimepref4_e_m pptimepref5_e_m pptimepref6_e_m ppmakespend_e_m ppmakekeep_e_m pppatient_e_m ppatientcomp_e_m"
		 
		// OUTCOMES
		
			gl outcomes_transfer "ngogovtransfer nonyop_transfers_real_p99 anytransferlikely"
			gl outcomes_invest "voc_training training_hours bizasset_val_real_p99"
			gl outcomes_work "totalhrs7da_zero aghours7da_zero nonaghours7da_zero chores7da_zero lowskill7da_zero lowbus7da_zero skilledtrade7da_zero highskill7da_zero acto7da_zero zero_hours nonag_dummy trade_dummy"
			gl outcomes_income "profits4w_real_p99 wealthindex consumption_real_p99_z wealthladder"
			gl outcomes_migrate "migrate urban capital"
			gl outcomes_formalize "bizlog bizregister biztaxes employees employs"
			gl outcomes_other "return_school savings_real_p99 net_hhtransfers_p99 wages adjusted_profits2 fulltimeskill"
			gl table_social "social_int_n community_n contrpubgood_e2_n aggression_n aggression_e2_n protest_e2_n"
			gl table_social_other "groups_capped support_e1_n distress__n grit female_empower wife_abuse_attitude wife_abuse_actual" 

		// SOCIAL GLOBALS
		
			gl personality_e2 "grit conscientious industriousness"
			gl social_int "hhcaring_resc fam_disp_resc live_together helpelders_resc"
			gl support_e1 "lookedafterfam_resc distressed_resc mindoff_resc futureplans_resc helpfuladvice_resc listener_resc taughtsomething_resc jokedwith_resc"
			gl aggression "agg_quarrelsome agg_take agg_curse agg_threaten neigh_disp commlead_disp pol_disp fight_disp"
			gl aggression_e2 "quarrelsome_resc takethings_resc curse_resc threaten_resc wbyelled_resc wbreactedanger_resc wbfrustrateang_resc wbdamagemad_resc wbnowantang_resc wbangrythreat_resc wbhittinggood_resc wbhitdefend_resc wbdamagefun_resc wbforcewant_resc wbforcemoney_resc wbgangothers_resc wbweaponfight_resc wbyelledtodo_resc neigh_disp commlead_disp pol_disp fight_disp"
			gl community_e1 "comm_meet comm_mblzr comm_leader madespeech"
			gl community_e2 "cclcommeet12m_resc comm_mblzr ldmcomlc1 ldmcomother ldmacceptc1 rcaraiseissue12m_dum"
			gl contrpubgood_e2 "cpgroad12m_dum cpgwater12m_dum cpgbldgoth12m_dum cpgschl12m_dum cpglatrine12m_dum cpgoth12m_dum cpgfuneral12m_dum"
			gl protest_e2 "protests attptreasonjustified_resc attptviolencejustified_resc attptpolvioljustified_resc hcaptwish hcaptwouldgo hcaptwouldgoviol"
			gl election_action_e2 "epavoteredu2011el_dum epadiscussvote2011el_dum epareportinc2011el_dum regsuccess2011 vote2011elprez vote2011ellcv"
			gl partisan_e2 "pparally2011el_resc ppaprimary2011el_resc partyworked_resc partymember_resc "
			gl distress_ "jumpy_ unloved_ worried_ restless_ thinkpast_ nightmares_ lifediff_"
		
			
	// 1.3 DEFINE PROGRAMS FOR OUTREG COMMAND
	** The following three programs format the regression tables for easy use, as well as adding additional relevant statistics to the bottom of each table. 
	** The programs are used below to output some of the tables in order to simplify the code.


		// PROGRAM 1: ITT ESTIMATION AND OUTPUT
			* FULL SAMPLE POOLED (MALE AND FEMALE, E1 & E2)
			* ESTIMATES ATE BY GENDER AND ENDLINE
		 
			cap program drop ITT
				program def ITT
			 				
				local lab : var label ${Y}_e	
	
					* Control Mean E1 All 
						sum ${Y}_e [iw=w_sampling_e] if e1==1 & assigned==0
						scalar ${Y}e1c = r(mean)
						scalar ${Y}e1N = r(N)
					
					* Control Mean E1 Female
						sum ${Y}_e [iw=w_sampling_e] if e1==1 & assigned==0 & female==1
						scalar ${Y}e1cf = r(mean)
					
					* Control Mean E1 Male
						sum ${Y}_e [iw=w_sampling_e] if e1==1 & assigned==0 & female==0
						scalar ${Y}e1cm = r(mean)
					
					* E1 ITT, all
						if ${Y}e1N != 0 { 
							svy: reg ${Y}_e female $X assigned if e1==1
							outreg2 using $table.xls, excel aster(se) bdec(3) br label ctitle(`lab') nocons drop(female $X) addstat(Control Mean, ${Y}e1c, Male Control Mean, ${Y}e1cm, Female Control Mean, ${Y}e1cf)
						}
							
					* E1 ITT, by gender
						if ${Y}e1N != 0 { 
							svy: reg ${Y}_e female ${X} assigned female_assigned if e1==1
						}
												
						 lincom assigned+female_assigned
							scalar Ysumcoeff_e1 = r(estimate)
							scalar Ysumpval_e1 = 2*ttail(e(df_r),abs(r(estimate)/r(se)))
							local Ysumse_e1 = r(se)
							local Ysumser_e1 = round(`Ysumse_e1', .001)
							local pstar_e1
							if Ysumpval_e1<=0.01 { 
								local pstar_e1 "*" 
							}
						 	if Ysumpval_e1<=0.05 { 
								local pstar_e1 "`pstar_e1'*" 
		 					}
							if Ysumpval_e1<=0.1 { 
								local pstar_e1 "`pstar_e1'*" 
							}
							local Ysumsestar_e1 "[`Ysumser_e1']`pstar_e1'" 
						
							
						if ${Y}e1N != 0 { 
							outreg2 using $table.xls, excel aster(se) bdec(3) br label ctitle(`lab') nocons drop(female $X) addstat(Female TE coeff, Ysumcoeff_e1, Female TE Pval, Ysumpval_e1, Female TE Std Error ,`Ysumse_e1' ) addtext (Female TE Std Error Star , "`Ysumsestar_e1'")
						}					
										
					* Control Mean E2 All 
						sum ${Y}_e [iw=w_sampling_e] if e2==1 & assigned==0
						scalar ${Y}e2c = r(mean)
						scalar ${Y}e2N = r(N)
					
					* Control Mean E2 Female
						sum ${Y}_e [iw=w_sampling_e] if e2==1 & assigned==0 & female==1
						scalar ${Y}e2cf = r(mean)
					
					* Control Mean E2 Male
						sum ${Y}_e [iw=w_sampling_e] if e2==1 & assigned==0 & female==0
						scalar ${Y}e2cm = r(mean)
														
					* E2 ITT, all
						if ${Y}e2N != 0 { 
							svy: reg ${Y}_e female ${X} assigned if e2==1
							outreg2 using $table.xls, excel aster(se) bdec(3) br label ctitle(`lab') nocons drop(female $X) addstat(Control Mean, ${Y}e2c, Male Control Mean, ${Y}e2cm, Female Control Mean, ${Y}e2cf)
						}
							 
					* E2 ITT, by gender
						if ${Y}e2N != 0 { 
							svy: reg ${Y}_e female ${X} assigned female_assigned if e2==1
						}
												
						 lincom assigned+female_assigned
							scalar Ysumcoeff_e2 = r(estimate)
							scalar Ysumpval_e2 = 2*ttail(e(df_r),abs(r(estimate)/r(se)))
							local Ysumse_e2 = r(se)
							local Ysumser_e2 = round(`Ysumse_e2', .001)
							local pstar_e2
							if Ysumpval_e2<=0.01 { 
								local pstar_e2 "*" 
							}
						 	if Ysumpval_e2<=0.05 { 
								local pstar_e2 "`pstar_e2'*" 
		 					}
							if Ysumpval_e2<=0.1 { 
								local pstar_e2 "`pstar_e2'*" 
							}
							local Ysumsestar_e2 "[`Ysumser_e2']`pstar_e2'" 
						
							
						if ${Y}e2N != 0 { 
							outreg2 using $table.xls, excel aster(se) bdec(3) br label ctitle(`lab') nocons drop(female ${X}) addstat(Female TE coeff, Ysumcoeff_e2, Female TE Pval, Ysumpval_e2, Female TE Std Error ,`Ysumse_e2' ) addtext (Female TE Std Error Star , "`Ysumsestar_e2'")
						}					
					
				end
 



// Table 9 Replication: Heterogenous Treatment Effects, Biz assets and cash earnings (full sample)
		foreach y in bizasset_val_real_p99 profits4w_real_p99 { 
		
			* Label of dependant variables
				local lab : var label `y'_e 
				

				reg `y'_e assigned e2 assigned_e2 female female_e2 $ctrl_indiv $E $G A_emplvoc S_K A_S_K S_H A_S_H S_P_m A_S_P_m $districts [pw=w_sampling_e], cluster(partid)		
				}

// Table 7 Replication: Sensitivity Analysis of Intent-to-Treat Estimates to Alternate Models and Missing Data Scenarios
					// ALTERNATE MODELS
							
							gl table tableA8
								cap erase $table.xls
								cap erase $table.txt
								
							foreach y in voc_training training_hours bizasset_val_real_p99 consumption_real_p99_z wealthladder aghours7da_zero nonaghours7da_zero {
								
								local lab: var label `y'_e
								
								foreach n in 1 2 {
										
									// 1 Main specification
										cap qui svy: reg `y'_e female $controls assigned if e`n'==1
											cap outreg2 using $table.xls, excel aster(se) bdec(3) br label ctitle(`lab') nocons drop(female $controls) 
							
									// 2 No control vector other than strata FE	
										cap qui svy: reg `y'_e $districts assigned if e`n'==1
											cap outreg2 using $table.xls, excel aster(se) bdec(3) br label ctitle(`lab') nocons drop($districts) 
									
									// 3 Diff-in-diff with controls
										cap qui svy: reg `y'_diff_e female $ctrl_indiv $H $G lsavings loan_100k loan_1mil aghours7da_zero chores7da_zero zero_hours nonag_dummy inschool assigned if e`n'==1
											cap outreg2 using $table.xls, excel aster(se) bdec(3) br label ctitle(`lab') nocons drop(female $ctrl_indiv $H $G lsavings loan_100k loan_1mil aghours7da_zero chores7da_zero zero_hours nonag_dummy trade_dummy inschool) 
							
									// 4 TOT with controls
										cap qui svy: ivregress 2sls `y'_e $controls (treated=assigned) if e`n'==1
											cap outreg2 using $table.xls, excel aster(se) bdec(3) br label ctitle(`lab') nocons drop(female $controls) 

								}
								}
											
							// BOUNDING EXERCISE FOR AVERAGE TREATMENT EFFECTS

								gl table tableA8b_e1
									cap erase $table.xml
									cap erase $table.txt
									
								gl title "Mean standarized treatment effects under varying missing data assumptions"
							
								gl bounding "voc_training_e training_hours_e bizasset_val_real_p99_e wealthladder_e aghours7da_zero_e nonaghours7da_zero_e"
							
							foreach x in e1 {
							
								foreach g in bounding {
									capture matrix drop `g'
						
										foreach var in $`g' {
										
											capture matrix drop `var'
										
											// 1. +/1 0.1 SD 
												gen `var'l10_`x' = `var'
												
													sum `var' if assigned==0 & `var'!=. & `x'==1, d
														replace `var'l10_`x' = r(mean) + 0.1*r(sd) if ind_unfound_`x'==1 & assigned==0 & `x'==1
												
													sum `var' if assigned==1 &`var'!=. & `x'==1, d
														replace `var'l10_`x' = r(mean) - 0.1*r(sd) if ind_unfound_`x'==1 & assigned==1 & `x'==1			
											
											// 2. +/- .25 SD 
												gen `var'l25_`x' = `var'
												
													sum `var' if assigned==0 & `var'!=. & `x'==1, d
														replace `var'l25_`x' = r(mean) + 0.25*r(sd) if ind_unfound_`x'==1 & assigned==0 & `x'==1
												
													sum `var' if assigned==1 &`var'!=. & `x'==1, d
														replace `var'l25_`x' = r(mean) - 0.25*r(sd) if ind_unfound_`x'==1 & assigned==1 & `x'==1

											// 3. +/- 0.5 SD
												gen `var'l5_`x' = `var'
												
													sum `var' if assigned==0 & `var'!=. & `x'==1, d
														replace `var'l5_`x' = r(mean) + 0.5*r(sd) if ind_unfound_`x'==1 & assigned==0 & `x'==1
												
													sum `var' if assigned==1 &`var'!=. & `x'==1, d
														replace `var'l5_`x' = r(mean) - 0.5*r(sd) if ind_unfound_`x'==1 & assigned==1 & `x'==1
																							
											// 4. +/- 1.0 SD
												gen `var'l1_`x'= `var'
												
													sum `var' if assigned==0 &`var'!=. & `x'==1, d
														replace `var'l1_`x' = r(mean) + r(sd) if ind_unfound_`x'==1 & assigned==0 & `x'==1
												
													sum `var' if assigned==1 & `var'!=. & `x'==1, d
														replace `var'l1_`x' = r(mean) - r(sd) if ind_unfound_`x'==1 & assigned==1 & `x'==1
											
											// 5. Lower Manski Bound
												gen `var'lmm_`x' = 	`var'
												
													sum `var' if assigned==0 &`var'!=. & `x'==1, d
														replace `var'lmm_`x' = r(max) if ind_unfound_`x'==1 & assigned==0 &`x'==1
												
													sum `var' if assigned==1 &`var'!=. & `x'==1, d
														replace `var'lmm_`x' = r(min) if ind_unfound_`x'==1 & assigned==1 &`x'==1
										
											foreach z in l10 l25 l5 l1 lmm { 
												
												sum `var'`z'_`x' [iw=w_sampling_e] if assigned==0 & `x'==1
													local `var'`z'mean = r(mean)
													display ``var'`z'mean'
												
												qui svy: reg `var'`z'_`x' female $controls assigned if `x'==1
													
													local obs`z' = e(N)
														display `obs`z''
														
													local treated`z'coeff = _b[assigned]
														display `treated`z'coeff'
														
													local treated`z'perc = _b[assigned]/``var'`z'mean'
														display `treated`z'perc'	
														
													local treated`z'se = _se[assigned]
														display `treated`z'se'
												
													qui testparm assigned
													local treated`z'pstat = r(p)
														
												matrix mat`var's = (`treated`z'coeff' \ `treated`z'se' \ `treated`z'perc'\ `treated`z'pstat' \ `obs`z'')
													matrix list mat`var's
												
												matrix `var' = nullmat(`var'), mat`var's
													matrix list `var'
													
												cap drop `var'`z'
											}
										
										// Big matrix
											matrix `g' = (nullmat(`g') \ `var')
												matrix list `g'
												
											local lbl : variable label `var'
											local rname `" `rname' "`lbl'" "'
											local rname `" `rname' "se" "% Change" "pstat" "Obs" "'
											display `rname'		
						
									
										}	
										
									// Set colum names
										local cnames `" "Lower 0.1 SD" "Lower 0.25 SD" "Lower 0.5 SD" "Lower 1 SD" "Lower Manski" "'	
												
									// Save table	
										xml_tab `g', save("$table.xml") cnames(`cnames') rnames(`rname') replace
								}
						}	
						
						// BOUNDING EXERCISE FOR AVERAGE TREATMENT EFFECTS

													gl table tableA8b_e2
														cap erase $table.xml
														cap erase $table.txt
														
													gl title "Mean standarized treatment effects under varying missing data assumptions"
												
													gl bounding "bizasset_val_real_p99_e consumption_real_p99_z_e wealthladder_e aghours7da_zero_e nonaghours7da_zero_e"
												
												foreach x in e2 {
												
													foreach g in bounding {
														capture matrix drop `g'
											
															foreach var in $`g' {
															
																capture matrix drop `var'
															
																// 1. +/1 0.1 SD 
																	gen `var'l10_`x' = `var'
																	
																		sum `var' if assigned==0 & `var'!=. & `x'==1, d
																			replace `var'l10_`x' = r(mean) + 0.1*r(sd) if ind_unfound_`x'==1 & assigned==0 & `x'==1
																	
																		sum `var' if assigned==1 &`var'!=. & `x'==1, d
																			replace `var'l10_`x' = r(mean) - 0.1*r(sd) if ind_unfound_`x'==1 & assigned==1 & `x'==1			
																
																// 2. +/- .25 SD 
																	gen `var'l25_`x' = `var'
																	
																		sum `var' if assigned==0 & `var'!=. & `x'==1, d
																			replace `var'l25_`x' = r(mean) + 0.25*r(sd) if ind_unfound_`x'==1 & assigned==0 & `x'==1
																	
																		sum `var' if assigned==1 &`var'!=. & `x'==1, d
																			replace `var'l25_`x' = r(mean) - 0.25*r(sd) if ind_unfound_`x'==1 & assigned==1 & `x'==1

																// 3. +/- 0.5 SD
																	gen `var'l5_`x' = `var'
																	
																		sum `var' if assigned==0 & `var'!=. & `x'==1, d
																			replace `var'l5_`x' = r(mean) + 0.5*r(sd) if ind_unfound_`x'==1 & assigned==0 & `x'==1
																	
																		sum `var' if assigned==1 &`var'!=. & `x'==1, d
																			replace `var'l5_`x' = r(mean) - 0.5*r(sd) if ind_unfound_`x'==1 & assigned==1 & `x'==1
																												
																// 4. +/- 1.0 SD
																	gen `var'l1_`x'= `var'
																	
																		sum `var' if assigned==0 &`var'!=. & `x'==1, d
																			replace `var'l1_`x' = r(mean) + r(sd) if ind_unfound_`x'==1 & assigned==0 & `x'==1
																	
																		sum `var' if assigned==1 & `var'!=. & `x'==1, d
																			replace `var'l1_`x' = r(mean) - r(sd) if ind_unfound_`x'==1 & assigned==1 & `x'==1
																
																// 5. Lower Manski Bound
																	gen `var'lmm_`x' = 	`var'
																	
																		sum `var' if assigned==0 &`var'!=. & `x'==1, d
																			replace `var'lmm_`x' = r(max) if ind_unfound_`x'==1 & assigned==0 &`x'==1
																	
																		sum `var' if assigned==1 &`var'!=. & `x'==1, d
																			replace `var'lmm_`x' = r(min) if ind_unfound_`x'==1 & assigned==1 &`x'==1
															
																foreach z in l10 l25 l5 l1 lmm { 
																	
																	sum `var'`z'_`x' [iw=w_sampling_e] if assigned==0 & `x'==1
																		local `var'`z'mean = r(mean)
																		display ``var'`z'mean'
																	
																	qui svy: reg `var'`z'_`x' female $controls assigned if `x'==1
																		
																		local obs`z' = e(N)
																			display `obs`z''
																			
																		local treated`z'coeff = _b[assigned]
																			display `treated`z'coeff'
																			
																		local treated`z'perc = _b[assigned]/``var'`z'mean'
																			display `treated`z'perc'	
																			
																		local treated`z'se = _se[assigned]
																			display `treated`z'se'
																	
																		qui testparm assigned
																		local treated`z'pstat = r(p)
																			
																	matrix mat`var's = (`treated`z'coeff' \ `treated`z'se' \ `treated`z'perc'\ `treated`z'pstat' \ `obs`z'')
																		matrix list mat`var's
																	
																	matrix `var' = nullmat(`var'), mat`var's
																		matrix list `var'
																		
																	cap drop `var'`z'
																}
															
															// Big matrix
																matrix `g' = (nullmat(`g') \ `var')
																	matrix list `g'
																	
																local lbl : variable label `var'
																local rname `" `rname' "`lbl'" "'
																local rname `" `rname' "se" "% Change" "pstat" "Obs" "'
																display `rname'		
											
														
															}	
															
														// Set colum names
															local cnames `" "Lower 0.1 SD" "Lower 0.25 SD" "Lower 0.5 SD" "Lower 1 SD" "Lower Manski" "'	
																	
														// Save table	
															xml_tab `g', save("$table.xml") cnames(`cnames') rnames(`rname') replace
													}
											}	 
	
	// Table 7 Extension: alternate models excluding double-sampling
// 1 Main specification (ITT with controls)
// 2 No control vector other than strata FE	(ITT without controls)
// 3 Diff-in-diff with controls
// 4 TOT with controls
gen skilledtrade7da_zero_diff_e=skilledtrade7da_zero_e-skilledtrade7da_zero

gen profits4w_real_p99_diff_e=profits4w_real_p99_e-profits4w_real_p99

gen wealthindex_diff_e=wealthindex_e-wealthindex

**had to take out lsavings because it wasn't available in the dataset

foreach y in skilledtrade7da_zero profits4w_real_p99 wealthindex {
			
			local lab: var label `y'_e
			
			foreach n in 1 2 {
					
					reg `y'_e assigned female $controls if e`n'==1 & w_sampling_e==1
					
					reg `y'_e assigned $districts if e`n'==1 & w_sampling_e==1
					
					reg `y'_diff_e assigned female $ctrl_indiv $H $G loan_100k loan_1mil aghours7da_zero chores7da_zero zero_hours nonag_dummy inschool if e`n'==1 & w_sampling_e==1
					
					ivregress 2sls `y'_e $controls (treated=assigned) if e`n'==1 & w_sampling_e==1
					
			}
			}

			//for bizassets only
					foreach n in 1 2 {
					
					reg bizasset_val_real_p99_e assigned female $controls if e`n'==1 & w_sampling_e==1
					
					reg bizasset_val_real_p99_e assigned $districts if e`n'==1 & w_sampling_e==1
									
					ivregress 2sls bizasset_val_real_p99_e $controls (treated=assigned) if e`n'==1 & w_sampling_e==1
					
			}
