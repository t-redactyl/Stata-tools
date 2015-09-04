capture program drop model_decision
program model_decision
	args outcome
	
	xtmixed `outcome' time i.group || subj: , var mle 
	
	di _newline(1)
	di "Step 1: Evaluate initial model." _newline(2) ///
	   "Look at the bottom of the output where it reads: 'LR test vs. linear regression...Prob >= chibar2 ='" _newline(1) ///
	   "Does 'Prob >= chibar2' have a value of < .05? " _newline(2) /// 
	   "Enter a value below in the 'command' window (y/n)" _request(_answer1)
	
	if ("`answer1'" == "y") {
		
		xtmixed `outcome' time time_sq i.group || subj: , var mle
		
		di _newline(2) ///
		   "Step 2: Now look at the row of the first table labelled 'time_sq'." _newline(1) ///
		   "Is this variable significant? "  _newline(2) ///
		   "Enter a value below in the 'command' window (y/n)" _request(_answer2)
		di _newline(2)
		
		}
	else if ("`answer1'" == "n") {
		
		regress `outcome' time time_sq i.group, vce(cluster subj)
		
		di _newline(2) ///   
		   "Step 2: Now look at the row of the table labelled 'time_sq'." _newline(1) ///
		   "Is this variable significant? " _newline(2) ///
		   "Enter a value below in the 'command' window (y/n)" _request(_answer3)
		di _newline(2)
		
		}
	
	if ("`answer2'" == "y") {
		di _newline(2) ///
		   "The final model for `outcome' is below. " ///
		   "This is a random-intercepts multilevel model with a quadratic term."
		di _newline(1)
		
		xtmixed `outcome' time time_sq i.group || subj: , var mle
		
		}
	else if ("`answer2'" == "n") {
		di _newline(2) ///
		   "The final model for `outcome' is below. " ///
		   "This is a random-intercepts multilevel model."
		di _newline(1)
		xtmixed `outcome' time i.group || subj: , var mle
		}
	
	if ("`answer3'" == "y") {
		di _newline(2) ///
		   "The final model for `outcome' is below. " ///
		   "This is a linear regression with a quadratic term which has robust standard errors clustered by ID."
		di _newline(1)
		
		regress `outcome' time time_sq i.group, vce(cluster subj)
		}
	else if ("`answer3'" == "n") {
		di _newline(2) ///
		   "The final model for `outcome' is below. " ///
		   "This is a linear regression which has robust standard errors clustered by ID."
		di _newline(1)
		
		regress `outcome' time time_sq i.group, vce(cluster subj)
		}
end
