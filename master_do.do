/*******************************************************************************
							Master Dofile
					Stata Workshop for govn't officials
						August, 2018 Rwanda 
						
Notes: This master do file writes a tex file that creates a presentation for 
	   the stata workshop for government officials.
	   
	   The final product is stata_workshop_for_govt_officials.pdf.
	   
Authors: Roshni and Sakina
Last updated : July, 2018
*******************************************************************************/
	
	clear

	* User identification
	if "`c(username)'" == "Sakina" {
		*global dropbox	"C:\DB Mount\Dropbox\DIME_work"
		global dropbox "C:\Users\Sakina\Dropbox\DIME_work"
		global github	"C:\Users\Sakina\Documents\GitHub"
		}
		
	if "`c(username)'" == "WB506744" {
		global dropbox	"C:\Users\WB506744\Dropbox\DIME_work"
		global github	"C:\Users\WB506744\Documents\GitHub"
		}
		
	if "`c(username)'" == "roshn" {
		global dropbox	"C:\Users\roshn\Dropbox"
		global github	"C:\Users\roshn\Documents\GitHub"
		}
		
		
	if "`c(username)'" == "WB528092" {
		global dropbox	"C:\Users\WB528092\Dropbox"
		global github	"C:\Users\WB528092\Documents\GitHub"
		}
		
		
	* file path
	global data "$dropbox\minagri_stata_training_aug2018\data"
	global script "$github\stata_training_govt_officials"
	
	* packages
	global install		0 // Turn to 1 here if you want to install
	if $install == 1 {
		ssc install texdoc, replace
		net from http://www.stata-journal.com/production
		net install sjlatex, replace
		}
	
	* If latex gives you lemons about stata.sty, turn this on.
	global lemons		0
	if $lemons == 1 {
		copy http://www.stata-journal.com/production/sjlatex/stata.sty stata.sty	
		}
		
	* write the tex file
	texdoc do "$script\stata_workshop_for_govt_officials.do"
	
	* run the tex file
	shell pdflatex "$script\stata_workshop_for_govt_officials.tex"
