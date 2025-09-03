capture log close /*Close all open log files*/
clear /* Clear any data in stata*/
cls /* Clears the results windows*/
set more off /* Commands run non-stop*/

global mash "/Users/maryamfatemi/Dropbox (Graduate Center)/BRFSS/Data"
cd "$mash"

/*

unzipfile "Raw_Data_DTA.zip", replace

local files "LLCP2011.dta LLCP2012.dta LLCP2013.dta LLCP2014.dta LLCP2015.dta LLCP2016.dta LLCP2017.dta LLCP2018.dta LLCP2019.dta LLCP2020.dta LLCP2021.dta LLCP2022.dta"

foreach file of local files {
    use "$mash/`file'", clear
    tostring seqno, replace
    save "$mash/`file'", replace
}


use "LLCP2011.dta", clear

append using "$mash/LLCP2012.dta" "$mash/LLCP2013.dta" "$mash/LLCP2014.dta" "$mash/LLCP2015.dta" "$mash/LLCP2016.dta" "$mash/LLCP2017.dta" "$mash/LLCP2018.dta" "$mash/LLCP2019.dta" "$mash/LLCP2020.dta" "$mash/LLCP2021.dta" "$mash/LLCP2022.dta"

* List of variables to keep
keep _state idate imonth iday iyear mscode genhlth physhlth menthlth poorhlth hlthpln1 _hlthpln priminsr persdoc2 persdoc3 medcost medcost1 checkup1 exerany2 _rfhlth _hcvu651 _hcvu652 _bmi5cat _rfbmi5 _totinda marital employ employ1 income2 income3 sex sex1 _sex _imprace _race_g _race_g1 _racegr2 _racegr3 _race _racegr4 _age_g _age80 _ageg5yr _age65yr _educag bphigh4 bphigh6 bpmeds bloodcho cholchk cholchk1 cholchk2 cholchk3 toldhi2 toldhi3 diabete3 diabete4 pdiabtst pdiabts1 prediab1 prediab2 insulin insulin1 bldsugar feetchk2 feetchk3 doctdiab chkhemo3 feetchk diabedu diabedu1 _cholchk _cholch1 _cholch2 _cholch3 _rfchol _rfchol1 _rfchol2 _rfchol3 cvdinfr4 cvdcrhd4 cvdstrk3 cvdasprn aspirin _michd _drdxar1 _drdxar2 _drdxar3 asthma3 asthnow _asthms1 usenow3 _smoker3 _rfsmok3 drnkany5 drnkany6 _rfdrhv4 _rfdrhv5 _rfdrhv6 _rfdrhv7 _rfdrhv8 flushot5 flushot6 flushot7 pneuvac3 pneuvac4 hivtst6 hivtst7 hpvadvc2 hpvadvc3 hpvadvc4 shingle1 shingle2 _flshot5 _flshot6 _flshot7 _pneumo2 _pneumo3 _aidtst3 _aidtst4 hadmam howlong hadpap2 crvclpap lastpap2 psatest1 psatime psatime1 hadsigm3 hadsigm4 _hadsigm lastsig3 lastsig4 colnscpy sigmscpy colntest sigmtest colntes1 sigmtes1 chccopd chccopd1 chccopd2 chccopd3 chcscncr chcscnc1 chcocncr chcocnc1 addepev2 addepev3 chckidny chckdny1 chckdny2 _llcpwt


* recoding _state variable (dropping 66: Guam, 72: Puerto Rico, 78: Virgin Islands)
drop if _state>56 


* drop year 2023 
tab iyear
destring iyear, replace
drop if iyear==2023 
tab iyear

destring imonth, replace

save "$mash/BRFSS_combined_2011_2022.dta", replace
*/

use "$mash/BRFSS_combined_yearfixed.dta", clear

*******************************************************************************

// Variables:

low svi: 8 9 19 23 24 25 27 30 31 33 38 39 49 50 51 55 56

* States
label define _state 1 "Alabama" 2 "Alaska" 4 "Arizona" 5 "Arkansas" 6 "California" 8 "Colorado" 9 "Connecticut" 10 "Delaware" 11 "District of Columbia" 12 "Florida" 13 "Georgia" 15 "Hawaii" 16 "Idaho" 17 "Illinois" 18 "Indiana" 19 "Iowa" 20 "Kansas" 21 "Kentucky" 22 "Louisiana" 23 "Maine" 24 "Maryland" 25 "Massachusetts" 26 "Michigan" 27 "Minnesota" 28 "Mississippi" 29 "Missouri" 30 "Montana" 31 "Nebraska" 32 "Nevada" 33 "New Hampshire" 34 "New Jersey" 35 "New Mexico" 36 "New York" 37 "North Carolina" 38 "North Dakota" 39 "Ohio" 40 "Oklahoma" 41 "Oregon" 42 "Pennsylvania" 44 "Rhode Island" 45 "South Carolina" 46 "South Dakota" 47 "Tennessee" 48 "Texas" 49 "Utah" 50 "Vermont" 51 "Virginia" 53 "Washington" 54 "West Virginia" 55 "Wisconsin" 56 "Wyoming" 
label values _state _state
tab _state, missing



* Q: Would you say that in general your health is:
* 1: Excellent, 2: Very good, 3: Good, 4: Fair, 5: Poor
tab genhlth
replace genhlth = . if inlist(genhlth, 7, 9)
label define genhlth 1 "Excellent" 2 "Very Good" 3 "Good" 4 "Fair" 5 "Poor"
label values genhlth genhlth
tab genhlth, missing


* Q: For how many days during the past 30 days was your physical health not good?
tab physhlth, missing
replace physhlth = 0 if physhlth == 88
replace physhlth = . if inlist(physhlth, 77, 99)
label variable physhlth "Number of Days Physical Health Not Good in Past 30 Days"
label define physhlth 0 "O days physical health not good" 1 "1 days physical health not good" 2 "2 days physical health not good" 3 "3 days physical health not good" 4 "4 days physical health not good" 5 "5 days physical health not good" 6 "6 days physical health not good" 7 "7 days physical health not good" 8 "8 days physical health not good" 9 "9 days physical health not good" 10 "1O days physical health not good" 11 "11 days physical health not good" 12 "12 days physical health not good" 13 "13 days physical health not good" 14 "14 days physical health not good" 15 "15 days physical health not good" 16 "16 days physical health not good" 17 "17 days physical health not good" 18 "18 days physical health not good" 19 "19 days physical health not good" 20 "2O days physical health not good" 21 "21 days physical health not good" 22 "22 days physical health not good" 23 "23 days physical health not good" 24 "24 days physical health not good" 25 "25 days physical health not good" 26 "26 days physical health not good" 27 "27 days physical health not good" 28 "28 days physical health not good" 29 "29 days physical health not good" 30 "3O days physical health not good"
label values physhlth physhlth
tab physhlth, missing


* Q: For how many days during the past 30 days was your mental health not good?
tab menthlth, missing
replace menthlth = 0 if menthlth == 88
replace menthlth = . if inlist(menthlth, 77, 99)
label variable menthlth "Number of Days Mental Health Not Good in Past 30 Days"
label define menthlth 0 "O days mental health not good" 1 "1 days mental health not good" 2 "2 days mental health not good" 3 "3 days mental health not good" 4 "4 days mental health not good" 5 "5 days mental health not good" 6 "6 days mental health not good" 7 "7 days mental health not good" 8 "8 days mental health not good" 9 "9 days mental health not good" 10 "1O days mental health not good" 11 "11 days mental health not good" 12 "12 days mental health not good" 13 "13 days mental health not good" 14 "14 days mental health not good" 15 "15 days mental health not good" 16 "16 days mental health not good" 17 "17 days mental health not good" 18 "18 days mental health not good" 19 "19 days mental health not good" 20 "2O days mental health not good" 21 "21 days mental health not good" 22 "22 days mental health not good" 23 "23 days mental health not good" 24 "24 days mental health not good" 25 "25 days mental health not good" 26 "26 days mental health not good" 27 "27 days mental health not good" 28 "28 days mental health not good" 29 "29 days mental health not good" 30 "3O days mental health not good"
label values menthlth menthlth
tab menthlth, missing


* Q: During the past 30 days, for about how many days did poor physical or mental health keep you from doing your usual activities, such as self-care, work, or recreation?
tab poorhlth, missing
replace poorhlth = 0 if poorhlth == 88
replace poorhlth = . if inlist(poorhlth, 77, 99)
label variable poorhlth "Number of Days Poor Mental or Physical Health Limit Usual Activities"
label define poorhlth 0 "0 days of poor health" 1 "1 day of poor health" 2 "2 days of poor health" 3 "3 days of poor health" 4 "4 days of poor health" 5 "5 days of poor health" 6 "6 days of poor health" 7 "7 days of poor health" 8 "8 days of poor health" 9 "9 days of poor health" 10 "10 days of poor health" 11 "11 days of poor health" 12 "12 days of poor health" 13 "13 days of poor health" 14 "14 days of poor health" 15 "15 days of poor health" 16 "16 days of poor health" 17 "17 days of poor health" 18 "18 days of poor health" 19 "19 days of poor health" 20 "20 days of poor health" 21 "21 days of poor health" 22 "22 days of poor health" 23 "23 days of poor health" 24 "24 days of poor health" 25 "25 days of poor health" 26 "26 days of poor health" 27 "27 days of poor health" 28 "28 days of poor health" 29 "29 days of poor health" 30 "30 days of poor health"
label values poorhlth poorhlth
tab poorhlth, missing


* Q: Do you have any kind of health care coverage, including health insurance, prepaid plans such as HMOs, or government plans such as Medicare, or Indian Health Service?
* 1: yes, 2: no 
tab1 hlthpln1 _hlthpln, missing
replace hlthpln1=0 if hlthpln1==2
replace hlthpln1=. if inlist(hlthpln1, 7, 9)
replace _hlthpln=0 if _hlthpln==2
replace _hlthpln=. if inlist(_hlthpln, 7, 9)
replace hlthpln1=1 if _hlthpln==1
replace hlthpln1=0 if _hlthpln==0
label define hlthpln1 0 "No" 1 "Yes"
label values hlthpln1 hlthpln1
tab hlthpln1, missing
drop _hlthpln


* Q: Do you have one person or a group of doctors that you think of as your personal health care provider?
* 1: yes, only one, 2: more than one, 3: no
tab1 persdoc2 persdoc3, missing
replace persdoc2=0 if persdoc2==3
replace persdoc2=. if inlist(persdoc2, 7, 9)
replace persdoc3=0 if persdoc3==3
replace persdoc3=. if inlist(persdoc3, 7, 9)
replace persdoc2=0 if persdoc3==0
replace persdoc2=1 if persdoc3==1
replace persdoc2=2 if persdoc3==2
label define persdoc2 0 "No" 1 "Yes, Only one" 2 "More than one"
label values persdoc2 persdoc2
tab persdoc2, missing
drop persdoc3

* Binary variable for primary doctor:
gen personaldoc=.
replace personaldoc=0 if persdoc2==0
replace personaldoc=1 if inlist(persdoc2, 1, 2)
label variable personaldoc "Having Personal Health Care Provider"
label define personaldoc 0 "No" 1 "Yes"
label values personaldoc personaldoc
tab personaldoc, missing


* Q: Was there a time in the past 12 months when you needed to see a doctor but could not because you could not afford it?
* 1: yes, 2: no
tab1 medcost medcost1, missing
replace medcost=0 if medcost==2
replace medcost=. if inlist(medcost, 7, 9)
replace medcost1=0 if medcost1==2
replace medcost1=. if inlist(medcost1, 7, 9)
replace medcost=0 if medcost1==0
replace medcost=1 if medcost1==1
label define medcost 0 "No" 1 "Yes"
label values medcost medcost
tab medcost, missing
drop medcost1


* Q: About how long has it been since you last visited a doctor for a routine checkup?
* 1: Within past year (anytime less than 12 months ago), 2: Within past 2 years (1 year but less than 2 years ago), 3: Within past 5 years (2 years but less than 5 years ago), 4: 5 or more years ago, 8: Never
tab checkup1, missing
replace checkup1=. if inlist(checkup1, 7, 9)
replace checkup1=0 if checkup1==8
label define checkup1 0 "Never" 1 "Within the past year" 2 "With past 2 years" 3 "Within past 5 years " 4 "5 or more years ago " 
label values checkup1 checkup1
tab checkup1, missing


* Q: During the past month, other than your regular job, did you participate in any physical activities or exercises such as running, calisthenics, golf, gardening, or walking for exercise?
* 1: Yes, 2: No
tab exerany2, missing
replace exerany2=0 if exerany2==2
replace exerany2=. if inlist(exerany2, 7 , 9)
label define exerany2 0 "No" 1 "Yes"
label values exerany2 exerany2
tab exerany2, missing


* Adults with good or better health
* 1: Good or Better Health (genhlth == 1 | 2 | 3), 2: Fair or poor health (genhlth == 4 | 5)
tab _rfhlth, missing
replace _rfhlth=. if _rfhlth==9
replace _rfhlth=0 if _rfhlth==2
label define _rfhlth 0 "Fair or Poor Health" 1 "Good or Better Health"
label values _rfhlth _rfhlth
tab _rfhlth, missing


* Respondents aged 18-64 who have any form of health insurance
* 1: Have some form of health insurance, 2: Do not have some form of health insurance
tab1 _hcvu651 _hcvu652, missing
replace _hcvu651=0 if _hcvu651==2
replace _hcvu651=. if _hcvu651==9
tab _hcvu651, missing
tab _hcvu652, missing
replace _hcvu652=0 if _hcvu652==2
replace _hcvu652=. if _hcvu652==9
tab _hcvu652, missing
tab _hcvu651, missing
replace _hcvu651=0 if _hcvu652==0
replace _hcvu651=1 if _hcvu652==1
label define _hcvu651 0 "No" 1 "Yes"
label values _hcvu651 _hcvu651
tab _hcvu651, missing
drop _hcvu652


* Four-categories of Body Mass Index (BMI)
tab _bmi5cat, missing
label define _bmi5cat 1 "Underweight" 2 "Normal" 3 "Overweight" 4 "Obese"
label values _bmi5cat _bmi5cat
tab _bmi5cat, missing


* Adults who have a body mass index greater than 25.00 (Overweight or Obese)
* 1: No, 2: Yes
tab _rfbmi5, missing
replace _rfbmi5 = . if _rfbmi5 == 9
replace _rfbmi5 = 0 if _rfbmi5 == 1
replace _rfbmi5 = 1 if _rfbmi5 == 2
label define _rfbmi5 0 "No" 1 "Yes"
label values _rfbmi5 _rfbmi5
tab _rfbmi5, missing


* Adults who reported doing physical activity or exercise during the past 30 days other than their regular job
* 1: Had physical activity or exercise, 2: No physical activity or exercise in last 30 days
tab _totinda, missing
replace _totinda=. if _totinda==9
replace _totinda=0 if _totinda==2
label variable _totinda "Doing physical activity/exercise during the past 30 days other than regular job"
label define _totinda 0 "No" 1 "Yes"
label values _totinda _totinda
tab _totinda, missing



* Marital Status
* 1: Married, 2: Divorced, 3: Widowed, 4: Separated, 5: Never Married, 6: A member of an unmarried couple
tab marital, missing
replace marital=0 if inrange(marital, 2, 6)
replace marital=. if marital==9
label define marital 0 "No" 1 "Yes"
label values marital marital
tab marital, missing



* Q: Are you currently…?
* 1: Employed for wages, 2: Self-employed, 3: Out of work for 1 year or more, 4: Out of work for less than 1 year, 5: A homemaker, 6: A student, 7: Retired, 8: Unable to work
tab1 employ employ1, missing
replace employ=. if employ==9
replace employ1=. if employ1==9
forval i = 1/8 {
    replace employ = `i' if employ1 == `i' 
}
label define employ 1 "Employed for wages" 2 "Self-employed" 3 "Out of work for 1 year or more" 4 "Out of work for less than 1 year" 5 "A homemaker" 6 "Student" 7 "Retired" 8 "Unable to work"
label values employ employ
tab employ, missing
drop employ1


* generating a dummy employment variable
* 0: not employed (Out of work for 1 year or more, Out of work for less than 1 year, A homemaker, A student, Retired, Unable to work), 1: employed (Employed for wages, Self-employed)
gen employment=.
replace employment=0 if inrange(employ, 3, 8) 
replace employment=1 if inlist(employ, 1, 2) 
label variable employment "Are you currently employed or self-employed?"
label define employment 0 "No" 1 "Yes"
label values employment employment
tab employment, missing 


* Is your annual household income from all sources ...
* 1: Less than $10,000, 2: Less than $15,000 ($10,000 to < $15,000), 3: Less than $20,000 ($15,000 to < $20,000), 4: Less than $25,000 ($20,000 to < $25,000), 
* 5: Less than $35,000 ($25,000 to < $35,000),  6: Less than $50,000 ($35,000 to < $50,000), 7: Less than $75,000 ($50,000 to < $75,000), 8: $75,000 or more
tab1 income2 income3, missing
replace income2=. if inlist(income2, 77, 99)
replace income3=8 if inrange(income3, 9, 11)
replace income3=. if inlist(income3, 77, 99)
forval i = 1/8 {
	replace income2 = `i' if income3 == `i'
}
label define income2 1 "Less than $10,000" 2 "Less than $15,000 ($10,000 to < $15,000)" 3 "Less than $20,000 ($15,000 to < $20,000)" 4 "Less than $25,000 ($20,000 to < $25,000)" 5 "Less than $35,000 ($25,000 to < $35,000)"  6 "Less than $50,000 ($35,000 to < $50,000)" 7 "Less than $75,000 ($50,000 to < $75,000)" 8 "$75,000 or more"
label values income2 income2
tab income2, missing
drop income3


* Gender, 1: male, 2: female
tab1 _sex sex1 sex, missing
replace _sex=0 if _sex==1
replace _sex=1 if _sex==2
replace sex1=0 if sex1==1
replace sex1=1 if sex1==2
replace sex1=. if inlist(sex1, 7, 9)
replace sex=0 if sex==1
replace sex=1 if sex==2
replace sex=. if sex==9
replace sex=0 if (_sex==0 | sex1==0)
replace sex=1 if (_sex==1 | sex1==1) 
label define sex 0 "Male" 1 "Female"
label values sex sex 
tab sex, missing
drop _sex sex1


* Race, 1: white, 2: black, 3: hispanic, 4: other
* _race_g for 2011-2012 / _racegr3 for 2013-2021 / _racegr4 for 2022
tab1 _race_g _racegr3 _racegr4, missing
replace _race_g=4 if _race_g==5
replace _racegr3=4 if _racegr3==3
replace _racegr3=3 if _racegr3==5
replace _racegr3=. if _racegr3==9
replace _racegr4=4 if _racegr4==3
replace _racegr4=3 if _racegr4==5
replace _racegr4=. if _racegr4==9
forval i = 1/4 {
	replace _race_g = `i' if _racegr3 == `i'
}
forval i = 1/4 {
	replace _race_g = `i' if _racegr4 == `i'
}
label define _race_g 1 "White" 2 "Black" 3 "Hispanic" 4 "Other"
label values _race_g _race_g  
tab _race_g, missing
drop _race _race_g1 _racegr3 _racegr4


* Age, 1: 18-24, 2: 25-29, 3: 30-34, 4: 35-39, 5: 40-44, 6: 45-49, 7: 50-54, 8: 55-59, 9: 60-64, 10: 65-69, 11: 70-74, 12: 75-79, 13: 80 and older
tab1 _ageg5yr, missing
replace _ageg5yr = . if _ageg5yr == 14
label define _ageg5yr  1 "18-24" 2 "25-29" 3 "30-34" 4 "35-39" 5 "40-44" 6 "45-49" 7 "50-54" 8 "55-59" 9 "60-64" 10 "65-69" 11 "70-74" 12 "75-79" 13 "80 and older"
label values _ageg5yr _ageg5yr  
tab _ageg5yr, missing


/////// Susan replaced 9 with 1 (missing with not graduate high school)
* Level of education completed
* 1: Did not graduate high school, 2: Graduated high school, 3: Attended college or technical school, 4: Graduated from college or technical school
tab _educag, missing
replace _educag = . if _educag == 9
label define _educag 1 "Did not graduate high school" 2 "Graduated high school" 3 "Attended college or technical school" 4 "Graduated from college or technical school"
label values _educag _educag
tab _educag, missing


* Q: have you ever been told you have high blood pressure?
* 1: yes, 2: yes but during pregnancy, 3: no, 4: borderline high or pre-hypertensive
tab1 bphigh4 bphigh6
replace bphigh4=0 if bphigh4==3
replace bphigh4=3 if bphigh4==4
replace bphigh4=. if inlist(bphigh4, 7, 9)
replace bphigh6=0 if bphigh6==3
replace bphigh6=3 if bphigh6==4
replace bphigh6=. if inlist(bphigh6, 7, 9)
forval i=0/3 {
	replace bphigh4=`i' if bphigh6==`i'
}
label define bphigh4  0 "No" 1 "Yes" 2 "Yes but During Pregnancy" 3 "Borderline High or Pre-Hypertensive"
label values bphigh4 bphigh4  
tab bphigh4, missing
drop bphigh6


* Binary variable for high blood pressure:
gen highbp=.
replace highbp=0 if inlist(bphigh4, 0, 3)
replace highbp=1 if inlist(bphigh4, 1, 2)
label variable highbp "High Blood Pressure"
label define highbp 0 "No" 1 "Yes"
label values highbp highbp
tab highbp, missing


* Q: Are you currently taking medicine for your high blood pressure?
* 1: Yes, 2: No
tab bpmeds, missing
replace bpmeds = 0 if bpmeds == 2
replace bpmeds = . if inlist(bpmeds, 7, 9)
label define bpmeds 0 "No" 1 "Yes"
label values bpmeds bpmeds
tab bpmeds, missing


* Q: About how long has it been since you last had your blood cholesterol checked?
* 1: within the past year, 2: within the past two years, 3: within the past 5 years, 4: 5 or more years ago
tab1 cholchk cholchk1 cholchk2 cholchk3
replace cholchk=. if inlist(cholchk, 7, 9)
replace cholchk1=. if cholchk1==1
forval i=2/5 {
    replace cholchk1 = `=`i'-1' if cholchk1 == `i'
}
replace cholchk1=. if inlist(cholchk1, 7, 9)
replace cholchk2=. if cholchk2==1
replace cholchk2=4 if inlist(cholchk2, 5, 6)
replace cholchk2=5 if cholchk2==8
forval i=2/5 {
    replace cholchk2 = `=`i'-1' if cholchk2 == `i'
}
replace cholchk2=. if inlist(cholchk2, 7, 9)
replace cholchk3=. if cholchk3==1
replace cholchk3=4 if inlist(cholchk3, 5, 6)
replace cholchk3=5 if cholchk3==8
forval i=2/5 {
	replace cholchk3 = `=`i'-1' if cholchk3 == `i'
}
replace cholchk3=. if inlist(cholchk3, 7, 9)
forval i=1/4 {
	replace cholchk=`i' if (cholchk1==`i' | cholchk2==`i' | cholchk3==`i')
}
label define cholchk  1 "within the past year" 2 "within the past two years" 3 "within the past 5 years" 4 "5 or more years ago"
label values cholchk cholchk  
tab cholchk, missing
drop cholchk1 cholchk2 cholchk3


* Q: Have you ever been told that your blood cholesterol is high?
* 1: yes, 2: no
tab1 toldhi2 toldhi3, missing
replace toldhi2=0 if toldhi2==2
replace toldhi2=. if inlist(toldhi2, 7, 9)
replace toldhi3=0 if toldhi3==2
replace toldhi3=. if inlist(toldhi3, 7, 9)
replace toldhi2=0 if toldhi3==0
replace toldhi2=1 if toldhi3==1
label define toldhi2  0 "No" 1 "Yes"
label values toldhi2 toldhi2  
tab toldhi2, missing
drop toldhi3


* Q: Have you ever been told you have diabetes?
* 1: yes, 2: yes during pregnancy, 3: no, 4: borderline or pre-diabetes
tab1 diabete3 diabete4, missing
replace diabete3=0 if diabete3==3
replace diabete3=3 if diabete3==4
replace diabete3=. if inlist(diabete3, 7, 9)
replace diabete4=0 if diabete4==3
replace diabete4=3 if diabete4==4
replace diabete4=. if inlist(diabete4, 7, 9)
forval i=0/3 {
	replace diabete3=`i' if diabete4==`i'
}
label define diabete3 0 "No" 1 "Yes" 2 "Yes, but During Pregnancy" 3 "Borderline or Pre-Diabetes"
label values diabete3 diabete3
tab diabete3, missing
drop diabete4


* Binary Variable for Diabetes:
gen diabete_bin=.
replace diabete_bin=0 if inlist(diabete3, 0, 3)
replace diabete_bin=1 if inlist(diabete3, 1, 2)
label variable diabete_bin "Having Diabetes (including pregnancy)"
label define diabete_bin 0 "No" 1 "Yes"
label values diabete_bin diabete_bin
tab diabete_bin, missing


////// for 2022 it was changed to when was the last time you had a blood test for high blood sugar or diabetes [merged values 1 to 3 as 1 (within past year, past two years and past three years), merged values 4 to 6 and 8 as 0 (within the past 5 years, past 10 years, 10 years and more, never)]
* Have you had a test for high blood sugar or diabetes within the past three years?
* 1: Yes, 2: No
tab1 pdiabtst pdiabts1, missing
replace pdiabtst=0 if pdiabtst==2
replace pdiabtst=. if inlist(pdiabtst, 7, 9)
replace pdiabts1=1 if inlist(pdiabts1, 2, 3)
replace pdiabts1=0 if inrange(pdiabts1, 4, 6)
replace pdiabts1=0 if pdiabts1==8
replace pdiabts1=. if inlist(pdiabts1, 7, 9)
replace pdiabtst=0 if pdiabts1==0
replace pdiabtst=1 if pdiabts1==1
label variable pdiabtst "Had a Test For High Blood Sugar in Past 3 Years?"
label define pdiabtst 0 "No" 1 "Yes"
label values pdiabtst pdiabtst
tab pdiabtst, missing
drop pdiabts1


* Q: Have you ever been told by a doctor or other health professional that you have pre-diabetes or borderline diabetes?
* 1: yes, 2: yes-during pregnancy, 3:no
tab1 prediab1 prediab2, missing
replace prediab1=0 if prediab1==3
replace prediab1=. if inlist(prediab1, 7, 9)
replace prediab2=0 if prediab2==3
replace prediab2=. if inlist(prediab2, 7, 9)
forval i=0/2 {
	replace prediab1=`i' if prediab2==`i'
}
label define prediab1 0 "No" 1 "Yes" 2 "Yes, but During Pregnancy"
label values prediab1 prediab1
tab prediab1, missing
drop prediab2


* Binary variable for pre-diabetes:
gen prediabetes=.
replace prediabetes=0 if prediab1==0
replace prediabetes=1 if inlist(prediab1, 1, 2)
label variable prediabetes "Having Pre-diabetes (including pregnancy)"
label define prediabetes 0 "No" 1 "Yes"
label values prediabetes prediabetes
tab prediabetes, missing


* Q: Are you now taking insulin?
* 1: yes, no: 2
tab1 insulin insulin1, missing
replace insulin=0 if insulin==2
replace insulin=. if insulin==9
replace insulin1=0 if insulin1==2
replace insulin1=. if inlist(insulin1, 7, 9)
replace insulin=0 if insulin1==0
replace insulin=1 if insulin1==1
label define insulin 0 "No" 1 "Yes"
label values insulin insulin
tab insulin, missing
drop insulin1


/////// BLDSUGAR

/////// FEETCHK2

* Q: About how many times in the past 12 months have you seen a doctor, nurse, or other health professional for your diabetes?
tab doctdiab, missing
replace doctdiab=0 if doctdiab==88
replace doctdiab=. if inlist(doctdiab, 77, 99)
label variable doctdiab "Times Seen Health Care Professional for Diabetes in Past 12 Months"
label define doctdiab 0 "0 times seen dr for diabetes" 1 "1 time seen dr for diabetes" 2 "2 times seen dr for diabetes" 3 "3 times seen dr for diabetes" 4 "4 times seen dr for diabetes" 5 "5 times seen dr for diabetes" 6 "6 times seen dr for diabetes" 7 "7 times seen dr for diabetes" 8 "8 times seen dr for diabetes" 9 "9 times seen dr for diabetes" 10 "10 times seen dr for diabetes" 11 "11 times seen dr for diabetes" 12 "12 times seen dr for diabetes" 13 "13 times seen dr for diabetes" 14 "14 times seen dr for diabetes" 15 "15 times seen dr for diabetes" 16 "16 times seen dr for diabetes" 17 "17 times seen dr for diabetes" 18 "18 times seen dr for diabetes" 19 "19 times seen dr for diabetes" 20 "20 times seen dr for diabetes" 21 "21 times seen dr for diabetes" 22 "22 times seen dr for diabetes" 23 "23 times seen dr for diabetes" 24 "24 times seen dr for diabetes" 25 "25 times seen dr for diabetes" 26 "26 times seen dr for diabetes" 27 "27 times seen dr for diabetes" 28 "28 times seen dr for diabetes" 29 "29 times seen dr for diabetes" 30 "30 times seen dr for diabetes" 31 "31 times seen dr for diabetes" 32 "32 times seen dr for diabetes" 33 "33 times seen dr for diabetes" 34 "34 times seen dr for diabetes" 35 "35 times seen dr for diabetes" 36 "36 times seen dr for diabetes" 37 "37 times seen dr for diabetes" 38 "38 times seen dr for diabetes" 39 "39 times seen dr for diabetes" 40 "40 times seen dr for diabetes" 41 "41 times seen dr for diabetes" 42 "42 times seen dr for diabetes" 43 "43 times seen dr for diabetes" 44 "44 times seen dr for diabetes" 45 "45 times seen dr for diabetes" 46 "46 times seen dr for diabetes" 47 "47 times seen dr for diabetes" 48 "48 times seen dr for diabetes" 49 "49 times seen dr for diabetes" 50 "50 times seen dr for diabetes" 51 "51 times seen dr for diabetes" 52 "52 times seen dr for diabetes" 53 "53 times seen dr for diabetes" 54 "54 times seen dr for diabetes" 55 "55 times seen dr for diabetes" 56 "56 times seen dr for diabetes" 57 "57 times seen dr for diabetes" 58 "58 times seen dr for diabetes" 59 "59 times seen dr for diabetes" 60 "60 times seen dr for diabetes" 61 "61 times seen dr for diabetes" 62 "62 times seen dr for diabetes" 63 "63 times seen dr for diabetes" 64 "64 times seen dr for diabetes" 65 "65 times seen dr for diabetes" 66 "66 times seen dr for diabetes" 67 "67 times seen dr for diabetes" 68 "68 times seen dr for diabetes" 69 "69 times seen dr for diabetes" 70 "70 times seen dr for diabetes" 71 "71 times seen dr for diabetes" 72 "72 times seen dr for diabetes" 73 "73 times seen dr for diabetes" 74 "74 times seen dr for diabetes" 75 "75 times seen dr for diabetes" 76 "76 times or more seen dr for diabetes"
label values doctdiab doctdiab
tab doctdiab, missing


* A test for "A one C" measures the average level of blood sugar over the past three months. About how many times in the past 12 months has a doctor, nurse, or other health professional checked you for "A one C"?
* 88: none, 98: never heard of A one C test (merge these two as 0)
tab chkhemo3, missing
replace chkhemo3=0 if (chkhemo3 == 88 | chkhemo3 == 98)
replace chkhemo3=. if inlist(chkhemo3, 77, 99)
label variable chkhemo3 "Times Checked A one C in Past 3 Months"
label define chkhemo3 0 "0 times checked A one C" 1 "1 time checked A one C" 2 "2 times checked A one C" 3 "3 times checked A one C" 4 "4 times checked A one C" 5 "5 times checked A one C" 6 "6 times checked A one C" 7 "7 times checked A one C" 8 "8 times checked A one C" 9 "9 times checked A one C" 10 "10 times checked A one C" 11 "11 times checked A one C" 12 "12 times checked A one C" 13 "13 times checked A one C" 14 "14 times checked A one C" 15 "15 times checked A one C" 16 "16 times checked A one C" 17 "17 times checked A one C" 18 "18 times checked A one C" 19 "19 times checked A one C" 20 "20 times checked A one C" 21 "21 times checked A one C" 22 "22 times checked A one C" 23 "23 times checked A one C" 24 "24 times checked A one C" 25 "25 times checked A one C" 26 "26 times checked A one C" 27 "27 times checked A one C" 28 "28 times checked A one C" 29 "29 times checked A one C" 30 "30 times checked A one C" 31 "31 times checked A one C" 32 "32 times checked A one C" 33 "33 times checked A one C" 34 "34 times checked A one C" 35 "35 times checked A one C" 36 "36 times checked A one C" 37 "37 times checked A one C" 38 "38 times checked A one C" 39 "39 times checked A one C" 40 "40 times checked A one C" 41 "41 times checked A one C" 42 "42 times checked A one C" 43 "43 times checked A one C" 44 "44 times checked A one C" 45 "45 times checked A one C" 46 "46 times checked A one C" 47 "47 times checked A one C" 48 "48 times checked A one C" 49 "49 times checked A one C" 50 "50 times checked A one C" 51 "51 times checked A one C" 52 "52 times checked A one C" 53 "53 times checked A one C" 54 "54 times checked A one C" 55 "55 times checked A one C" 56 "56 times checked A one C" 57 "57 times checked A one C" 58 "58 times checked A one C" 59 "59 times checked A one C" 60 "60 times checked A one C" 61 "61 times checked A one C" 62 "62 times checked A one C" 63 "63 times checked A one C" 64 "64 times checked A one C" 65 "65 times checked A one C" 66 "66 times checked A one C" 67 "67 times checked A one C" 68 "68 times checked A one C" 69 "69 times checked A one C" 70 "70 times checked A one C" 71 "71 times checked A one C" 72 "72 times checked A one C" 73 "73 times checked A one C" 74 "74 times checked A one C" 75 "75 times checked A one C" 76 "76 times or more checked A one C"
label values chkhemo3 chkhemo3
tab chkhemo3, missing


* Q: About how many times in the past 12 months has a health professional checked your feet for any sores or irritations?
tab feetchk, missing
replace feetchk=0 if feetchk==88
replace feetchk=. if inlist(feetchk, 77, 99)
label variable feetchk "Times Feet Checked by Dr for Sores/Irritations in Past 12 Months"
label define feetchk 0 "0 times feet checked by dr" 1 "1 time feet checked by dr" 2 "2 times feet checked by dr" 3 "3 times feet checked by dr" 4 "4 times feet checked by dr" 5 "5 times feet checked by dr" 6 "6 times feet checked by dr" 7 "7 times feet checked by dr" 8 "8 times feet checked by dr" 9 "9 times feet checked by dr" 10 "10 times feet checked by dr" 11 "11 times feet checked by dr" 12 "12 times feet checked by dr" 13 "13 times feet checked by dr" 14 "14 times feet checked by dr" 15 "15 times feet checked by dr" 16 "16 times feet checked by dr" 17 "17 times feet checked by dr" 18 "18 times feet checked by dr" 19 "19 times feet checked by dr" 20 "20 times feet checked by dr" 21 "21 times feet checked by dr" 22 "22 times feet checked by dr" 23 "23 times feet checked by dr" 24 "24 times feet checked by dr" 25 "25 times feet checked by dr" 26 "26 times feet checked by dr" 27 "27 times feet checked by dr" 28 "28 times feet checked by dr" 29 "29 times feet checked by dr" 30 "30 times feet checked by dr" 31 "31 times feet checked by dr" 32 "32 times feet checked by dr" 33 "33 times feet checked by dr" 34 "34 times feet checked by dr" 35 "35 times feet checked by dr" 36 "36 times feet checked by dr" 37 "37 times feet checked by dr" 38 "38 times feet checked by dr" 39 "39 times feet checked by dr" 40 "40 times feet checked by dr" 41 "41 times feet checked by dr" 42 "42 times feet checked by dr" 43 "43 times feet checked by dr" 44 "44 times feet checked by dr" 45 "45 times feet checked by dr" 46 "46 times feet checked by dr" 47 "47 times feet checked by dr" 48 "48 times feet checked by dr" 49 "49 times feet checked by dr" 50 "50 times feet checked by dr" 51 "51 times feet checked by dr" 52 "52 times feet checked by dr" 53 "53 times feet checked by dr" 54 "54 times feet checked by dr" 55 "55 times feet checked by dr" 56 "56 times feet checked by dr" 57 "57 times feet checked by dr" 58 "58 times feet checked by dr" 59 "59 times feet checked by dr" 60 "60 times feet checked by dr" 61 "61 times feet checked by dr" 62 "62 times feet checked by dr" 63 "63 times feet checked by dr" 64 "64 times feet checked by dr" 65 "65 times feet checked by dr" 66 "66 times feet checked by dr" 67 "67 times feet checked by dr" 68 "68 times feet checked by dr" 69 "69 times feet checked by dr" 70 "70 times feet checked by dr" 71 "71 times feet checked by dr" 72 "72 times feet checked by dr" 73 "73 times feet checked by dr" 74 "74 times feet checked by dr" 75 "75 times feet checked by dr" 76 "76 times or more feet checked by dr"
label values feetchk feetchk
tab feetchk, missing


////// diabedu1 definition changed to when was the last time you took a course for managing diabetes yourself, merging values 1 to 6 as yes (within past year to 10 years and more), consider value 8 which is never as no
* Q: Have you ever taken a course or class in how to manage your diabetes yourself?
* 1: Yes, 2: No
tab1 diabedu diabedu1, missing
replace diabedu=0 if diabedu==2
replace diabedu=. if inlist(diabedu, 7, 9)
replace diabedu1=1 if inrange(diabedu1, 1, 6)
replace diabedu1=0 if diabedu1==8
replace diabedu1=. if inlist(diabedu1, 7, 9)
replace diabedu=0 if diabedu1==0
replace diabedu=1 if diabedu1==1
label define diabedu 0 "No" 1 "Yes"
label values diabedu diabedu
tab diabedu, missing
drop diabedu1


* Cholesterol Check within the past 5 years:
* 1: Had cholesterol check within the past five years
* 2: Did not have cholesterol checked in past 5 years
* 3: Have never had cholesterol checked
tab1 _cholch1 _cholch2 _cholch3 _cholchk, missing
replace _cholchk=0 if (_cholchk==2 | _cholchk==3)
replace _cholchk=. if _cholchk==9
replace _cholch1=0 if (_cholch1==2 | _cholch1==3)
replace _cholch1=. if _cholch1==9
replace _cholch2=0 if (_cholch2==2 | _cholch2==3)
replace _cholch2=. if _cholch2==9
replace _cholch3=0 if (_cholch3==2 | _cholch3==3)
replace _cholch3=. if _cholch3==9
replace _cholchk=0 if (_cholch1==0 | _cholch2==0 | _cholch3==0)
replace _cholchk=1 if (_cholch1==1 | _cholch2==1 | _cholch3==1)
label variable _cholchk "Cholesterol Check Within The Past 5 Years"
label define _cholchk 0 "No" 1 "Yes"
label values _cholchk _cholchk
tab _cholchk, missing
drop _cholch1 _cholch2 _cholch3


* Adults who have had their cholesterol checked and have been told by a doctor, nurse, or other health professional that it was high
* 1: no, 2: yes
tab1 _rfchol _rfchol1 _rfchol2 _rfchol3, missing
replace _rfchol=0 if _rfchol==1
replace _rfchol=1 if _rfchol==2
replace _rfchol=. if _rfchol==9
replace _rfchol1=0 if _rfchol1==1
replace _rfchol1=1 if _rfchol1==2
replace _rfchol2=0 if _rfchol2==1
replace _rfchol2=1 if _rfchol2==2
replace _rfchol2=. if _rfchol2==9
replace _rfchol3=0 if _rfchol3==1
replace _rfchol3=1 if _rfchol3==2
replace _rfchol3=. if _rfchol3==9
replace _rfchol=0 if (_rfchol1==0 | _rfchol2==0 | _rfchol3==0)
replace _rfchol=1 if (_rfchol1==1 | _rfchol2==1 | _rfchol3==1)
label define _rfchol 0 "No" 1 "Yes"
label values _rfchol _rfchol
tab _rfchol, missing
drop _rfchol1 _rfchol2 _rfchol3


* Q: (Ever told) you had a heart attack, also called a myocardial infarction?
* 1: Yes, 2: No
tab cvdinfr4, missing
replace cvdinfr4=0 if cvdinfr4==2
replace cvdinfr4=. if inlist(cvdinfr4, 7, 9)
label define cvdinfr4 0 "No" 1 "Yes"
label values cvdinfr4 cvdinfr4
tab cvdinfr4, missing


* Q: (Ever told) (you had) angina or coronary heart disease?
* 1: Yes, 2: No
tab cvdcrhd4, missing
replace cvdcrhd4=0 if cvdcrhd4==2
replace cvdcrhd4=. if inlist(cvdcrhd4, 7, 9)
label define cvdcrhd4 0 "No" 1 "Yes"
label values cvdcrhd4 cvdcrhd4
tab cvdcrhd4, missing


* Q: (Ever told) you had a stroke.
* 1: Yes, 2: No
tab cvdstrk3, missing
replace cvdstrk3=0 if cvdstrk3==2
replace cvdstrk3=. if inlist(cvdstrk3, 7, 9)
label define cvdstrk3 0 "No" 1 "Yes"
label values cvdstrk3 cvdstrk3
tab cvdstrk3, missing


* binary variable for combined CVD:
tab1 cvdinfr4 cvdstrk3 cvdcrhd4, missing
gen cvdvar=.
replace cvdvar=0 if (cvdinfr4==0 | cvdcrhd4==0 | cvdstrk3==0)
replace cvdvar=1 if (cvdinfr4==1 | cvdcrhd4==1 | cvdstrk3==1)
label variable cvdvar "Cardiovascular Disease"
label define cvdvar 0 "No" 1 "Yes"
label values cvdvar cvdvar
tab cvdvar, missing

////// cvdasprn and aspirin
////// _michd


* Arthritis:
* 1: Diagnosed with arthritis , 2: Not diagnosed with arthritis
tab1 _drdxar1 _drdxar2 _drdxar3, missing
replace _drdxar1=0 if _drdxar1==2
replace _drdxar2=0 if _drdxar2==2
replace _drdxar3=0 if _drdxar3==2
replace _drdxar1=0 if (_drdxar2==0 | _drdxar3==0)
replace _drdxar1=1 if (_drdxar2==1 | _drdxar3==1)
label define _drdxar1 0 "No" 1 "Yes"
label values _drdxar1 _drdxar1
tab _drdxar1, missing
drop _drdxar2 _drdxar3


* Q: (Ever told) (you had) asthma?
* 1: Yes, 2: No 
tab asthma3, missing
replace asthma3=0 if asthma3==2
replace asthma3=. if inlist(asthma3, 7, 9)
label define asthma3 0 "No" 1 "Yes"
label values asthma3 asthma3
tab asthma3, missing


* Q: Do you still have asthma?
* 1: Yes, 2: No 
tab asthnow, missing
replace asthnow=0 if asthnow==2
replace asthnow=. if inlist(asthnow, 7, 9)
label define asthnow 0 "No" 1 "Yes"
label values asthnow asthnow
tab asthnow, missing


* Asthma Status
* 1: Current, 2: Former, 3: Never
tab _asthms1, missing
replace _asthms1=0 if _asthms1==3
replace _asthms1=. if _asthms1==9
label define _asthms1 0 "Never" 1 "Current" 2 "Former"
label values _asthms1 _asthms1
tab _asthms1, missing


* Q: Do you currently use chewing tobacco, snuff, or snus every day, some days, or not at all?  (Snus (Swedish for snuff) is a moist smokeless tobacco, usually sold in small pouches that are placed under the lip against the gum.)
* 1: Every day, 2: Some days, 3: Not at all
tab usenow3, missing
replace usenow3=0 if usenow3==3
replace usenow3=. if inlist(usenow3, 7, 9)
label define usenow3 0 "Not at all" 1 "Everyday" 2 "Some days"
label values usenow3 usenow3
tab usenow3, missing


* Four-level smoker status:  1: Everyday smoker, 2: Someday smoker, 3: Former smoker, 4: Non-smoker
tab _smoker3, missing
replace _smoker3=. if _smoker3==9
replace _smoker3=0 if _smoker3==4
label define _smoker3 0 "Never Smoked" 1 "Everyday Smoker" 2 "Someday Smoker" 3 "Former Smoker" 
label values _smoker3 _smoker3
tab _smoker3, missing


* Adults who are current smokers
* 1: No, 2: Yes 
tab _rfsmok3, missing
replace _rfsmok3=0 if _rfsmok3==1
replace _rfsmok3=1 if _rfsmok3==2
replace _rfsmok3=. if _rfsmok3==9
label define _rfsmok3 0 "No" 1 "Yes"
label values _rfsmok3 _rfsmok3
tab _rfsmok3, missing


* Adults who reported having had at least one drink of alcohol in the past 30 days.
* 1: yes, 2: no
tab1 drnkany5 drnkany6, missing
replace drnkany5=0 if drnkany5==2
replace drnkany5=. if inlist(drnkany5, 7, 9)
replace drnkany6=0 if drnkany6==2
replace drnkany6=. if inlist(drnkany6, 7, 9)
replace drnkany5=0 if drnkany6==0
replace drnkany5=1 if drnkany6==1
label variable drnkany5 "Drink Any Alcoholic Beverage in the Past 30 days"
label define drnkany5 0 "No" 1 "Yes"
label values drnkany5 drnkany5
tab drnkany5, missing
drop drnkany6


* Heavy drinkers (adult men having more than 14 drinks per week and adult women having more than 7 drinks per week)
* 1: no, 2: yes
tab1 _rfdrhv4 _rfdrhv5 _rfdrhv6 _rfdrhv7 _rfdrhv8, missing
replace _rfdrhv4=0 if _rfdrhv4==1
replace _rfdrhv4=1 if _rfdrhv4==2
replace _rfdrhv4=. if _rfdrhv4==9
replace _rfdrhv5=0 if _rfdrhv5==1
replace _rfdrhv5=1 if _rfdrhv5==2
replace _rfdrhv5=. if _rfdrhv5==9
replace _rfdrhv6=0 if _rfdrhv6==1
replace _rfdrhv6=1 if _rfdrhv6==2
replace _rfdrhv6=. if _rfdrhv6==9
replace _rfdrhv7=0 if _rfdrhv7==1
replace _rfdrhv7=1 if _rfdrhv7==2
replace _rfdrhv7=. if _rfdrhv7==9
replace _rfdrhv8=0 if _rfdrhv8==1
replace _rfdrhv8=1 if _rfdrhv8==2
replace _rfdrhv8=. if _rfdrhv8==9
replace _rfdrhv4=0 if (_rfdrhv5 == 0 | _rfdrhv6 == 0 | _rfdrhv7 == 0 | _rfdrhv8 == 0)
replace _rfdrhv4=1 if (_rfdrhv5 == 1 | _rfdrhv6 == 1 | _rfdrhv7 == 1 | _rfdrhv8 == 1)
label define _rfdrhv4 0 "No" 1 "Yes"
label values _rfdrhv4 _rfdrhv4
tab _rfdrhv4, missing
drop _rfdrhv5 _rfdrhv6 _rfdrhv7 _rfdrhv8


* Q: During the past 12 months, have you had either flu vaccine that was sprayed in your nose or flu shot injected into your arm?
* 1: yes, 2: no
tab1 flushot5 flushot6 flushot7, missing
replace flushot5=0 if flushot5==2
replace flushot5=. if inlist(flushot5, 7, 9)
replace flushot6=0 if flushot6==2
replace flushot6=. if inlist(flushot6, 7, 9)
replace flushot7=0 if flushot7==2
replace flushot7=. if inlist(flushot7, 7, 9)
replace flushot5=0 if (flushot6==0 | flushot7==0)
replace flushot5=1 if (flushot6==1 | flushot7==1)
label define flushot5 0 "No" 1 "Yes"
label values flushot5 flushot5
tab flushot5, missing
drop flushot6 flushot7


* Q: Have you ever had a pneumonia shot also known as a pneumococcal vaccine?
* 1: yes, 2: no
tab1 pneuvac3 pneuvac4, missing
replace pneuvac3=0 if pneuvac3==2
replace pneuvac3=. if inlist(pneuvac3, 7, 9)
replace pneuvac4=0 if pneuvac4==2
replace pneuvac4=. if inlist(pneuvac4, 7, 9)
replace pneuvac3=0 if pneuvac4==0
replace pneuvac3=1 if pneuvac4==1
label define pneuvac3 0 "No" 1 "Yes"
label values pneuvac3 pneuvac3
tab pneuvac3, missing
drop pneuvac4


* Q: Including fluid testing from your mouth, but not including tests you may have had for blood donation, have you ever been tested for H.I.V?
* 1: yes, 2: no
tab1 hivtst6 hivtst7, missing
replace hivtst6=0 if hivtst6==2
replace hivtst6=. if inlist(hivtst6, 7, 9)
replace hivtst7=0 if hivtst7==2
replace hivtst7=. if inlist(hivtst7, 7, 9)
replace hivtst6=0 if hivtst7==0
replace hivtst6=1 if hivtst7==1
label define hivtst6 0 "No" 1 "Yes"
label values hivtst6 hivtst6
tab hivtst6, missing
drop hivtst7


* Q: Have you ever had an H.P.V. vaccination?
* 1: yes, 2: no, 3: doctor refused when asked
tab1 hpvadvc2 hpvadvc3 hpvadvc4, missing
replace hpvadvc2=0 if inlist(hpvadvc2, 2, 3)
replace hpvadvc2=. if inlist(hpvadvc2, 7, 9)
replace hpvadvc3=0 if hpvadvc3==2
replace hpvadvc3=. if inlist(hpvadvc3, 7, 9)
replace hpvadvc4=0 if inlist(hpvadvc4, 2, 3)
replace hpvadvc4=. if inlist(hpvadvc4, 7, 9)
replace hpvadvc2=0 if (hpvadvc3==0 | hpvadvc4==0)
replace hpvadvc2=1 if (hpvadvc3==1 | hpvadvc4==1)
label define hpvadvc2 0 "No" 1 "Yes" 
label values hpvadvc2 hpvadvc2
tab hpvadvc2, missing
drop hpvadvc3 hpvadvc4


* Q: Have you ever had the shingles or zoster vaccine?
* 1: yes, 2: no
tab1 shingle1 shingle2, missing
replace shingle1=0 if shingle1==2
replace shingle1=. if inlist(shingle1, 7, 9)
replace shingle2=0 if shingle2==2
replace shingle2=. if inlist(shingle2, 7, 9)
replace shingle1=0 if shingle2==0
replace shingle1=1 if shingle2==1
label define shingle1 0 "No" 1 "Yes"
label values shingle1 shingle1
tab shingle1, missing
drop shingle2


* Adults aged 65+ who have had a flu shot within the past year
* 1: yes, 2: no
tab1 _flshot5 _flshot6 _flshot7, missing
replace _flshot5=0 if _flshot5==2
replace _flshot5=. if _flshot5==9
replace _flshot6=0 if _flshot6==2
replace _flshot6=. if _flshot6==9
replace _flshot7=0 if _flshot7==2
replace _flshot7=. if _flshot7==9
replace _flshot5=0 if (_flshot6==0 | _flshot7==0)
replace _flshot5=1 if (_flshot6==1 | _flshot7==1)
label variable _flshot5 "Flu Shot 65+ Calculated Variable"
label define _flshot5 0 "No" 1 "Yes"
label values _flshot5 _flshot5
tab _flshot5, missing
drop _flshot6 _flshot7


* Adults aged 65+ who have ever had a pneumonia vaccination
* 1: yes, 2: no
tab1 _pneumo2 _pneumo3, missing
replace _pneumo2=0 if _pneumo2==2
replace _pneumo2=. if _pneumo2==9
replace _pneumo3=0 if _pneumo3==2
replace _pneumo3=. if _pneumo3==9
replace _pneumo2=0 if _pneumo3==0
replace _pneumo2=1 if _pneumo3==1
label variable _pneumo2 "Pneumonia Vaccination 65+ Calculated Variable"
label define _pneumo2 0 "No" 1 "Yes"
label values _pneumo2 _pneumo2
tab _pneumo2, missing
drop _pneumo3


* Adults who have ever been tested for HIV
* 1: yes, 2: no
* compare this with hivtest, update: they are the same!
tab1 _aidtst3 _aidtst4, missing
replace _aidtst3=0 if _aidtst3==2
replace _aidtst3=. if _aidtst3==9
replace _aidtst4=0 if _aidtst4==2
replace _aidtst4=. if _aidtst4==9
replace _aidtst3=0 if _aidtst4==0
replace _aidtst3=1 if _aidtst4==1
label define _aidtst3 0 "No" 1 "Yes"
label values _aidtst3 _aidtst3
tab _aidtst3, missing
drop _aidtst4


* Have you ever had a mammogram?
* 1: yes, 2: no
tab hadmam, missing
replace hadmam=0 if hadmam==2
replace hadmam=. if inlist(hadmam, 7, 9)
label define hadmam 0 "No" 1 "Yes"
label values hadmam hadmam
tab hadmam, missing


* Q: How long has it been since you had your last mammogram?
* 1: Within the past year, 2: Within the past 2 years, 3: Within the past 3 years, 4: Within the past 5 years, 5: 5 or more years ago
tab howlong, missing
replace howlong=. if inlist(howlong, 7, 9)
label define howlong 1 "within the past year" 2 "within the past 2 years" 3 "within the past 3 years" 4 "within the past 5 years" 5 "5 or more years ago"
label values howlong howlong
tab howlong, missing


* Q: Have you ever had a Pap test?
* 1: yes, 2: no
tab1 hadpap2 crvclpap, missing
replace hadpap2=0 if hadpap2==2
replace hadpap2=. if inlist(hadpap2, 7, 9)
replace crvclpap=0 if crvclpap==2
replace crvclpap=. if inlist(crvclpap, 7, 9)
replace hadpap2=0 if crvclpap==0
replace hadpap2=1 if crvclpap==1
label define hadpap2 0 "No" 1 "Yes"
label values hadpap2 hadpap2
tab hadpap2, missing
drop crvclpap


* Q: How long has it been since you had your last Pap test?
* 1: Within the past year, 2: Within the past 2 years, 3: Within the past 3 years, 4: Within the past 5 years, 5: 5 or more years ago
tab lastpap2, missing
replace lastpap2=. if inlist(lastpap2, 7, 9)
label define lastpap2 1 "within the past year" 2 "within the past 2 years" 3 "within the past 3 years" 4 "within the past 5 years" 5 "5 or more years ago"
label values lastpap2 lastpap2
tab lastpap2, missing


* Q: A Prostate-Specific Antigen test, also called a PSA test, is a blood test used to check men for prostate cancer. Have you ever had a P.S.A. test?
* 1: yes, 2: no
tab psatest1, missing
replace psatest1=0 if psatest1==2
replace psatest1=. if inlist(psatest1, 7, 9)
label define psatest1 0 "No" 1 "Yes"
label values psatest1 psatest1
tab psatest1, missing


* Q: About how long has it been since your most recent P.S.A. test?
* 1: Within the past year, 2: Within the past 2 years, 3: Within the past 3 years, 4: Within the past 5 years, 5: 5 or more years ago
tab1 psatime psatime1, missing
replace psatime=. if inlist(psatime, 7, 9)
replace psatime1=. if inlist(psatime1, 7, 9)
forval i=1/5 {
	replace psatime=`i' if psatime1==`i'
}
label define psatime 1 "within the past year" 2 "within the past 2 years" 3 "within the past 3 years" 4 "within the past 5 years" 5 "5 or more years ago"
label values psatime psatime
tab psatime, missing
drop psatime1


* Q: Colonoscopy and sigmoidoscopy are exams to check for colon cancer. Have you ever had either of these exams?
* 1: yes, 2: no
* note: for year 2020 instead of hadsigm, two separate variables were introduced: colnscpy & sigmscpy
tab1 hadsigm3 hadsigm4 colnscpy sigmscpy, missing
replace hadsigm3=0 if hadsigm3==2
replace hadsigm3=. if inlist(hadsigm3, 7, 9)
replace hadsigm4=0 if hadsigm4==2
replace hadsigm4=. if inlist(hadsigm4, 7, 9)
replace colnscpy=0 if colnscpy==2
replace colnscpy=. if inlist(colnscpy, 7, 9)
replace sigmscpy=0 if sigmscpy==2
replace sigmscpy=. if inlist(sigmscpy, 7, 9)
replace hadsigm3=0 if hadsigm4==0
replace hadsigm3=0 if (colnscpy==0 & sigmscpy==0)
replace hadsigm3=1 if hadsigm4==1
replace hadsigm3=1 if (colnscpy==1 | sigmscpy==1)
label define hadsigm3 0 "No" 1 "Yes"
label values hadsigm3 hadsigm3
tab hadsigm3, missing
drop hadsigm4 colnscpy sigmscpy

/*
tabulate colnscpy sigmscpy, missing
*/


* Q: How long has it been since you had your last sigmoidoscopy or colonoscopy?
* 1: Within the past year, 2: Within the past 2 years, 3: Within the past 3 years, 4: Within the past 5 years, 5: Within the past 10 years, 6: 10 or more years ago
tab1 lastsig3 lastsig4 colntest sigmtest, missing
replace lastsig3=. if inlist(lastsig3, 7, 9)
replace lastsig4=. if inlist(lastsig4, 7, 9)
replace lastsig4=13 if lastsig4==3
replace lastsig4=14 if lastsig4==4
replace lastsig4=15 if lastsig4==5
replace lastsig4=4 if lastsig4==13
replace lastsig4=5 if lastsig4==14
replace lastsig4=6 if lastsig4==15
replace colntest=. if inlist(colntest, 7, 9)
replace colntest=13 if colntest==3
replace colntest=14 if colntest==4
replace colntest=15 if colntest==5
replace colntest=4 if colntest==13
replace colntest=5 if colntest==14
replace colntest=6 if colntest==15
replace sigmtest=. if inlist(sigmtest, 7, 9)
replace sigmtest=13 if sigmtest==3
replace sigmtest=14 if sigmtest==4
replace sigmtest=15 if sigmtest==5
replace sigmtest=4 if sigmtest==13
replace sigmtest=5 if sigmtest==14
replace sigmtest=6 if sigmtest==15
forval i=1/6 {
	replace lastsig3=`i' if lastsig4==`i'
}
egen temp_min = rowmin(colntest sigmtest)
forval i=1/6 {
	replace lastsig3=`i' if temp_min==`i'
}
drop temp_min
label define lastsig3 1 "within the past year" 2 "within the past 2 years" 3 "within the past 3 years" 4 "within the past 5 years" 5 "within the past 10 years" 6 "10 or more years ago", modify
label values lastsig3 lastsig3
tab lastsig3, missing
drop lastsig4 colntest sigmtest


* Q: (Ever told) (you had) C.O.P.D. (chronic obstructive pulmonary disease), emphysema or chronic bronchitis?
* 1: yes, 2: no
tab1 chccopd chccopd1 chccopd2 chccopd3, missing
replace chccopd=0 if chccopd==2
replace chccopd=. if inlist(chccopd, 7, 9)
replace chccopd1=0 if chccopd1==2
replace chccopd1=. if inlist(chccopd1, 7, 9)
replace chccopd2=0 if chccopd2==2
replace chccopd2=. if inlist(chccopd2, 7, 9)
replace chccopd3=0 if chccopd3==2
replace chccopd3=. if inlist(chccopd3, 7, 9)
replace chccopd=0 if (chccopd1==0 | chccopd2==0 | chccopd3==0)
replace chccopd=1 if (chccopd1==1 | chccopd2==1 | chccopd3==1)
label define chccopd 0 "No" 1 "Yes"
label values chccopd chccopd
tab chccopd, missing
drop chccopd1 chccopd2 chccopd3


* Q: (Ever told) (you had) skin cancer?
* 1: yes, 2: no
tab1 chcscncr chcscnc1, missing
replace chcscncr=0 if chcscncr==2
replace chcscncr=. if inlist(chcscncr, 7, 9)
replace chcscnc1=0 if chcscnc1==2
replace chcscnc1=. if inlist(chcscnc1, 7, 9)
replace chcscncr=0 if chcscnc1==0
replace chcscncr=1 if chcscnc1==1
label define chcscncr 0 "No" 1 "Yes"
label values chcscncr chcscncr
tab chcscncr, missing
drop chcscnc1


* Q: (Ever told) you had any other types of cancer?
* 1: yes, 2: no
tab1 chcocncr chcocnc1, missing
replace chcocncr=0 if chcocncr==2
replace chcocncr=. if inlist(chcocncr, 7, 9)
replace chcocnc1=0 if chcocnc1==2
replace chcocnc1=. if inlist(chcocnc1, 7, 9)
replace chcocncr=0 if chcocnc1==0
replace chcocncr=1 if chcocnc1==1
label define chcocncr 0 "No" 1 "Yes"
label values chcocncr chcocncr
tab chcocncr, missing
drop chcocnc1


* Q: (Ever told) you that you have a depressive disorder, including depression, major depression, dysthymia, or minor depression?
* 1: yes, 2: no
tab1 addepev2 addepev3, missing
replace addepev2=0 if addepev2==2
replace addepev2=. if inlist(addepev2, 7, 9)
replace addepev3=0 if addepev3==2
replace addepev3=. if inlist(addepev3, 7, 9)
replace addepev2=0 if addepev3==0
replace addepev2=1 if addepev3==1
label define addepev2 0 "No" 1 "Yes"
label values addepev2 addepev2
tab addepev2, missing
drop addepev3


* Q: (Ever told) you have kidney disease? Do NOT include kidney stones, bladder infection or incontinence.(Incontinence is not being able to control urine flow.)
* 1: yes, 2: no
tab1 chckidny chckdny1 chckdny2, missing
replace chckidny=0 if chckidny==2
replace chckidny=. if inlist(chckidny, 7, 9)
replace chckdny1=0 if chckdny1==2
replace chckdny1=. if inlist(chckdny1, 7, 9)
replace chckdny2=0 if chckdny2==2
replace chckdny2=. if inlist(chckdny2, 7, 9)
replace chckidny=0 if (chckdny1==0 | chckdny2==0)
replace chckidny=1 if (chckdny1==1 | chckdny2==1)
label define chckidny 0 "No" 1 "Yes"
label values chckidny chckidny
tab chckidny, missing
drop chckdny1 chckdny2


* Create a dummy for Maryland
gen maryland=.
replace maryland=0 if inrange(_state, 1, 56)
replace maryland=1 if _state==24
label variable maryland "Is this Maryland"
label define maryland 0 "Not Maryland" 1 "Maryland"
format maryland %10.0g 
tab maryland, missing


* Contiguous United States: 49 states including District of Columbia (No Hawaii, 15, and Alaska, 2)
gen contig_us=0
replace contig_us=1 if _state!=15 & _state!=2 
label variable contig_us "Contiguous US Control States"
label define contig_us 0 "Hawaii and Alaska" 1 "Contiguous United States" 
label values contig_us contig_us
format contig_us %10.0g 
tab contig_us, missing


* create a period variable that separates periods of 2011-2013, 2014-2018, and 2019-2022 
gen period=0 if inrange(iyear, 2011, 2013) 
replace period=1 if inrange(iyear, 2014, 2018) 
replace period=2 if inrange(iyear, 2019, 2022) 
label variable period "Periods"
label define period 0 "Baseline (2011-2013)" 1 "MDAPM (2014-2018)" 2 "MDTCOC (2019-2022)", replace
label values period period
tab period, missing

save "$mash/BRFSS_Clean_yearfixed.dta"

/*
describe
tab _state genhlth, row missing
tab _state physhlth, row missing
tab _state menthlth, row missing
tab _state poorhlth, row missing
tab _state hlthpln1, row missing
tab _state persdoc2, row missing
tab _state medcost, row missing
tab _state checkup1, row missing
tab _state exerany2, row missing
tab _state _rfhlth, row missing
tab _state _hcvu651, row missing
tab _state _bmi5cat, row missing
tab _state _rfbmi5, row missing
tab _state _totinda, row missing
tab _state employ, row missing
tab _state employment, row missing
tab _state income2, row missing
tab _state sex, row missing
tab _state _race_g, row missing
*/

