capture log close 
clear 
cls 
set more off

global mash "/Users/maryamfatemi/Dropbox (Graduate Center)/BRFSS/Data"
cd "$mash"

use "$mash/BRFSS_Clean_yearfixed.dta", clear

*******************************************************************************
*******************************************************************************
*******************************************************************************


****** Covariates and Outcomes Summary Statistics for Contiguous U.S.******

eststo clear

global all i.sex i._educag i._ageg5yr i._race_g hlthpln1 medcost exerany2 _rfhlth _hcvu651 _rfbmi5 _totinda bpmeds toldhi2 pdiabtst insulin diabedu _cholchk _rfchol cvdinfr4 cvdcrhd4 cvdstrk3 _drdxar1 asthma3 asthnow _rfsmok3 drnkany5 _rfdrhv4 flushot5 pneuvac3 hivtst6 hpvadvc2 shingle1 _flshot5 _pneumo2 hadmam hadpap2 psatest1 hadsigm3 chccopd chcscncr chcocncr addepev2 chckidny

eststo p1: xi: estpost summ $all if period==0 & maryland==1  // baseline
eststo p2: xi: estpost summ $all if period==0 & contig_us==1 

eststo p3: xi: estpost summ $all if period==1 & maryland==1  // MDAPM
eststo p4: xi: estpost summ $all if period==1 & contig_us==1 

eststo p5: xi: estpost summ $all if period==2 & maryland==1  // MD TCOC
eststo p6: xi: estpost summ $all if period==2 & contig_us==1 


esttab p* using "$mash/summary stats.tex", replace ///
cells("mean(fmt(3))") ///
refcat(sex "\textbf{Sex}" _educag "\textbf{Education}" _ageg5yr "\textbf{Age}" _race_g "\textbf{Race}" hlthpln1 "\textbf{Health Plan}" medcost "\textbf{Medical Cost}" exerany2 "\textbf{Physical Activity}" _rfhlth "\textbf{Good or Better Health}" _hcvu651 "\textbf{Health Insurance}" _rfbmi5 "\textbf{Obesity}" _totinda "\textbf{Physical Activity}" bpmeds "\textbf{Medicine for High Blood Pressure}" toldhi2 "\textbf{High Blood Cholesterol}" pdiabtst "\textbf{High Blood Sugar}" insulin "\textbf{Taking Insulin}" diabedu "\textbf{Diabetes Education}" _cholchk "\textbf{Cholesterol Check}" _rfchol "\textbf{High Cholesterol}" cvdinfr4 "\textbf{Heart Attack}" cvdcrhd4 "\textbf{Coronary Heart Disease}" cvdstrk3 "\textbf{Stroke}" _drdxar1 "\textbf{Arthritis}" asthma3 "\textbf{Asthma}" asthnow "\textbf{Still Asthma}" _rfsmok3 "\textbf{Current Smoker}" drnkany5 "\textbf{Any Drinks}" _rfdrhv4 "\textbf{Heavy Drinker}" flushot5 "\textbf{Flu Shot}" pneuvac3 "\textbf{Pneumonia Vaccine}" hivtst6 "\textbf{HIV Test}" hpvadvc2 "\textbf{HPV Vaccination}" shingle1 "\textbf{Shingle Vaccination}" _flshot5 "\textbf{Flu Shot 65+}" _pneumo2 "\textbf{Pneumonia Vaccine 65+}" hadmam "\textbf{Mammogram}" hadpap2 "\textbf{Pap Test}" psatest1 "\textbf{PSA Test}" hadsigm3 "\textbf{Colonoscopy/Sigmoidoscopy}" chccopd "\textbf{C.O.P.D}" chcscncr "\textbf{Skin Cancer}" chcocncr "\textbf{Other Cancer}" addepev2 "\textbf{Depression}" chckidny "\textbf{Kidney Disease}", nolabel) ///
title("Summary Statistics: Covariates") ///
mtitle("Maryland" "Contiguous U.S." "Maryland" "Contiguous U.S." "Maryland" "Contiguous U.S.") ///
mgroups("Baseline (2011-2013)" "MDAPM (2014-2018)" "MDTCOC (2019-2022)", pattern(1 0 1 0 1 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) alignment(D{.}{.}{-1}) ///
coeflabel( _I_race_g_2 "Black" _I_race_g_3 "Hispanic" _I_race_g_4 "Other" _Isex_1 "Female" ///
_I_ageg5yr_2 "25-29" _I_ageg5yr_3 "30-34" _I_ageg5yr_4 "35-39" _I_ageg5yr_5 "40-44" _I_ageg5yr_6 "45-49" ///
_I_ageg5yr_7 "50-54" _I_ageg5yr_8 "55-59" _I_ageg5yr_9 "60-64"  _I_ageg5yr_10 "65-69" ///
_I_ageg5yr_11 "70-74" _I_ageg5yr_12 "75-79" _I_ageg5yr_13 "80+" ///
_I_educag_2 "Graduated Highschool" _I_educag_3 "Attended College" _I_educag_4 "Graduated College") ///
label booktabs nonotes nostar nonum nogaps collabels(none) ///
addnotes("\emph{Notes:} Displays the means of the covariates and outcomes. The treatment periods are the Maryland All-Payer Model (MDAPM) and Maryland Total Cost of Care (MD TCOC). The contiguous United States (CUS) is the control group (includes the District of Columbia and excludes Maryland, Alaska, and Hawaii). College includes technical school." "\emph{Source:} Behavioral Risk Factor Surveillance System, 2011-2022.") compress

///////////////////////////////////////////////////////////////////////////////
/////      The table of summary statistics is saved as a PDF file       ///////
/////         in Dropbox under the name "Summary Statistics."           ///////
///////////////////////////////////////////////////////////////////////////////


*******************************************************************************
*******************************************************************************
*******************************************************************************

** OLS Regression without weights:

eststo clear

foreach v of varlist genhlth physhlth menthlth poorhlth hlthpln1 persdoc2 medcost checkup1 exerany2 _rfhlth _hcvu651  _rfbmi5 _totinda bphigh4 bpmeds toldhi2 diabete3 pdiabtst insulin doctdiab chkhemo3 feetchk diabedu _cholchk _rfchol cvdinfr4 cvdcrhd4 cvdstrk3 _drdxar1 asthma3 asthnow _rfsmok3 drnkany5 _rfdrhv4 flushot5 pneuvac3 hivtst6 hpvadvc2 shingle1 _flshot5 _pneumo2 hadmam howlong hadpap2 lastpap2 psatest1 psatime hadsigm3 lastsig3 chccopd chcscncr chcocncr addepev2 chckidny {
 eststo: regress `v' i(1, 2).period#1.maryland i.iyear i._state i.sex i._educag i._ageg5yr i._race_g if contig_us==1, vce(robust)
 }
 
esttab using "$mash/OLS_wo_weight.tex" , style(tex) replace nonum   ///
keep(1.period#1.maryland 2.period#1.maryland) ///
coeflabel(1.period#1.maryland "MDAPM 2014-2018" 2.period#1.maryland "MDTCOC 2019-2022") ///
b(3) p(3) ///
label booktabs noobs collabels(none) ///
title("Coefficient on the Treatment Variables") ///
mtitles("General Health" "Physical Health" "Mental Health" "Poor Health" "Having Health Plan" "Having Health Care Professional" "Medical Cost" "Last Time Having Checkup" "Physical Activity" "Good or Better Health" "Health Insurance" "Obesity" "Physical Activity" "(Ever Told) Having High Blood Pressure" "Medicine for High Blood Pressure" "High Blood Cholesterol" "(Ever Told) Having Diabetes" "High Blood Sugar" "Taking Insulin" "Times Seen Doctor for Diabetes" "Times Checked for A one C" "Times Seen by Doctor to Check Feet Sores" "Diabetes Education" "Cholesterol Check within Past 5 Years" "High Cholesterol" "Heart Attack" "Coronary Heart Disease" "Stroke" "Arthritis" "Asthma" "Still Asthma" "Current Smoker" "Any Drinks" "Heavy Drinker" "Flu Shot" "Pneumonia Vaccine" "HIV Test" "HPV Vaccination" "Shingle Vaccination" "Flu Shot 65+" "Pneumonia Vaccine 65+" "Mammogram" "Last Time Having Mammogram" "Pap Test" "Last Time Having Pap Test" "PSA Test" "Last Time Having PSA Test" "Colonoscopy/Sigmoidoscopy" "Last Time Having Colonoscopy/Sigmoidoscopy" "C.O.P.D" "Skin Cancer" "Other Cancer" "Depression" "Kidney Disease" ) ///
nonotes addnotes("\emph{Notes:} OLS regressions estimates with p-value based on robust standard errors in parentheses. The contiguous United States is the control group (includes the District of Columbia and excludes Maryland, Alaska, and Hawaii)." "\emph{Definitions:} Health Plan is defined as Do you have any kind of health care coverage? \\ Medical Cost is deined as whether there was a time in the past 12 months when the respondent needed to see a doctor but could not because of the costs. Physical Activity is defined as having any physical activities or exercises other than regular job such as running, calisthenics, golf, gardening, or walking. Good or Better Health is defined as adults with good or better health. Health Insurance is defined as respondents aged 18-64 who have any form of health insurance." "\emph{Source:} Behavioral Risk Factor Surveillance System, 2011-2022.") compress

///////////////////////////////////////////////////////////////////////////////
/////      The table of regression results is saved as a PDF file       ///////
/////         in Dropbox under the name "Regression Result."            ///////
///////////////////////////////////////////////////////////////////////////////

 

*******************************************************************************
*******************************************************************************
*******************************************************************************

** OLS Regression with BRFSS weights:

eststo clear

foreach v of varlist genhlth physhlth menthlth poorhlth hlthpln1 persdoc2 medcost checkup1 exerany2 _rfhlth _hcvu651  _rfbmi5 bphigh4 bpmeds toldhi2 diabete3 pdiabtst insulin doctdiab chkhemo3 feetchk diabedu _cholchk _rfchol cvdinfr4 cvdcrhd4 cvdstrk3 _drdxar1 asthma3 asthnow _rfsmok3 drnkany5 _rfdrhv4 flushot5 pneuvac3 hivtst6 hpvadvc2 shingle1 _flshot5 _pneumo2 hadmam howlong hadpap2 lastpap2 psatest1 psatime hadsigm3 lastsig3 chccopd chcscncr chcocncr addepev2 chckidny {
 eststo: regress `v' i(1, 2).period#1.maryland i.iyear i._state i.sex i._educag i._ageg5yr i._race_g if contig_us==1 [pw = _llcpwt], vce(robust)
 }
 
esttab using "$mash/OLS_with_weight.tex" , style(tex) replace nonum   ///
keep(1.period#1.maryland 2.period#1.maryland) ///
coeflabel(1.period#1.maryland "MDAPM 2014-2018" 2.period#1.maryland "MDTCOC 2019-2022") ///
b(3) p(3) ///
label booktabs noobs collabels(none) ///
title("Coefficient on the Treatment Variables") ///
mtitles("General Health" "Physical Health" "Mental Health" "Poor Health" "Having Health Plan" "Having Health Care Professional" "Medical Cost" "Last Time Having Checkup" "Physical Activity" "Good or Better Health" "Health Insurance" "Obesity" "(Ever Told) Having High Blood Pressure" "Medicine for High Blood Pressure" "High Blood Cholesterol" "(Ever Told) Having Diabetes" "High Blood Sugar" "Taking Insulin" "Times Seen Doctor for Diabetes" "Times Checked for A one C" "Times Seen by Doctor to Check Feet Sores" "Diabetes Education" "Cholesterol Check within Past 5 Years" "High Cholesterol" "Heart Attack" "Coronary Heart Disease" "Stroke" "Arthritis" "Asthma" "Still Asthma" "Current Smoker" "Any Drinks" "Heavy Drinker" "Flu Shot" "Pneumonia Vaccine" "HIV Test" "HPV Vaccination" "Shingle Vaccination" "Flu Shot 65+" "Pneumonia Vaccine 65+" "Mammogram" "Last Time Having Mammogram" "Pap Test" "Last Time Having Pap Test" "PSA Test" "Last Time Having PSA Test" "Colonoscopy/Sigmoidoscopy" "Last Time Having Colonoscopy/Sigmoidoscopy" "C.O.P.D" "Skin Cancer" "Other Cancer" "Depression" "Kidney Disease" ) ///
nonotes addnotes("\emph{Notes:} OLS regressions estimates with p-value based on robust standard errors in parentheses. The contiguous United States is the control group (includes the District of Columbia and excludes Maryland, Alaska, and Hawaii)." "\emph{Definitions:} Health Plan is defined as Do you have any kind of health care coverage? \\ Medical Cost is deined as whether there was a time in the past 12 months when the respondent needed to see a doctor but could not because of the costs. Physical Activity is defined as having any physical activities or exercises other than regular job such as running, calisthenics, golf, gardening, or walking. Good or Better Health is defined as adults with good or better health. Health Insurance is defined as respondents aged 18-64 who have any form of health insurance." "\emph{Source:} Behavioral Risk Factor Surveillance System, 2011-2022.") compress 

///////////////////////////////////////////////////////////////////////////////
/////      The table of regression results is saved as a PDF file       ///////
/////         in Dropbox under the name "Regression Result."            ///////
///////////////////////////////////////////////////////////////////////////////



*******************************************************************************
*******************************************************************************
*******************************************************************************
  
** Dynamic DID with 2013 as Reference:


** Explanations of the following code:
** Interaction terms generate coefficient names that look like 2012.iyear#24._state, 2013.iyear#24._state, etc.
** When you plot these coefficients, the default labels would be long and look like that exact format, which isn't very clean or easy to read.
** ([0-9]+): The parentheses around [0-9]+ tell the system to capture whatever sequence of digits it finds. + translate to one or more of the previous item."
** ^ and $ and the beginning and end of ([0-9]+ means start of the string and end of the string respectively.
** ^([0-9]+)$ means look for string one numbers from 0 to 9.
** \1 refers to the part of the text that was captured by the first set of parentheses (). It means use whatever was matched inside the first parentheses.
** In this case, the first thing captured by paranthesis is 2012 so \1 translates to 2012.
** xline(7.5) refers to the point along the x-axis where the vertical reference line will be drawn (in this case between years 2018 and 2019).

label variable genhlth "General Health"
label variable physhlth "Physical Health"
label variable menthlth "Mental Health"
label variable poorhlth "Poor Health"
label variable hlthpln1 "Having Health Plan"
label variable persdoc2 "Having Health Care Professional"
label variable medcost "Medical Cost"
label variable checkup1 "Last Time Having Checkup"
label variable exerany2 "Physical Activity"
label variable _rfhlth "Good or Better Health"
label variable _hcvu651 "Health Insurance"
label variable _rfbmi5 "Obesity"
label variable _totinda "Physical Activity"
label variable bphigh4 "(Ever Told) Having High Blood Pressure" 
label variable bpmeds "Medicine for High Blood Pressure" // every other year
label variable toldhi2 "High Blood Cholesterol" // every other year
label variable diabete3 "(Ever Told) Having Diabetes" // every other year
label variable pdiabtst "High Blood Sugar" 
label variable insulin "Taking Insulin"
label variable doctdiab "Times Seen Doctor for Diabetes"
label variable chkhemo3 "Times Checked for A one C"
label variable feetchk "Times Seen by Doctor to Check Feet Sores"
label variable diabedu "Diabetes Education"
label variable _cholchk "Cholesterol Check within Past 5 Years"
label variable _rfchol "High Cholesterol"
label variable cvdinfr4 "Heart Attack"
label variable cvdcrhd4 "Coronary Heart Disease"
label variable cvdstrk3 "Stroke"
label variable _drdxar1 "Arthritis"
label variable asthma3 "Asthma"
label variable asthnow "Still Asthma"
label variable _rfsmok3 "Current Smoker"
label variable drnkany5 "Any Drinks"
label variable _rfdrhv4 "Heavy Drinker"
label variable flushot5 "Flu Shot"
label variable pneuvac3 "Pneumonia Vaccine"
label variable hivtst6 "HIV Test"
label variable hpvadvc2 "HPV Vaccination"
label variable shingle1 "Shingle Vaccination"
label variable _flshot5 "Flu Shot 65+"
label variable _pneumo2 "Pneumonia Vaccine 65+"
label variable hadmam "Mammogram"
label variable howlong "Last Time Having Mammogram"
label variable hadpap2 "Pap Test"
label variable lastpap2 "Last Time Having Pap Test"
label variable psatest1 "PSA Test"
label variable psatime "Last Time Having PSA Test"
label variable hadsigm3 "Colonoscopy/Sigmoidoscopy"
label variable lastsig3 "Last Time Having Colonoscopy/Sigmoidoscopy"
label variable chccopd "C.O.P.D"
label variable chcscncr "Skin Cancer"
label variable chcocncr "Other Cancer"
label variable addepev2 "Depression"
label variable chckidny "Kidney Disease"

eststo clear
graph drop _all


foreach v of varlist genhlth physhlth menthlth poorhlth hlthpln1 persdoc2 medcost checkup1 exerany2 _rfhlth _hcvu651 _bmi5cat  _rfbmi5 _totinda bphigh4 bpmeds cholchk toldhi2 diabete3 pdiabtst prediab1 insulin doctdiab chkhemo3 feetchk diabedu _cholchk _rfchol cvdinfr4 cvdcrhd4 cvdstrk3 _drdxar1 asthma3 asthnow usenow3 _smoker3 _rfsmok3 drnkany5 _rfdrhv4 flushot5 pneuvac3 hivtst6 hpvadvc2 shingle1 _flshot5 _pneumo2 hadmam howlong hadpap2 lastpap2 psatest1 psatime hadsigm3 lastsig3 chccopd chcscncr chcocncr addepev2 chckidny {
	// Extract the label for the current variable
	local title : variable label `v'

	// Run the regression
	regress `v' ib2013.iyear#24._state ib2013.iyear i._state i.sex i._educag i._ageg5yr i._race_g if contig_us==1 [pw = _llcpwt], vce(robust) level(90)

	// Generate the coefficient plot with the variable label as the title
	coefplot (,keep(*iyear#24._state) ///
		rename(^([0-9]+).iyear#24._state$ = \1, regex)), ///
		vertical nolabel ///
		xline(2.9, lcolor(gs12) lpattern(dash)) ///
	    xline(7.9, lcolor(gs12) lpattern(dash)) ///
	    yline(0, lcolor(gs12) lpattern(dash)) ///
	    xscale(range(0 12) extend) ///
	    xtick(1 2 3 4 5 6 7 8 9 10 11, tstyle(none)) ///
	    xlabel(1 "2011" 2 "2012" 3 "2014" 4 "2015" 5 "2016" 6 "2017" 7 "2018" 8 "2019" 9 "2020" 10 "2021" 11 "2022", angle(45)) ///
		title("`title'") /// Use the variable label as the title
		name(did_`v', replace)
	
	// Save the graph
	graph save did_`v', replace
}



graph combine "$mash/did_genhlth" "$mash/did_physhlth" "$mash/did_menthlth" "$mash/did_poorhlth" "$mash/did_hlthpln1" "$mash/did_persdoc2" , row(2) name(did_set1,replace)
graph display did_set1
graph export "$mash/did_set1.png", name(did_set1) replace

graph combine "$mash/did_medcost" "$mash/did_checkup1" "$mash/did_exerany2" "$mash/did__rfhlth" "$mash/did__hcvu651" "$mash/did__bmi5cat" , row(2) name(did_set2,replace)
graph display did_set2
graph export "$mash/did_set2.png", name(did_set2) replace

graph combine "$mash/did__rfbmi5" "$mash/did__totinda" "$mash/did_bphigh4" "$mash/did_bpmeds" "$mash/did_cholchk" "$mash/did_toldhi2" , row(2) name(did_set3,replace)
graph display did_set3
graph export "$mash/did_set3.png", name(did_set3) replace

graph combine "$mash/did_diabete3" "$mash/did_pdiabtst" "$mash/did_prediab1" "$mash/did_insulin" "$mash/did_doctdiab" "$mash/did_chkhemo3" , row(2) name(did_set4,replace)
graph display did_set4
graph export "$mash/did_set4.png", name(did_set4) replace

graph combine "$mash/did_feetchk" "$mash/did_diabedu" "$mash/did__cholchk" "$mash/did__rfchol" "$mash/did_cvdinfr4" "$mash/did_cvdcrhd4" , row(2) name(did_set5,replace)
graph display did_set5
graph export "$mash/did_set5.png", name(did_set5) replace

graph combine "$mash/did_cvdstrk3" "$mash/did__drdxar1" "$mash/did_asthma3" "$mash/did_asthnow" "$mash/did_usenow3" "$mash/did__smoker3" , row(2) name(did_set6,replace)
graph display did_set6
graph export "$mash/did_set6.png", name(did_set6) replace

graph combine "$mash/did__rfsmok3" "$mash/did_drnkany5" "$mash/did__rfdrhv4" "$mash/did_flushot5" "$mash/did_pneuvac3" "$mash/did_hivtst6" , row(2) name(did_set7,replace)
graph display did_set7
graph export "$mash/did_set7.png", name(did_set7) replace

graph combine "$mash/did_hpvadvc2" "$mash/did_shingle1" "$mash/did__flshot5" "$mash/did__pneumo2" "$mash/did_hadmam" "$mash/did_howlong" , row(2) name(did_set8,replace)
graph display did_set8
graph export "$mash/did_set8.png", name(did_set8) replace

graph combine "$mash/did_hadpap2" "$mash/did_lastpap2" "$mash/did_psatest1" "$mash/did_psatime" "$mash/did_hadsigm3" "$mash/did_lastsig3" , row(2) name(did_set9,replace)
graph display did_set9
graph export "$mash/did_set9.png", name(did_set9) replace

graph combine "$mash/did_chccopd" "$mash/did_chcscncr" "$mash/did_chcocncr" "$mash/did_addepev2" "$mash/did_chckidny" , row(2) name(did_set10,replace)
graph display did_set10
graph export "$mash/did_set10.png", name(did_set10) replace

///////////////////////////////////////////////////////////////////////////////
/////      The table of event studies is saved as a PDF file in         ///////
/////         Dropbox under the name "Event Study Graphs."              ///////
///////////////////////////////////////////////////////////////////////////////



*******************************************************************************
*******************************************************************************
*******************************************************************************


Synthetic Control 

* create a variable to indiciate states with low Social Vulnerability Index
gen low_svi=.
replace low_svi=1 if inlist(_state, 8, 9, 19, 23, 25, 27, 30, 31, 33, 38, 39, 49, 50, 51, 55, 56)
replace low_svi=0 if _state==24
label variable low_svi "States with Low Social Vulnerability Index"
label define low_svi 0 "Maryland" 1 "Other low SVI"
label values low_svi low_svi
format low_svi %10.0g 
tab low_svi, missing




*******************************************************************************
*******************************************************************************
*******************************************************************************


