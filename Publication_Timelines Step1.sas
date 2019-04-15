options mprint;

%let path = C:\Users\dschreiber-gregory\Desktop\Complete Projects [NOT PUBLIC]\[2019.01] Publication Timelines (Maggio)\[2019.02.04] Quantitative Analysis;

filename pubmed "&path/pubmed_result.txt";



*--------------------------------------------------------------------------------;
*---------- pull in TXT file ----------;
*--------------------------------------------------------------------------------;

data rawtext;
   infile pubmed truncover;
   input @1 line $char200.;
   if _N_ = 1 then delete;
run;



*--------------------------------------------------------------------------------;
*---------- parse each line into key/value pairs, index revised rows ----------;
*--------------------------------------------------------------------------------;

data keyvalue;
   set rawtext;
   *--- mark some records ---;
   if line = "" then 
      blank = 1;
   if not blank and line ne "" then
      continued = 1;
   *--- parse into keys and values ---;
   length key $4 value $200;
   if not blank then do;
      key = substr(line,1,4);
      value = substr(line,7);
   end;
   *--- index repeats ---;
   retain phsti;
   if _n_ = 1 or blank then
      phsti = 0;
   if key = "PHST" and index(value,'[revised]') then
      phsti + 1;
run;



*--------------------------------------------------------------------------------;
*---------- make it horizontal ----------;
*--------------------------------------------------------------------------------;

data horizontal;
   set keyvalue;

   *--- turn key/value pairs horizontal ---;
   %macro makevar(var);
      length &var $2000 varname $20;
      retain &var varname;
      if key = upcase("&var") then do;
         &var = value;
         varname = "&var";
      end;
      *--- if multi-line, keep concatenating ---;
      else if continued then do;
         &var = catx(" ",&var,value);
      end;
   %mend makevar;

   %makevar(pmid)
   %makevar(own)
   %makevar(stat)
   %makevar(le)
   %makevar(is)
   %makevar(vi)
   %makevar(ip)
   %makevar(dp)
   %makevar(ti)
   %makevar(pg)
   %makevar(ab)
   %makevar(fau)
   %makevar(au)
   %makevar(ad)
   %makevar(la)
   
   *--- special processing for pt repeats ---;
   %let ptlist =  pt_adaptive pt_autobiography pt_bibliography pt_biography pt_case_reports pt_classical_article pt_clinical_conference 
				  pt_clinical_study pt_clinical_trial pt_phase_I pt_phase_II pt_phase_III pt_phase_IV pt_collected_works pt_comparative_study 
				  pt_congresses pt_consensus_NIH pt_consensus pt_controlled_trial pt_dataset pt_dictionary pt_directory pt_duplicate_publication 
				  pt_editorial pt_english_abstract pt_equivalence_trial pt_evaluation_studies pt_expression_concern pt_festschrift 
				  pt_government_publications pt_guideline pt_historical_article pt_interactive_tutorial pt_interview pt_introductory pt_lectures 
				  pt_legal_cases pt_legislation pt_letter pt_metaanalysis pt_multicenter_study pt_news pt_newspaper pt_observational pt_overall 
				  pt_patient pt_periodical_index pt_narratives pt_portraits pt_practice_guideline pt_pragmatic_trial pt_publication_component 
				  pt_publication_format pt_publication_category pt_randomized_trial pt_support_arra pt_support_NIH_extra pt_support_NIH_intra 
				  pt_support_govt_non pt_support_govt_nonphs pt_support_govt_phs pt_review pt_scientific_review pt_study_char pt_support_research 
				  pt_technical_report pt_twin_study pt_validation_studies pt_media_video pt_media_webcast pt_journal_article;
   length &ptlist $50;
   retain &ptlist;
   if key = "PT" then do;
      if index(value,"Adaptive Clinical Trial Addresses") then
         pt_adaptive = "Adaptive Clinical Trial Addresses";   
	  else if index(value,"Autobiography") then
         pt_autobiography = "Autobiography";     
	  else if index(value,"Bibliography") then
         pt_bibliography = "Bibliography";
      else if index(value,"Biography") then
         pt_biography = "Biography";      
	  else if index(value,"Case Reports") then
         pt_case_reports = "Case Reports";
      else if index(value,"Classical Article") then
         pt_classical_article = "Classical Article";      
	  else if index(value,"Clinical Conference") then
         pt_clinical_conference = "Clinical Conference";     
	  else if index(value,"Clinical Study") then
         pt_clinical_study = "Clinical Study";
      else if index(value,"Clinical Trial") then
         pt_clinical_trial = "Clinical Trial";      
	  else if index(value,"Clinical Trial, Phase I") then
         pt_phase_I = "Clinical Trial, Phase I";
      else if index(value,"Clinical Trial, Phase II") then
         pt_phase_II = "Clinical Trial, Phase II";      
	  else if index(value,"Clinical Trial, Phase III") then
         pt_phase_III = "Clinical Trial, Phase III";
	  else if index(value,"Clinical Trial, Phase IV") then
         pt_phase_IV = "Clinical Trial, Phase IV";     
	  else if index(value,"Collected Works") then
         pt_collected_works = "Collected Works";
      else if index(value,"Comparative Study") then
         pt_comparative_study = "Comparative Study";      
	  else if index(value,"Congresses") then
         pt_congresses = "Congresses";
      else if index(value,"Consensus Development Conference, NIH") then
         pt_consensus_NIH = "Consensus Development Conference, NIH";      
	  else if index(value,"Consensus Development Conference") then
         pt_consensus = "Consensus Development Conference";     
	  else if index(value,"Controlled Clinical Trial") then
         pt_controlled_trial = "Controlled Clinical Trial";
      else if index(value,"Dataset") then
         pt_dataset = "Dataset";      
	  else if index(value,"Dictionary") then
         pt_dictionary = "Dictionary";
      else if index(value,"Directory") then
         pt_directory = "Directory";      
	  else if index(value,"Duplicate Publication") then
         pt_duplicate_publication = "Duplicate Publication";
	  else if index(value,"Editorial") then
         pt_editorial = "Editorial";     
	  else if index(value,"English Abstract") then
         pt_english_abstract = "English Abstract";
      else if index(value,"Equivalence Trial") then
         pt_equivalence_trial = "Equivalence Trial";      
	  else if index(value,"Evaluation Studies") then
         pt_evaluation_studies = "Evaluation Studies";
      else if index(value,"Expression of Concern") then
         pt_expression_concern = "Expression of Concern";      
	  else if index(value,"Festschrift") then
         pt_festschrift = "Festschrift";     
	  else if index(value,"Government Publications") then
         pt_government_publications = "Government Publications";
      else if index(value,"Guideline") then
         pt_guideline = "Guideline";      
	  else if index(value,"Historical Article") then
         pt_historical_article = "Historical Article";
      else if index(value,"Interactive Tutorial") then
         pt_interactive_tutorial = "Interactive Tutorial";      
	  else if index(value,"Interview") then
         pt_interview = "Interview";
	  else if index(value,"Introductory Journal Article") then
         pt_introductory = "Introductory Journal Article";  
      else if index(value,"Lectures") then
         pt_lectures = "Lectures";      
	  else if index(value,"Legal Cases") then
         pt_legal_cases = "Legal Cases";
      else if index(value,"Legislation") then
         pt_legislation = "Legislation";      
	  else if index(value,"Letter") then
         pt_letter = "Letter";     
	  else if index(value,"Meta-Analysis") then
         pt_metaanalysis = "Meta-Analysis";
      else if index(value,"Multicenter Study") then
         pt_multicenter_study = "Multicenter Study";      
	  else if index(value,"News") then
         pt_news = "News";
      else if index(value,"Newspaper Article") then
         pt_newspaper = "Newspaper Article";      
	  else if index(value,"Observational Study") then
         pt_observational = "Observational Study";
	  else if index(value,"Overall") then
         pt_overall = "Overall";     
	  else if index(value,"Patient Education Handout") then
         pt_patient = "Patient Education Handout";
      else if index(value,"Periodical Index") then
         pt_periodical_index = "Periodical Index";      
	  else if index(value,"Personal Narratives") then
         pt_narratives = "Personal Narratives";
      else if index(value,"Portraits") then
         pt_portraits = "Portraits";      
	  else if index(value,"Practice Guideline") then
         pt_practice_guideline = "Practice Guideline";     
	  else if index(value,"Pragmatic Clinical Trial") then
         pt_pragmatic_trial = "Pragmatic Clinical Trial";
      else if index(value,"Publication Components") then
         pt_publication_component = "Publication Components";      
	  else if index(value,"Publication Formats") then
         pt_publication_format = "Publication Formats";
      else if index(value,"Publication Type Category") then
         pt_publication_category = "Publication Type Category";      
	  else if index(value,"Randomized Controlled Trial") then
         pt_randomized_trial = "Randomized Controlled Trial";
	  else if index(value,"Research Support, American Recovery and Reinvestment Act") then
         pt_support_arra = "Research Support, American Recovery and Reinvestment Act";
	  else if index(value,"Research Support, N.I.H., Extramural") then
         pt_support_NIH_extra = "Research Support, N.I.H., Extramural";
	  else if index(value,"Research Support, N.I.H., Intramural") then
         pt_support_NIH_intra = "Research Support, N.I.H., Intramural";
	  else if index(value,"Research Support, Non-U.S. Gov't") then
         pt_support_govt_non = "Research Support, Non-U.S. Gov't";
	  else if index(value,"Research Support, U.S. Gov't, Non-P.H.S") then
         pt_support_govt_nonphs = "Research Support, U.S. Gov't, Non-P.H.S";
	  else if index(value,"Research Support, U.S. Gov't, P.H.S.") then
         pt_support_govt_phs = "Research Support, U.S. Gov't, P.H.S.";
	  else if index(value,"Review") then
         pt_review = "Review";
	  else if index(value,"Scientific Integrity Review") then
         pt_scientific_review = "Scientific Integrity Review";
	  else if index(value,"Study Characteristics") then
         pt_study_char = "Study Characteristics";
	  else if index(value,"Support of Research") then
         pt_support_research = "Support of Research";
	  else if index(value,"Technical Report") then
         pt_technical_report = "Technical Report";
	  else if index(value,"Twin Study") then
         pt_twin_study = "Twin Study";
	  else if index(value,"Validation Studies") then
         pt_validation_studies = "Validation Studies";
	  else if index(value,"Video-Audio Media") then
         pt_media_video = "Video-Audio Media";
	  else if index(value,"Webcasts") then
         pt_media_webcast = "Webcasts";
	  else if index(value,"Journal Article") then
         pt_journal_article = "Journal Article";
   end;

   %makevar(dep)
   %makevar(pl)
   %makevar(ta)
   %makevar(jt)
   %makevar(jid)
   %makevar(oto)
   %makevar(ot)
   %makevar(pmc)
   %makevar(cois)
   %makevar(edat)
   %makevar(mhda)
   %makevar(crdt)
   %makevar(pmcr)

   *--- special processing for phst repeats, especially the revised repeats ---;
   %let phstlist = phst_received phst_revised_1 phst_revised_2 phst_revised_3 phst_revised_4 phst_revised_5
      phst_accepted phst_pmc_rel phst_entrez phst_pubmed phst_medline;
   length &phstlist $20;
   retain &phstlist;
   if key = "PHST" then do;
      if index(value,"[received]") then
         phst_received = scan(value,1,'[');
      else if index(value,"[revised]") then do;
         %macro revised();
            %do i = 1 %to 5;
               if phsti = &i then
                  phst_revised_&i = scan(value,1,'[');
            %end;
         %mend revised;
         %revised()
      end;
      else if index(value,"[accepted]") then
         phst_accepted = scan(value,1,'[');
      else if index(value,"[pmc-release]") then
         phst_pmc_rel = scan(value,1,'[');
      else if index(value,"[entrez]") then
         phst_entrez = scan(value,1,'[');
      else if index(value,"[pubmed]") then
         phst_pubmed = scan(value,1,'[');
      else if index(value,"[medline]") then
         phst_medline = scan(value,1,'[');
   end;

   %makevar(aid)
   %makevar(pst)
   %makevar(so)

   *--- output record and reset for next set of values ---;
   if blank then do;
      output;
      call missing(pmid,own,stat,le,is,vi,ip,dp,ti,pg,ab,fau,au,ad,la
	  	 ,pt_adaptive,pt_autobiography,pt_bibliography,pt_biography,pt_case_reports,pt_classical_article,pt_clinical_conference 
		 ,pt_clinical_study,pt_clinical_trial,pt_phase_I,pt_phase_II,pt_phase_III,pt_phase_IV,pt_collected_works,pt_comparative_study 
		 ,pt_congresses,pt_consensus_NIH,pt_consensus,pt_controlled_trial,pt_dataset,pt_dictionary,pt_directory,pt_duplicate_publication 
		 ,pt_editorial,pt_english_abstract,pt_equivalence_trial,pt_evaluation_studies,pt_expression_concern,pt_festschrift 
		 ,pt_government_publications,pt_guideline,pt_historical_article,pt_interactive_tutorial,pt_interview,pt_introductory,pt_lectures 
		 ,pt_legal_cases,pt_legislation,pt_letter,pt_metaanalysis,pt_multicenter_study,pt_news,pt_newspaper,pt_observational,pt_overall 
		 ,pt_patient,pt_periodical_index,pt_narratives,pt_portraits,pt_practice_guideline,pt_pragmatic_trial,pt_publication_component 
		 ,pt_publication_format,pt_publication_category,pt_randomized_trial,pt_support_arra,pt_support_NIH_extra,pt_support_NIH_intra 
		 ,pt_support_govt_non,pt_support_govt_nonphs,pt_support_govt_phs,pt_review,pt_scientific_review,pt_study_char,pt_support_research 
		 ,pt_technical_report,pt_twin_study,pt_validation_studies,pt_media_video,pt_media_webcast,pt_journal_article
		 ,pt,dep,pl,ta
         ,jt,jid,oto,ot,pmc,cois,edat,mhda,crdt,pmcr
         ,phst_received,phst_revised_1,phst_revised_2,phst_revised_3,phst_revised_4,phst_revised_5
         ,phst_accepted,phst_pmc_rel,phst_entrez,phst_pubmed,phst_medline
         ,aid,pst,so
         );
   end;

   drop line blank continued key value phsti varname;
run;

proc export 
  data=horizontal
  dbms=xlsx 
  outfile="C:\Users\dschreiber-gregory\Desktop\Publication_Timeline.xlsx" 
  replace;
run;
