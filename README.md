# Stata-tools
Useful programs for statistics in Stata.

####varfreqs
`varfreqs.ado` : creates a summary frequency table for dichotomous variables, separated by the levels of a dichotomous predictor. This summary table is then exported into excel. 
* This table contains:
  * The name of the variable;
  * The label (description) of the variable;
  * The frequency and percent of the variable at each level of the outcome;
  * The frequency and percent of missing observations for that variable.

__Syntax__

  __varfreqs__  _numberofvariables_ _usingdata_ _firstvariable_ _lastvariable_ _outcomevariable_ _exportdata_
  
  where:
  * numberofvariables : Number of dichotomous variables included in the frequency table;
  * usingdata : Data set containing the variables;
  * firstvariable : first variable in the list;
  * lastvariable : last variable in the list;
  * outcomevariable : outcome variable;
  * exportdata : the name of the data files (.dta and .xlsx) the summary table will be exported into.

The data need to be set up:
  * With variable labels on each of the predictors;
  * With value labels on the outcome variable;
  * Ordered so all of the dichotomous variables are together.

Feel free to send me a pull request if you have any suggestions or improvements - I'm new to Github so will welcome any help! 
  
  
