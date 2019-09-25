/**************************************************************************************************************************************************/
/************************************************************ Trend Analysis **********************************************************************/
/**************************************************************************************************************************************************/

/** Input: <Raw Dataset Name> **/

%let dataset = dataset; /* need to specify if using macro that needs &dataset */
%let rawdataset = raw_dataset; /* need to specify if using macro that needs &rawdataset */

proc import out=&rawdataset datafile="C:\Users\dschreiber-gregory\Desktop\Complete Projects [NOT PUBLIC]\[2019.01] Publication Timelines (Maggio)\[2019.02.04] Quantitative Analysis\Publication Timeline Complete.xlsx"  
dbms=xlsx replace;
sheet='Publication Timeline Complete';
getnames=yes;
run;

ods graphics on;

data &rawdataset;
	set &rawdataset;

	if DP=2019 then delete;
	if DP=2007 then delete;
	if DP='Summer' then delete;
	if DP='Spring' then delete;
	if DP>2007 then Year2 = DP*1;
		else Year2 = .;

	label Year2 = 'Publication Year';
	label DP = 'Publication Year';
	label JT = 'Journal';
	label Days_Received_To_Accepted = 'Acceptance Time';
	label Days_Accepted_To_Pubmed = 'Processing Time';
	label Days_Received_To_Pubmed = 'Publication Time';

run;

/* Need to transpose dataset for replication - Reference:(https://github.com/dhimmel/delays/blob/history-blog-post/visualize-history.ipynb) */


/* Acceptance Delay Preparation */

data Round1_data;
	set &rawdataset (rename=(	Days_Received_To_Accepted 	= Days ));

	if missing(Days) then delete;

	length Delay_Type $32.;
		Delay_Type = "Acceptance Time";
run;

proc sort data=Round1_data;
	by Delay_Type Year2;
run;

proc means data=Round1_data;
	var Days;
	by Delay_Type Year2;
	output out=Round1_stats n=_N min=_MIN max=_MAX mean=_MEAN std=_STD median=_MEDIAN q1=_Q1 q3=_Q3;
run;

data Round1;
	merge Round1_data Round1_stats;
	by Delay_Type Year2;

	retain _N _MIN _MAX _MEAN _STD _MEDIAN _Q1 _Q3;
run;
	
/* Publication Delay Preparation */

data Round2_data;
	set &rawdataset (rename=(	Days_Received_To_Pubmed 	= Days ));

	if missing(Days) then delete;

	length Delay_Type $32.;
		Delay_Type = "Publication Time";
run;

proc sort data=Round2_data;
	by Delay_Type Year2;
run;

proc means data=Round2_data;
	var Days;
	by Delay_Type Year2;
	output out=Round2_stats n=_N min=_MIN max=_MAX mean=_MEAN std=_STD median=_MEDIAN q1=_Q1 q3=_Q3;
run;

data Round2;
	merge Round2_data Round2_stats;
	by Delay_Type Year2;

	retain _N _MIN _MAX _MEAN _STD _MEDIAN _Q1 _Q3;
run;

data Round3_data;
	set &rawdataset (rename=(	Days_Accepted_To_Pubmed		= Days ));

	if missing(Days) then delete;

	length Delay_Type $32.;
		Delay_Type = "Processing Time";
run;

proc sort data=Round3_data;
	by Delay_Type Year2;
run;

proc means data=Round3_data;
	var Days;
	by Delay_Type Year2;
	output out=Round3_stats n=_N min=_MIN max=_MAX mean=_MEAN std=_STD median=_MEDIAN q1=_Q1 q3=_Q3;
run;

data Round3;
	merge Round3_data Round3_stats;
	by Delay_Type Year2;

	retain _N _MIN _MAX _MEAN _STD _MEDIAN _Q1 _Q3;
run;

data Transposed;
	set Round1 Round2 Round3;
run;

data Transposed;
	set Transposed (rename=( _N 		= N
							 _MIN		= MIN
							 _MAX		= MAX
							 _MEAN		= MEAN
							 _STD		= STD
							 _MEDIAN	= MEDIAN
							 _Q1		= Q1
							 _Q3		= Q3 ));
run;

/* Final Graph Dataset */

data Transposed_Round2;
	set Transposed (rename=(	MIN 	= Time_Delay ));

	length Statistic $10.;
		Statistic = "MIN";

	drop N MIN MAX MEAN STD MEDIAN Q1 Q3;
run;

data Transposed_Round3;
	set Transposed (rename=(	MAX 	= Time_Delay ));

	length Statistic $10.;
		Statistic = "MAX";

	drop N MIN MAX MEAN STD MEDIAN Q1 Q3;
run;

data Transposed_Round4;
	set Transposed (rename=(	MEAN 	= Time_Delay ));

	length Statistic $10.;
		Statistic = "MEAN";

	drop N MIN MAX MEAN STD MEDIAN Q1 Q3;
run;

data Transposed_Round5;
	set Transposed (rename=(	MEDIAN 	= Time_Delay ));

	length Statistic $10.;
		Statistic = "MEDIAN";

	drop N MIN MAX MEAN STD MEDIAN Q1 Q3;
run;

data Transposed_Round6;
	set Transposed (rename=(	Q1 	= Time_Delay ));

	length Statistic $10.;
		Statistic = "Q1";

	drop N MIN MAX MEAN STD MEDIAN Q1 Q3;
run;

data Transposed_Round7;
	set Transposed (rename=(	Q3 	= Time_Delay ));

	length Statistic $10.;
		Statistic = "Q3";

	drop N MIN MAX MEAN STD MEDIAN Q1 Q3;
run;

data Final;
	set Transposed_Round2 Transposed_Round3
		Transposed_Round4 Transposed_Round5 Transposed_Round6
		Transposed_Round7;
	
	label Time_Delay='Time Delay';
	label Delay_Type='Delay Type ';

run;

/**************************************************************************************************************************************************/
/************************************************************ Dataset Set-up **********************************************************************/
/**************************************************************************************************************************************************/

proc export data=Final
  dbms=xlsx 
  outfile="C:\Users\dschreiber-gregory\Desktop\Complete Projects [NOT PUBLIC]\[2019.01] Publication Timelines (Maggio)\[2019.02.04] Quantitative Analysis\Publication Timeline Trend.xlsx" 
  replace;
run;

proc sort data=Final;
	by Delay_Type Statistic Year2;
run;

ods pdf file='C:\Users\dschreiber-gregory\Desktop\Publication Timeline Trend Results &fname';

proc sgplot data=Final;
	by Delay_Type;
	styleattrs datacontrastcolors=(black) datasymbols=(circle circlefilled star starfilled triangle trianglefilled square squarefilled);
	vline Year2 / response=Time_Delay markers stat=mean group=Statistic markerattrs=(color=black);
run;

ods pdf close;
