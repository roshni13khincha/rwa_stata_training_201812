/*******************************************************************************
						Basics of Stata
						August, 2018 Rwanda 
						
Notes: This is an example of how to run basic commands and create graphs in Stata 
		using a do file
	   
Authors: Sakina and Roshni 
Last updated : August, 2018
*******************************************************************************/
	
************************************ SET UP ************************************
	clear all

	global data "C:\Users\Sakina\Dropbox\DIME_work\minagri_stata_training_aug2018\data"

*** Opening the dataset

	use "$data\cs_s0_s5_household.dta", clear

*** Keeping required variables
	keep hhid province district ur2012 s5cq2 s5cq4 s5cq8 s5cq15 ///
		 s5cq23 s5bq2 s5cq22 s5cq13 s5cq17 
		 
	drop province s5bq2 s5cq17 s5cq15 // We do not need these variables

*** Renaming variables 
	rename ur2012 	urban_2012
	rename s5cq2 	m_main_ws
	rename s5cq4 	m_used_ws
	rename s5cq8 	m_drink_ws
	rename s5cq13 	earnings_sell_w
	rename s5cq22 	d_affected_dis
	rename s5cq23	dis_type

*** Generating variables
	* A new variable
	generate  cm_main_ws = m_main_ws*100
	
	* Dummy
	generate  d_closest_ws	 = 0
	replace d_closest_ws = 1 if m_main_ws == m_used_ws

*** Labeling variables
	label variable cm_main_ws "Cm to main water source"
	label variable d_closest_ws "Closest water source is used water source" 

	label define yes_no_lb 1 "Yes" 0 "No"
	label values d_closest_ws yes_no_lb

*** Generating more variables
	*gen km_main_ws = m_main_ws/1000
	*label variable km_main_ws "Km to main water source"

*** Saving the modified dataset
	save "$data\cs_s0_s5_household_modified.dta", replace


*** Exporting the modified dataset
	export excel using "$data\cs_s0_s5_household_modified.xls", ///
	replace firstrow(variable)

************************************ GRAPHS ************************************
	* Box plot
	graph box m_drink_ws, over(urban_2012)
	graph save "$data\box_plot.gph", replace
	
	* Histogram
	histogram m_drink_ws
	
	* Histogram with title
	histogram m_drink_ws, ///
	title("Distribution of the Distance to Drinking Water (metres)")
	graph save "$data\histogram.gph", replace
	
	histogram m_drink_ws, by(urban_2012)

	graph hbar d_closest_ws , over(urban_2012) ///
		title("Closet water source is the main source") ///
		ylabel(0 "0%" .25 "25%" .5 "50%" .75 "75%" 1 "100%") ///
		ytitle("Proportion of households whose main water source is the closest source", size(small))
	graph save "$data\bar_graph.gph", replace

	scatter m_used_ws m_drink_ws  || ///
	lfit m_used_ws m_drink_ws , ///
		ytitle("Distance to the nearest drinking water source") ///
		xtitle("Distance to the main drinking source used") ///
		title("Is the main drinking water source also the closest one?")
	graph save "$data\scatter.gph", replace
	
	graph combine "$data\box_plot.gph" ///
				  "$data\histogram.gph" ///
				  "$data\bar_graph.gph" ///
				  "$data\scatter.gph"
	graph export "$data\combined_graph.png", replace
	
