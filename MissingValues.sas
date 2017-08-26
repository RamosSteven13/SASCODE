libname X '\\Client\C$\Users\Steven\OneDrive - University of Texas at San Antonio\SAS\SASDataSets';
data new;
 set X.SPSS;
 array myvars{5} Height Weight Age HR Chol;
 do i = 1 to 5;
 if myvars{i} = 999 then myvars{i} = .;
 end;
 drop i;
 run; 
 proc print data=new;
 run;

data missing;
 set X.chars;
 array char_vars{*} $ _character_;
 do loop = 1 to dim(char_vars);
 if char_vars{loop} in ('NA' '?') then
 call missing(char_vars{loop});
 end;
 drop loop;
 run; 
 proc print data=missing;
 run;

  libname X '\\Client\C$\Users\Steven\OneDrive - University of Texas at San Antonio\SAS\SASDataSets';
 data X.test_scores;
 length ID $ 3 Name $ 15;
 input ID $ Score1-Score3 Name $;
 datalines;
 1 90 95 98
 2 78 77 75
 3 88 91 92
 ; 
 proc print data=X.test_scores;
 run;
 title "The Descriptor Portion of Data Set TEST_SCORES";
proc contents data=X.test_scores;
run; 
title "Listing All the SAS Data Sets in a Library";
proc contents data=X._all_ nods;
run;
