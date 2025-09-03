## Data Source
Data is sourced from the CDC's BRFSS[](https://www.cdc.gov/brfss/annual_data/annual_data.htm).


## BRFSS Data Description


## Overview
This repository contains Stata code and datasets for analyzing data from the CDC's Behavioral Risk Factor Surveillance System (BRFSS).


## Data Source

The raw data in this repository is sourced from the Centers for Disease Control and Prevention (CDC) Behavioral Risk Factor Surveillance System (BRFSS). For more details, visit the BRFSS Annual Data page (https://www.cdc.gov/brfss/annual_data/annual_data.htm). Please cite the CDC when using this data.


## Data Coverage

The dataset spans survey years 2011 to 2022, comprising responses collected annually from the BRFSS.


## Data Adjustment
To ensure consistency in the year variable after appending datasets, adjustments were made to account for interviews conducted in the first quarter of the following year. For example, responses collected in January, February, or March of 2012 for the 2011 dataset are reassigned to the 2011 survey year. This adjustment aligns all observations with the year in which their information was collected. Note that the month variable is not used in this study and is not considered critical for the analyses.


## Contents
- `/scripts`: Stata `.do` files for data processing and analysis.
- `/data`: BRFSS `.dta` files or other datasets.
- `/docs`: Additional documentation or outputs (e.g., `.log` files).


## Contact
For questions, contact mfatemi@gradcenter.cuny.edu or open an issue on GitHub.
