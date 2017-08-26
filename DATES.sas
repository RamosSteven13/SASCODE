%let mydir=\\Client\C$\Users\Steven\OneDrive - University of Texas at San Antonio\SAS\SASDataSets;
data four_dates;
infile "&mydir\dates.txt" truncover;
input @1 Subject $3.
@5 DOB mmddyy10.
@16 VisitDate mmddyy8.
@26 TwoDigit mmddyy8.
@34 LastDate date9.;
format DOB VisitDate date9.
TwoDigit LastDate mmddyy10.;
run;
proc print data=four_dates;
run;
data ages;
set four_dates;
Age = yrdif(DOB,VisitDate,'Actual');
run;
title "Listing of AGES";
proc print data=ages;
id Subject;
var DOB VisitDate Age;
run;
data extract;
set four_dates;
Day = weekday(DOB);
DayOfMonth = day(DOB);
Month = Month(DOB);
Year = year(DOB);
run;
title "Listing of EXTRACT";
proc print data=extract noobs;
var DOB Day --Year;
run;



libname X "\\Client\C$\Users\Steven\OneDrive - University of Texas at San Antonio\SAS\SASDataSets";
data mdy_example;
set X.month_day_year;
Date = mdy(Month, Day, Year);
format Date mmddyy10.;
run;
proc print data=mdy_example;
run;



data substitute;
set X.month_day_year;
if missing(day) then Date = mdy(Month,15,Year);
else Date = mdy(Month,Day,Year);
format Date mmddyy10.;
run;
proc print data=substitute;
run;




data frequency;
set X.hosp(keep=AdmitDate);
where=(AdmitDate between '01Jan2003'd and'30Jun2006'd));
Quarter = intck('qtr','01Jan2003'd,AdmitDate);
run;
title "Frequency of Admissions";
proc freq data=frequency noprint;
tables Quarter / out=admit_per_quarter;
run;
goptions ftitle=swiss ftext=swiss;
symbol v=dot i=sm color=black width=2;
title height=2 "Frequency of Admissions From";
title2 height=2 "January 1, 2003 and June 30, 2006";
proc gplot data=admit_per_quarter;
plot Count * Quarter;
run;
quit;

*9-1;
data dates;
   input @1  Subj  $3.
         @4  DOB   mmddyy10.
         @14 Visit date9.;
   Age = yrdif(DOB,Visit,'Actual');
   format DOB Visit date9.;
datalines;
00110/21/195011Nov2006
00201/02/195525May2005
00312/25/200525Dec2006
;
title "Listing of DATES";
proc print data=dates noobs;
run;

*9-3;
options yearcutoff=1910;
data year1910_2006;
   input @1 Date mmddyy8.;
   format Date date9.;
datalines;
01/01/11
02/23/05
03/15/15
05/09/06
;
options yearcutoff=1920;
/* Good idea to set yearcutoff back to
   the default after you change it */
title "Listing of YEAR1910_2006";
proc print data=year1910_2006 noobs;
run;

*9-5;
data freq;
   set learn.hosp(keep=AdmitDate);
   Day = weekday(AdmitDate);
   Month = month(AdmitDate);
   Year = year(AdmitDate);
run;

proc format;
   value days 1='Sun' 2='Mon' 3='Tue'
              4='Wed' 5='Thu' 6='Fri'
              7='Sat';
   value months 1='Jan' 2='Feb' 3='Mar'
                4='Apr' 5='May' 6='Jun'
                7='Jul' 8='Aug' 9='Sep'
                10='Oct' 11='Nov' 12='Dec';
run;

title "Frequencies for Hospital Admissions";
proc freq data=freq;
   tables Day Month Year / nocum nopercent;
   format Day days. Month months.;
run;

*9-7;
title "Admissions before July 15, 2002";
proc print data=learn.hosp;
   where AdmitDate le '01Jul2002'd and 
      AdmitDate is not missing;
run;

*9-9;
data dates;
   input Day Month Year;
   if missing(Day) then Date = mdy(Month,15,Year);
   else Date = mdy(Month,Day,Year);
   format Date mmddyy10.;
datalines;
25 12 2005
.  5  2002
12 8     2006
;

title "Listing of DATES";
proc print data=dates noobs;
run;

*9-11;
data intervals;
   set learn.medical;
   Quarters = intck('qtr','01Jan2006'd,VisitDate);
run;

title "Listing of INTERVALS";
proc print data=intervals noobs;
run;

*9-13;
data return;
   set learn.medical(keep=Patno VisitDate);
   Return = intnx('month',VisitDate,6,'sameday');
   format VisitDate Return worddate.;
run;

title "Return Visits for Medical Patients";
proc print data=return noobs;
run;

