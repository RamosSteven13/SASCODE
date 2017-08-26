

%let mydir=C:\Users\ckj889\OneDrive - University of Texas at San Antonio\SAS\OH03 Data Files;
DATA accidents;
LENGTH Month $9.;
INFILE "&mydir\Accidents.csv" dlm=',' firstobs=2;
INPUT Month $ Y1990-Y1995;
File "&mydir\AccidentsNEW.txt";
if _n_=1
	then put'Month    y1990  Y1995'; *my first sas question;
PUT Month $ 1-9 @12 (Y1990 Y1995)(3.);
RUN;
proc print data=accidents;
run;


libname indir "&mydir";

data indir.accidentsNEWSAS;
set accidents; 
run;
proc print data=indir.accidentsNEWSAS;
run;

filename input1 "&mydir/accidents.csv";
filename output1 "&mydir/accidentsNEW.txt";
data accidents;
length month $ 9.;
infile input1 dlm=',' firstobs=2;
input Month $ Y1990-Y1995;
File output1;
if _n_=1
	then put'Month    y1990  Y1995'; *my first sas question;
PUT Month $ 1-9 @12 (Y1990 Y1995)(3.);
run;
filename choldata "&mydir\choldata.txt";
data choltest;
infile choldata;
input IDnum $ 10-14 Department $ 10-11LastName $ 1-9 Cholesterol 15-19;
run;
proc print data=choltest;
run;
data choltest2;
infile choldata;
input @10 IDnum $5.
	  @10 Department $1.  /* Brrrrooooookkeeeennnnnn*/
	  @1 LastName $9.
	  @15 Cholesterol $5.1;
proc print data=choltest2;
run;


filename vandata 'C:\Users\ckj889\OneDrive - University of Texas at San Antonio\SAS\OH04 Data Files\vandata.txt';
data vansales;
infile vandata;

*input  Region $ 9.  Quarter  TotalSales comma12.; 

input +12 Quarter 1. @1 Region $9. +6 TotalSales comma11.;
run;
proc print data=vansales;
run;


filename cardata 'C:\Users\ckj889\OneDrive - University of Texas at San Antonio\SAS\OH04 Data Files\cardata.txt';
data cartest;
infile cardata;
*input Year 4. +1 Country $6. +1 Type $6. @20 Sales comma10.;
*input @1 Year 4. @6 Country $7. @13 Type $6. @20 Sales comma10.;
input year country $ type $ sales comma12.;
run;
proc print data=cartest;
run;
