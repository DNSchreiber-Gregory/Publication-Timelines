/**************************************************************************************************************************************************/
/************************************************************ Dataset Set-up **********************************************************************/
/**************************************************************************************************************************************************/

/** Input: <Raw Dataset Name> **/

%let dataset = dataset; /* need to specify if using macro that needs &dataset */
%let rawdataset = raw_dataset; /* need to specify if using macro that needs &rawdataset */
%let rawdataset2 = raw_dataset2; /* need to specify if using macro that needs &rawdataset */

proc import out=&rawdataset datafile='C:\Users\dschreiber-gregory\Desktop\Complete Projects [NOT PUBLIC]\[2019.01] Publication Timelines (Maggio)\[2019.02.04] Quantitative Analysis\Publication_Timeline.xlsx' 
dbms=xlsx replace;
sheet='Publication_Timeline';
getnames=yes;
run;

data &dataset;
	set &rawdataset (rename=(pmid = pmid_raw
							 own = own_raw
							 stat = stat_raw
							 le = le_raw
							 is = is_raw
							 vi = vi_raw
							 ip = ip_raw
							 dp = dp_raw
							 ti = ti_raw
							 pg = pg_raw
							 ab = ab_raw
							 fau = fau_raw
							 au = au_raw
							 ad = ad_raw
							 la = la_raw
							 pt = pt_raw
							 dep = dep_raw
							 pl = pl_raw
							 ta = ta_raw
							 jt = jt_raw
							 jid = jid_raw
							 oto = oto_raw
							 ot = ot_raw
							 pmc = pmc_raw
							 cois = cois_raw
							 edat = edat_raw
							 mhda = mhda_raw
							 crdt = crdt_raw
							 pmcr = pmcr_raw
							 phst_received = phst0
							 phst_revised_1 = phst1
							 phst_revised_2 = phst2
							 phst_revised_3 = phst3
							 phst_revised_4 = phst4
							 phst_revised_5 = phst5
							 phst_accepted = phst6
							 phst_pmc_rel = phst7
							 phst_entrez = phst8
							 phst_pubmed = phst9
							 phst_medline = phst10
							 pt_adaptive = PT_Adaptive
							 pt_autobiography = PT_Autobiography
							 pt_bibliography = PT_Bibliography
							 pt_biography = PT_Biography
							 pt_case_reports = PT_Case_Reports
							 pt_classical_article = PT_Classical_Article
							 pt_clinical_conference = PT_Clinical_Conference
							 pt_clinical_study = PT_Clinical_Study
							 pt_clinical_trial = PT_Clinical_Trial
							 pt_phase_I = PT_Phase_I
							 pt_phase_II = PT_Phase_II
							 pt_phase_III = PT_Phase_III
							 pt_phase_IV = PT_Phase_IV
							 pt_collected_works = PT_Collected_Works
							 pt_comparative_study = PT_Comparative_Study
							 pt_congresses = PT_Congresses
							 pt_consensus_NIH = PT_Consensus_NIH
							 pt_consensus = PT_Consensus
							 pt_controlled_trial = PT_Controlled_Trial
							 pt_dataset = PT_Dataset
							 pt_dictionary = PT_Dictionary
							 pt_directory = PT_Directory
							 pt_duplicate_publication = PT_Duplicate_Publication
							 pt_editorial = PT_Editorial
							 pt_english_abstract = PT_English_Abstract
							 pt_equivalence_trial = PT_Equivalence_Trial
							 pt_evaluation_studies = PT_Evaluation_Studies
							 pt_expression_concern = PT_Expression_Concern
							 pt_festschrift = PT_Festschrift
							 pt_government_publications = PT_Government_Publications
							 pt_guideline = PT_Guideline
							 pt_historical_article = PT_Historical_Article
							 pt_interactive_tutorial = PT_Interactive_Tutorial
							 pt_interview = PT_Interview
							 pt_introductory = PT_Introductory
							 pt_lectures = PT_Lectures
							 pt_legal_cases = PT_Legal_Cases
							 pt_legislation = PT_Legislation
							 pt_letter = PT_Letter
							 pt_metaanalysis = PT_MetaAnalysis
							 pt_multicenter_study = PT_MultiCenter_Study
							 pt_news = PT_News
							 pt_newspaper = PT_Newspaper
							 pt_observational = PT_Observational
							 pt_overall = PT_Overall
							 pt_patient = PT_Patient
							 pt_periodical_index = PT_Periodical_Index
							 pt_narratives = PT_Narratives
							 pt_portraits = PT_Portraits
							 pt_practice_guideline = PT_Practice_Guideline
							 pt_pragmatic_trial = PT_Pragmatic_Trial
							 pt_publication_component = PT_Publication_Component
							 pt_publication_format = PT_Publication_Format
							 pt_publication_category = PT_Publication_Category
							 pt_randomized_trial = PT_Randomized_Trial
							 pt_support_arra = PT_Support_ARRA
							 pt_support_NIH_extra = PT_Support_NIH_Extra
							 pt_support_NIH_intra = PT_Support_NIH_Intra
							 pt_support_govt_non = PT_Support_Govt_Non
							 pt_support_govt_nonphs = PT_Support_Govt_NonPHS
							 pt_support_govt_phs = PT_Support_Govt_PHS
							 pt_review = PT_Review
							 pt_scientific_review = PT_Scientific_Review
							 pt_study_char = PT_Study_Char
							 pt_support_research = PT_Support_Research
							 pt_technical_report = PT_Technical_Report
							 pt_twin_study = PT_Twin_Study
							 pt_validation_studies = PT_Validation_Studies
							 pt_media_video = PT_Media_Video
							 pt_media_webcast = PT_Media_Webcast
							 pt_journal_article = PT_Journal_Article
							 aid = aid_raw
							 pst = pst_raw
							 so = SO));

		PMID = trim(left(scan(pmid_raw, 1, " ")));
		OWN = trim(left(scan(own_raw, 1, " ")));
		STAT = trim(left(scan(stat_raw, 1, " ")));
		LR = trim(left(scan(le_raw, 1, " ")));
		IS = trim(left(scan(is_raw, 1, ") ")));
		VI = trim(left(scan(vi_raw, 1, " ")));
		IP = trim(left(scan(ip_raw, 1, " ")));
		DP = trim(left(scan(dp_raw, 1, " ")));
	length TI $250.;
		TI = ti_raw;
		PG = trim(left(scan(pg_raw, 1, " ")));
	length AB $250.;
		AB = ab_raw;
		AB2 = trim(left(scan(ab_raw, 1, " ")));
	length FAU $100.;
		FAU = fau_raw;
	length AU $100.;
		AU = au_raw;
	length AD $100.;
		AD = ad_raw;
		LA = trim(left(scan(la_raw, 1, " ")));
	length PT $50.;
		PT = pt_raw;
		DEP = trim(left(scan(dep_raw, 1, " ")));
		PL = trim(left(scan(pl_raw, 1, " ")));
	length TA $15.;
		TA = ta_raw;
	length JT $45.;
		JT = jt_raw;
		JID = trim(left(scan(jid_raw, 1, " ")));
		OTO = trim(left(scan(oto_raw, 1, " ")));
		OT = trim(left(scan(ot_raw, 1, " ")));
		PMC = trim(left(scan(pmc_raw, 1, " ")));
	length COIS $250.;
		COIS = cois_raw;
		COIS2 = trim(left(scan(cois_raw, 1, " ")));
		EDAT = trim(left(scan(edat_raw, 1, " ")));
		MHDA = trim(left(scan(mhda_raw, 1, " ")));
		CRDT = trim(left(scan(crdt_raw, 1, " ")));
		PMCR = trim(left(scan(pmcr_raw, 1, " ")));
		AID = trim(left(scan(aid_raw, 1, "i] ")));
		PST = trim(left(scan(pst_raw, 1, " ")));
	length PHST_Received $10.;
		PHST_Received=trim(left(scan(phst0, 1, " ")));
	length PHST_Revised_1 $10.;
		PHST_Revised_1=trim(left(scan(phst1, 1, " ")));
	length PHST_Revised_2 $10.;
		PHST_Revised_2=trim(left(scan(phst2, 1, " ")));
	length PHST_Revised_3 $10.;
		PHST_Revised_3=trim(left(scan(phst3, 1, " ")));
	length PHST_Revised_4 $10.;
		PHST_Revised_4=trim(left(scan(phst4, 1, " ")));
	length PHST_Revised_5 $10.;
		PHST_Revised_5=trim(left(scan(phst5, 1, " ")));
	length PHST_Accepted $10.;
		PHST_Accepted=trim(left(scan(phst6, 1, " ")));
	length PHST_PMC_Rel $10.;
		PHST_PMC_Rel=trim(left(scan(phst7, 1, " ")));
	length PHST_Entrez $10.;
		PHST_Entrez=trim(left(scan(phst8, 1, " ")));
	length PHST_PubMed $10.;
		PHST_PubMed=trim(left(scan(phst9, 1, " ")));
	length PHST_Medline $10.;
		PHST_Medline=trim(left(scan(phst10, 1, " ")));

	drop pmid_raw own_raw stat_raw le_raw is_raw vi_raw ip_raw dp_raw
		 ti_raw pg_raw ab_raw fau_raw au_raw ad_raw la_raw pt_raw dep_raw
		 pl_raw ta_raw jt_raw jid_raw oto_raw ot_raw pmc_raw cois_raw
		 edat_raw mhda_raw crdt_raw pmcr_raw aid_raw pst_raw
		 phst0 phst1 phst2 phst3 phst4 phst5 phst6 phst7 phst8 phst9 phst10;
run;

data dataset2;
	set &dataset (rename=(PHST_Received = phst0
							 PHST_Revised_1 = phst1
							 PHST_Revised_2 = phst2
							 PHST_Revised_3 = phst3
							 PHST_Revised_4 = phst4
							 PHST_Revised_5 = phst5
							 PHST_Accepted = phst6
							 PHST_PMC_Rel = phst7
							 PHST_Entrez = phst8
							 PHST_Pubmed = phst9
							 PHST_Medline = phst10));

	PHST_Received = input(phst0, yymmdd10.);	format PHST_Received date10.;
 	PHST_Revised_1 = input(phst1, yymmdd10.);	format PHST_Revised_1 date10.;
  	PHST_Revised_2 = input(phst2, yymmdd10.);	format PHST_Revised_2 date10.;
	PHST_Revised_3 = input(phst3, yymmdd10.);	format PHST_Revised_3 date10.;
	PHST_Revised_4 = input(phst4, yymmdd10.);	format PHST_Revised_4 date10.; 
	PHST_Revised_5 = input(phst5, yymmdd10.);	format PHST_Revised_5 date10.; 
	PHST_Accepted = input(phst6, yymmdd10.);	format PHST_Accepted date10.; 
	PHST_PMC_Rel = input(phst7, yymmdd10.);		format PHST_PMC_Rel date10.; 
	PHST_Entrez = input(phst8, yymmdd10.);		format PHST_Entrez date10.; 
	PHST_Pubmed = input(phst9, yymmdd10.);		format PHST_Pubmed date10.; 
	PHST_Medline = input(phst10, yymmdd10.);	format PHST_Medline date10.; 

	drop phst0 phst1 phst2 phst3 phst4 phst5 phst6 phst7 phst8 phst9 phst10;
run;

data Publication_Timeline;
	set dataset2 (rename=(VI=VI_raw
						  IP=IP_raw
						  AB=AB_raw
						  PL=PL_raw
						  PMC=PMC_raw
						  COIS=COIS_raw
						  PMCR=PMCR_raw
						  AID=AID_raw
						  JT=JT_raw));

	length VI 5.;
		if VI_raw > 500 then VI=.;
			else VI=VI_raw;
	length IP $10.;
		if IP_raw = PMID then IP=.;
			else IP=IP_raw;
	length AB $250;
		if AB2 = PMID then AB='';
			else AB=AB_raw;
	length PL $15.;
		if PL_raw = 'United' then PL='United States';
			else PL=PL_raw;
	length PMC $15.;
		if PMC_raw=PMID then PMC='';
			else PMC=PMC_raw;
	length COIS $1000.;
		if COIS2 = PMID then COIS='';
			else COIS=COIS_raw;
	length COI_YN $5.;
		if index(COIS," no ") then COI_YN = "No";
			else if index(COIS," not ") then COI_YN = "No";
			else if index(COIS," No ") then COI_YN = "No";
			else if index(COIS," Not ") then COI_YN = "No";
			else if index(COIS," none ") then COI_YN = "No";
			else if index(COIS," None ") then COI_YN = "No";
			else if index(COIS,":None ") then COI_YN = "No";
			else if missing(COIS) then COI_YN = '';
			else COI_YN = "Yes";
	length PMCR $15.;
		if PMCR_raw=PMID then PMCR='';
			else PMCR=PMCR_raw;
	length AID $15.;
		if AID_raw=PMID then AID='';
			else AID=AID_raw;
	length JT $100.;
		if TA='Acad Med Academ' then JT='Academic medicine : journal of the Association of American Medical Colleges';
			else if TA='Adv Health Sci' then JT='Advances in health sciences education : theory and practice';
			else if TA='BMC Med Educ BM' then JT='BMC Medical Education';
			else if TA='Can Med Educ J' then JT='Canadian Medical Education Journal';
			else if TA='Clin Teach The' then JT='The clinical teacher';
			else if TA='Int J Med Educ' then JT='International Journal of Medical Education';
			else if TA='J Adv Med Educ' then JT='Journal of advances in medical education & practice';
			else if TA='J Contin Educ H' then JT='The Journal of continuing education in the health professions';
			else if TA='J Grad Med Educ' then JT='Journal of graduate medical education';
			else if TA='Med Educ Medica' then JT='Medical Education';
			else if TA='Med Educ Online' then JT='Medical education online';
			else if TA='Med Teach Medic' then JT='Medical teacher';
			else if TA='Perspect Med Ed' then JT='Perspectives on medical education';
			else if TA='Teach Learn Med' then JT='Teaching and learning in medicine';
			else JT='';
	LastSubmitted = max(PHST_Received, PHST_Revised_1, PHST_Revised_2, PHST_Revised_3, PHST_Revised_4, PHST_Revised_5); format LastSubmitted date10.; 
	length Days_Received_To_Revised1 5.;
		if PHST_Revised_1=. then Days_Received_To_Revised1=.;
		else Days_Received_To_Revised1 = PHST_Revised_1-PHST_Received;
	length Days_Revised1_To_Revised2 5.;
		if PHST_Revised_2=. then Days_Revised1_To_Revised2=.;
		else Days_Revised1_To_Revised2 = PHST_Revised_2-PHST_Revised_1;
	length Days_Revised2_To_Revised3 5.;
		if PHST_Revised_3=. then Days_Revised2_To_Revised3=.;
		else Days_Revised2_To_Revised3 = PHST_Revised_3-PHST_Revised_2;
	length Days_Revised3_To_Revised4 5.;
		if PHST_Revised_4=. then Days_Revised3_To_Revised4=.;
		else Days_Revised3_To_Revised4 = PHST_Revised_4-PHST_Revised_3;
	length Days_Revised4_To_Revised5 5.;
		if PHST_Revised_5=. then Days_Revised4_To_Revised5=.;
		else Days_Revised4_To_Revised5 = PHST_Revised_5-PHST_Revised_4;
	length Days_LastSubmitted_To_Accepted 5.;
		if (PHST_Accepted=. or LastSubmitted=.) then Days_LastSubmitted_To_Accepted=.;
		else Days_LastSubmitted_To_Accepted = PHST_Accepted-LastSubmitted;
	length Days_Received_To_Accepted 5.;
		if (PHST_Accepted=. or PHST_Received=.) then Days_Received_To_Accepted=.;
		else Days_Received_To_Accepted = PHST_Accepted-PHST_Received;
	length Days_Received_To_Pubmed 5.;
		if (PHST_Pubmed=. or PHST_Received=.) then Days_Received_To_Pubmed=.;
		else Days_Received_To_Pubmed = PHST_Pubmed-PHST_Received;
	length Days_LastSubmitted_To_Pubmed 5.;
		if (PHST_Pubmed=. or LastSubmitted=.) then Days_LastSubmitted_To_Pubmed=.;
		else Days_LastSubmitted_To_Pubmed = PHST_Pubmed-LastSubmitted;
	length Days_Accepted_To_Pubmed 5.;
		if (PHST_Pubmed=. or PHST_Accepted=.) then Days_Accepted_To_Pubmed=.;
		else Days_Accepted_To_Pubmed = PHST_Pubmed-PHST_Accepted;
	length Total_Days_In_Revision 5.;
		if (PHST_Received=. or LastSubmitted=.) then Total_Days_In_Revision=.;
		else Total_Days_In_Revision = LastSubmitted-PHST_Received;
	length Number_Revisions 5.;
		if Days_Revised4_To_Revised5 ne . then Number_Revisions=5;
		else if Days_Revised3_To_Revised4 ne . then Number_Revisions=4;
		else if Days_Revised2_To_Revised3 ne . then Number_Revisions=3;
		else if Days_Revised1_To_Revised2 ne . then Number_Revisions=2;
		else if Days_Received_To_Revised1 ne . then Number_Revisions=1;
		else if PHST_Received ne . then Number_Revisions=0;
		else Number_Revisions=.;
	length Year 4.;
		Year=year(PHST_Received);
		

	drop VI_raw IP_raw AB_raw PL_raw PMC_raw COIS_raw PMCR_raw AID_raw
		 AB2 COIS2 JT_raw;
run;

data Publication_Timeline;
	set Publication_Timeline;

	if LastSubmitted<0 then LastCubmitted=.;
	if Days_Received_To_Revised1<0 then Days_Received_To_Revised1=.;
	if Days_Revised1_To_Revised2<0 then Days_Revised1_To_Revised2=.;
	if Days_Revised2_To_Revised3<0 then Days_Revised2_To_Revised3=.;
	if Days_Revised3_To_Revised4<0 then Days_Revised3_To_Revised4=.;
	if Days_Revised4_To_Revised5<0 then Days_Revised4_To_Revised5=.;
	if Days_LastSubmitted_To_Accepted<0 then Days_LastSubmitted_To_Accepted=.;
	if Days_Received_To_Accepted<0 then Days_Received_To_Accepted=.;
	if Days_Received_To_Pubmed<0 then Days_Received_To_Pubmed=.;
	if Days_LastSubmitted_To_Pubmed<0 then Days_LastSubmitted_To_Pubmed=.;
	if Days_Accepted_To_Pubmed<0 then Days_Accepted_To_Pubmed=.;
	if Total_Days_In_Revision<0 then Total_Days_In_Revision=.;

	if (PT_Support_ARRA^=' ' or PT_Support_Govt_Non^=' ' or PT_Support_Govt_NonPHS^=' ' or PT_Support_Govt_PHS^=' '
		or PT_Support_NIH_Extra^=' ' or PT_Support_NIH_Intra^=' ' or PT_Support_Research^=' ') then Support="Research Support";
		else Support='No Support';

	if (PT_Support_NIH_Extra^=' ' or PT_Support_NIH_Intra^=' ') then NIH_Support="NIH Support";
		else NIH_Support='No NIH Support';

	if (PT_Support_Govt_NonPHS^=' ' or PT_Support_Govt_PHS^=' ') then Govt_Support="Govt Support";
		else Govt_Support='No Govt Support';

run;

proc contents data=Publication_Timeline;
run;

proc export data=Publication_Timeline
  dbms=xlsx 
  outfile="C:\Users\dschreiber-gregory\Desktop\Publication Timeline Complete.xlsx" 
  replace;
run;

