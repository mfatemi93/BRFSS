cap log close _all
clear 
set more off


********************************************************************
*Define Directories												

global mash "/Users/maryamfatemi/Graduate Center Dropbox/Maryam Alsadat Fatemi/BRFSS/Dofiles/Maryam"
global data "/Users/maryamfatemi/Graduate Center Dropbox/Maryam Alsadat Fatemi/BRFSS/Data/SVI data"
cd "$mash"


****** Finding Synthetic Control States using SVI ******
/* Identify the SVI index of each states, have a interval where Maryland is the midpoint. */

/*import delimited "$mash/SVI data/SVI_2010_US_county.csv", clear 
save "$mash/SVI data/2010.dta"

gen year = 1
label variable year "Year"
label define year 1 "2010"
label values year year
format year %10.0g 
tab year, missing*/

* Set up the file paths and year information
local years 2010 2014 2016 2018 2020 2022


** First, create a loop to import csv files for each year and convert them to dta files and saved
** Second, for each year create a column name "Year" for consistency to append later
** Third, in order to append when the "Year" column is created for the first year (2010) save it in a separate dataset (master) and then append remaining to that

* Loop through each year
foreach year of local years {
    * Import the CSV for the current year
    import delimited "$mash/SVI data/SVI_`year'_US_county.csv", clear

    * Save the data as a .dta file for the current year
    save "$mash/SVI data/`year'.dta", replace

    * If this is the first year, create a master dataset
    if "`year'" == "2010" {
        gen year = `year'
        label variable year "Year"
        label define year_label `year' "`year'", add
        label values year year_label
        format year %10.0g
		rename st st_abbr //recode for consistency
		rename state st
        save "$mash/SVI data/master.dta", replace
} 
	else {
        * For subsequent years, process and append to master dataset
        use "$mash/SVI data/`year'.dta", clear
        gen year = `year'
        label variable year "Year"
        label define year_label `year' "`year'", add
        label values year year_label
        format year %10.0g
        append using "$mash/SVI data/master.dta"
        save "$mash/SVI data/master.dta", replace
		compress
    }
}


* Verify the combined dataset
use "$mash/SVI data/master.dta", clear
tab year, missing
tab1 st st_abbr


** The overall tract summary ranking variable is rpl_themes
** spl_themes = spl_theme1 + spl_theme2 + spl_theme3 + spl_theme4
** spl_theme1 : sum of series for socioeconomic theme
** spl_theme2 : sum of series for household composition theme
** spl_theme3 : sum of series for minority status / language theme
** spl_theme4 : sum of series for housing / transportation theme

** rpl_themes is not consistent over years (for 2010 it is r_pl_themes)
** spl_themes is not consistent over years (for 2010 it is r_pl_themes)

tab rpl_themes if year==2010 // no observations
tab r_pl_themes if year==2010 

tab spl_themes if year==2010 // no observations
tab s_pl_themes if year==2010

*recoding for consistency across years
replace rpl_themes = r_pl_themes if missing(rpl_themes)
replace spl_themes = s_pl_themes if missing(spl_themes)

sum rpl_themes spl_themes

count if rpl_themes==-999 // 2 observations
count if spl_themes==-999 // 2 observations

replace rpl_themes=. if rpl_themes==-999 
replace spl_themes=. if spl_themes==-999


** get the total population of each state in each year
egen total_population = total(e_totpop), by(st year)


** get the weighted average of rpl_themes
** First, calculate the proportion of each county's population to the state's total population
gen county_weight = e_totpop / total_population

** Second, multiply the weight by rpl_themes
gen weighted_rpl_themes = county_weight * rpl_themes

** Third, compute the weighted average for each state and year
egen state_weighted_avg_rpl_themes = total(weighted_rpl_themes), by(st year)

****** Aggreagating counties' SVI into states ******

list st_abbr rpl_themes if missing(rpl_themes)

* Aggregate data to state level
collapse (mean) state_weighted_avg_rpl_themes, by(st_abbr)

* Rank the aggregated data
sort state_weighted_avg_rpl_themes st_abbr
list state_weighted_avg_rpl_themes st_abbr


summarize state_weighted_avg_rpl_themes, detail


** Generate quartile categories
xtile quartile = state_weighted_avg_rpl_themes, nq(4)

** Tabulate the quartile categories
tabulate quartile

** Looks like MD is on the second quartile with social vulnerability ranking at ~.4138809

** Other states on the second quartile (13 total with MD) :

/*

st_abbr	| state_weighted_avg_rpl_themes	| quartile
CO	    |           .3842481	        |    2
KS	    |           .3990953	        |    2
ID	    |           .412228 	        |    2
MD	    |           .4138809	        |    2
PA	    |           .4142963	        |    2
MA	    |           .4229525	        |    2
MO	    |           .4319905	        |    2
OH	    |           .4533482	        |    2
WA	    |           .4535505	        |    2
WV	    |           .4660388	        |    2
MI	    |           .4718468	        |    2
CT	    |           .4734058	        |    2
IN	    |           .4758238	        |    2

*/
 
gen selected = inlist(st_abbr, "CO", "KS", "ID", "PA", "MA", "MO", "OH") | ///
                 inlist(st_abbr, "WA", "WV", "MI", "CT", "IN")

** the average of these 12 states is .4382354 
summarize state_weighted_avg_rpl_themes if selected == 1 

save "$mash/SVI data/state_level_SVI.dta", replace
compress


