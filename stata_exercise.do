
	*********************************************************
	**** MINAGRI - World Bank, DIME Team, Stata workshop ****
	****												 ****	
	****					Aug. 2018					 ****
	*********************************************************


	/* This do-File saves the variables of interest from the Credit Data Set
	and also reshapes the data into the wide format, so that hhid is a
	unique identifier */
	
	
	**** File path - Change this to your file path
	global traning_path "C:\Users\WB519128\Dropbox\Work\WB\Mission - Rwanda Feeder Roads\Stata Training"

	**** Load data
	use "$traning_path/Data/cs_s0_s5_household.dta", clear

	**** Keep only the useful variables
	keep hhid province district ur2012 s5cq2 s5cq4 s5cq8 s5cq15 s5cq23 s5bq2 s5cq22 s5cq13 s5cq17
	
	**** Drop some of them (let's say you kept them by mistake)
	drop province s5bq2 s5cq17 s5cq15
	
	
	**** Rename variables to something usefull
	rename ur2012 	urban_2012
	rename s5cq2 	m_main_ws
	rename s5cq4 	m_used_ws
	rename s5cq8 	m_drink_ws
	rename s5cq13 	earnings_sell_w
	rename s5cq22 	d_affected_dis
	rename s5cq23	dis_type
	
	* Create Km to water source
	gen  	km_main_ws = m_main_ws/1000
	sum 	km_main_ws
	
	**** Create dummie if they're not using the closest water source
	gen 	d_closest_ws = 0
	replace d_closest_ws = 1 if m_main_ws == m_used_ws
	tab 	d_closest_ws

	**** Label variables
	label variable km_main_ws 	"Km to main water source"
	label variable d_closest_ws "Closest water source is used water source"
	
	**** Label values
	label define yes_no_lb 1 "Yes" 0 "No"
	label values d_closest_ws yes_no_lb
	
	tab d_closest // check the labels
	
	**** Save processed data
	save "$traning_path\Data\EICV_practice_data_final.dta", replace 

	
	**** Export Graph
	
	graph box m_drink_ws, over(urban_2012)
	graph save Graph "$traning_path\Graph1.gph", replace

	
	
	
	
	
	
