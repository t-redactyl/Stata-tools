	program		define varfreqs
	
		args		num_variables using_data first_variable last_variable outcome_variable  ///
					export_data
	
		clear
		set			obs `num_variables'
		gen			str varname = " "
		gen			str descrip = " "
		gen			outcome0 = .
		gen			perc_outcome0 = .
		gen			outcome1 = .
		gen			perc_outcome1 = .
		gen			missing = .
		gen			perc_missing = .
		
		save		`export_data', replace
		
		global		counter = 1
		
		use			`using_data', clear
		levelsof 	`outcome_variable', local(level)
		local 		lbe: value label `outcome_variable'
		local		lab0 : label `lbe' 0
		local		lab0 = strlower("`lab0'")
		local		lab1 : label `lbe' 1
		local		lab1 = strlower("`lab1'")
		
		quietly		inspect `outcome_variable'
		local		noutcome0 = `r(N_0)'
		local		noutcome1 = `r(N_pos)'
		local		nsample = `r(N)'
		
		foreach		i of varlist `first_variable'-`last_variable' {
						 
						 use		`using_data', clear
						 local 		vlab : variable label `i'
						 quietly	inspect `i' if `outcome_variable' == 0
						 local		outcome0 = `r(N_pos)'
						 quietly	inspect `i' if `outcome_variable' == 1
						 local		outcome1 = `r(N_pos)'
						 quietly 	misstable summarize `i'
						 local		missing = `r(N_eq_dot)'
						 
						 use		`export_data', clear
						 quietly	replace	varname = "`i'" in $counter
						 quietly 	replace	descrip = "`vlab'" in $counter
						 quietly	replace	outcome0 = `outcome0' in $counter
						 quietly	replace	outcome1 = `outcome1' in $counter
						 quietly	replace	missing = `missing' in $counter
						 quietly	save `export_data', replace
						 global		counter = $counter + 1
						 
					}
		
		replace		perc_outcome0 = outcome0 / `noutcome0'
		replace		perc_outcome1 = outcome1 / `noutcome1'
		replace		perc_missing = missing / `nsample'
		
		la			var varname "Variable name"
		la			var descrip "Variable description"
		la			var outcome0 "n `lab0'"
		la			var perc_outcome0 "% `lab0'"
		la			var outcome1 "n `lab1'"
		la			var perc_outcome1 "% `lab0'"
		la			var missing "n missing"
		la			var perc_missing "% missing"
		
		save 		`export_data', replace
			
		export		excel "`export_data'.xlsx", firstrow(varlabels)	
	
	end

				
				
				
				
				
				
				
