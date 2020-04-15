/**************************************************************************************************************************************************/
/************************************************************ Dataset Analyses ********************************************************************/
/**************************************************************************************************************************************************/

/** Input: <Raw Dataset Name> **/

%let dataset = dataset; /* need to specify if using macro that needs &dataset */
%let rawdataset = raw_dataset; /* need to specify if using macro that needs &rawdataset */

proc import out=&rawdataset datafile="C:\Users\dschreiber-gregory\Desktop\Complete Projects [NOT PUBLIC]\[2019.01] Publication Timelines (Maggio)\[2019.02.04] Quantitative Analysis\Publication Timeline Complete.xlsx"  
dbms=xlsx replace;
sheet='Publication Timeline Complete';
getnames=yes;
run;

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

proc freq data=&rawdataset;
	tables  PT_Adaptive PT_Autobiography PT_Bibliography PT_Biography PT_Case_Reports PT_Classical_Article PT_Clinical_Conference 
			PT_Clinical_Study PT_Clinical_Trial PT_Phase_I PT_Phase_II PT_Phase_III PT_Phase_IV PT_Collected_Works PT_Comparative_Study 
			PT_Congresses  PT_Consensus_NIH PT_Consensus  PT_Controlled_Trial  PT_Dataset  PT_Dictionary  PT_Duplicate_Publication  
			PT_Editorial  PT_English_Abstract PT_Equivalence_Trial  PT_Evaluation_Studies  PT_Expression_Concern PT_Festschrift  
			PT_Government_Publications  PT_Guideline  PT_Historical_Article  PT_Interactive_Tutorial  PT_Interview  PT_Introductory  
			PT_Lectures  PT_Legal_Cases  PT_Legislation  PT_Letter  PT_MetaAnalysis PT_MultiCenter_Study  PT_News  PT_Newspaper PT_Observational  
			PT_Overall PT_Patient PT_Periodical_Index  PT_Narratives  PT_Portraits PT_Practice_Guideline  PT_Pragmatic_Trial PT_Publication_Component  
			PT_Publication_Format  PT_Publication_Category  PT_Randomized_Trial  PT_Support_ARRA PT_Support_NIH_Extra PT_Support_NIH_Intra  
			PT_Support_Govt_Non PT_Support_Govt_NonPHS  PT_Support_Govt_PHS PT_Review PT_Scientific_Review  PT_Study_Char PT_Support_Research 
			PT_Technical_Report PT_Twin_Study PT_Validation_Studies  PT_Media_Video  PT_Media_Webcast  PT_Journal_Article;
run;

%let fname = %sysfunc(today(),yymmdd7.);
%put fname= &fname;

ods pdf file='C:\Users\dschreiber-gregory\Desktop\Publication Timeline Results &fname';

proc freq data=&rawdataset;
	tables  PT_Autobiography PT_Bibliography PT_Biography PT_Case_Reports PT_Classical_Article PT_Clinical_Trial PT_Comparative_Study PT_Congresses  
			PT_Consensus  PT_Dictionary  PT_Editorial  PT_Evaluation_Studies  PT_Guideline  PT_Historical_Article  PT_Introductory  PT_Legal_Cases  
			PT_Letter  PT_MetaAnalysis PT_MultiCenter_Study  PT_News PT_Observational  PT_Overall  PT_Narratives  PT_Portraits  PT_Randomized_Trial  
			PT_Support_ARRA PT_Support_NIH_Extra PT_Support_NIH_Intra  PT_Support_Govt_Non PT_Support_Govt_NonPHS  PT_Support_Govt_PHS  PT_Review  
			PT_Validation_Studies  PT_Journal_Article COI_YN Support NIH_Support Govt_Support Govt_NIH_Support STAT DP PST PL JT Year Number_Revisions;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
run;

proc sort data=&rawdataset;
	by PT_Autobiography;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by PT_Autobiography;
run;

proc sort data=&rawdataset;
	by PT_Bibliography;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Bibliography;
run;

proc sort data=&rawdataset;
	by PT_Biography;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Biography;
run;

proc sort data=&rawdataset;
	by PT_Case_Reports;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Case_Reports;
run;

proc sort data=&rawdataset;
	by PT_Classical_Article;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Classical_Article;
run;

proc sort data=&rawdataset;
	by PT_Clinical_Trial;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Clinical_Trial;
run;

proc sort data=&rawdataset;
	by PT_Comparative_Study;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Comparative_Study;
run;

proc sort data=&rawdataset;
	by PT_Congresses;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Congresses;
run;

proc sort data=&rawdataset;
	by PT_Consensus;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Consensus;
run;

proc sort data=&rawdataset;
	by PT_Dictionary;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Dictionary;
run;

proc sort data=&rawdataset;
	by PT_Editorial;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Editorial;
run;

proc sort data=&rawdataset;
	by PT_Evaluation_Studies;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Evaluation_Studies;
run;

proc sort data=&rawdataset;
	by PT_Guideline;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Guideline;
run;

proc sort data=&rawdataset;
	by PT_Historical_Article;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Historical_Article;
run;

proc sort data=&rawdataset;
	by PT_Introductory;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Introductory;
run;

proc sort data=&rawdataset;
	by PT_Legal_Cases;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Legal_Cases;
run;

proc sort data=&rawdataset;
	by PT_Letter;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Letter;
run;

proc sort data=&rawdataset;
	by PT_MetaAnalysis;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_MetaAnalysis;
run;

proc sort data=&rawdataset;
	by PT_MultiCenter_Study;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_MultiCenter_Study;
run;

proc sort data=&rawdataset;
	by PT_News;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_News;
run;

proc sort data=&rawdataset;
	by PT_Observational;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Observational;
run;

proc sort data=&rawdataset;
	by PT_Overall;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Overall;
run;

proc sort data=&rawdataset;
	by PT_Narratives;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Narratives;
run;

proc sort data=&rawdataset;
	by PT_Portraits;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Portraits;
run;

proc sort data=&rawdataset;
	by PT_Randomized_Trial;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Randomized_Trial;
run;

proc sort data=&rawdataset;
	by PT_Support_ARRA;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Support_ARRA;
run;

proc sort data=&rawdataset;
	by PT_Support_NIH_Extra;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Support_NIH_Extra;
run;

proc sort data=&rawdataset;
	by PT_Support_NIH_Intra;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Support_NIH_Intra;
run;

proc sort data=&rawdataset;
	by PT_Support_Govt_Non;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Support_Govt_Non;
run;

proc sort data=&rawdataset;
	by PT_Support_Govt_NonPHS;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Support_Govt_NonPHS;
run;

proc sort data=&rawdataset;
	by PT_Support_Govt_PHS;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Support_Govt_PHS;
run;

proc sort data=&rawdataset;
	by PT_Review;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Review;
run;

proc sort data=&rawdataset;
	by PT_Validation_Studies;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Validation_Studies;
run;

proc sort data=&rawdataset;
	by PT_Journal_Article;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PT_Journal_Article;
run;

proc sort data=&rawdataset;
	by COI_YN;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  COI_YN;
run;

proc sort data=&rawdataset;
	by Support;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  Support;
run;

proc sort data=&rawdataset;
	by NIH_Support;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  NIH_Support;
run;

proc sort data=&rawdataset;
	by Govt_Support;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  Govt_Support;
run;

proc sort data=&rawdataset;
	by Govt_NIH_Support;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  Govt_NIH_Support;
run;

proc sort data=&rawdataset;
	by STAT;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  STAT;
run;

proc sort data=&rawdataset;
	by DP;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  DP;
run;

proc sort data=&rawdataset;
	by PST;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PST;
run;

proc sort data=&rawdataset;
	by PL;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  PL;
run;

proc sort data=&rawdataset;
	by JT;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  JT;
run;

proc sort data=&rawdataset;
	by Year;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Number_Revisions Total_Days_In_Revision;
	by  Year;
run;

proc sort data=&rawdataset;
	by Number_Revisions;
run;

proc means data=&rawdataset N Mean Median Min Max ;
	var Days_Accepted_To_Pubmed Days_LastSubmitted_To_Accepted Days_LastSubmitted_To_Pubmed Days_Received_To_Accepted
		Days_Received_To_Pubmed Days_Received_To_Revised1 Days_Revised1_To_Revised2 Days_Revised2_To_Revised3 Days_Revised3_To_Revised4 
		Total_Days_In_Revision;
	by  Number_Revisions;
run;

/* T-Tests */

/* Processing Time */
proc ttest data=&rawdataset;
	class Support;
	var Days_Accepted_To_Pubmed;
run;

proc ttest data=&rawdataset;
	class Govt_Support;
	var Days_Accepted_To_Pubmed;
run;

proc ttest data=&rawdataset;
	class NIH_Support;
	var Days_Accepted_To_Pubmed;
run;

proc ttest data=&rawdataset;
	class Govt_NIH_Support;
	var Days_Accepted_To_Pubmed;
run;

/* Publication Time */
proc ttest data=&rawdataset;
	class Support;
	var Days_Received_To_Pubmed;
run;

proc ttest data=&rawdataset;
	class Govt_Support;
	var Days_Received_To_Pubmed;
run;

proc ttest data=&rawdataset;
	class NIH_Support;
	var Days_Received_To_Pubmed;
run;

proc ttest data=&rawdataset;
	class Govt_NIH_Support;
	var Days_Received_To_Pubmed;
run;

/* Acceptance Time */
proc ttest data=&rawdataset;
	class Support;
	var Days_Received_To_Accepted;
run;

proc ttest data=&rawdataset;
	class Govt_Support;
	var Days_Received_To_Accepted;
run;

proc ttest data=&rawdataset;
	class NIH_Support;
	var Days_Received_To_Accepted;
run;

proc ttest data=&rawdataset;
	class Govt_NIH_Support;
	var Days_Received_To_Accepted;
run;
	
/* Graphs */

data graphdataset;
	set &rawdataset;

	if Year=. then delete;

run;

ods graphics on / maxlegendarea=100 width=7.75in height=7in;

proc sgplot data=graphdataset;
	vbar JT / response=Number_Revisions stat=freq group=Number_Revisions groupdisplay=cluster;
run;

proc sgplot data=graphdataset;
	styleattrs datacontrastcolors=(black) datasymbols=(circle circlefilled star starfilled triangle trianglefilled square squarefilled);
	vline Year2 / response=Days_Received_To_Pubmed stat=mean markers group=JT markerattrs=(color=black);
run;

proc sgplot data=graphdataset;
	styleattrs datacontrastcolors=(black) datasymbols=(circle circlefilled star starfilled triangle trianglefilled square squarefilled);
	vline Year2 / response=Days_Received_To_Accepted stat=mean markers group=JT markerattrs=(color=black);
run;

proc sgplot data=graphdataset;
	styleattrs datacontrastcolors=(black) datasymbols=(circle circlefilled star starfilled triangle trianglefilled square squarefilled);
	vline Year2 / response=Days_Accepted_To_Pubmed stat=mean markers group=JT markerattrs=(color=black);
run;

ods pdf close;
