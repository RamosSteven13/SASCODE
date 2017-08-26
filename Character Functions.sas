title "Demonstrating the Concatenation Functions";
data Cat;
Length Join Name1-Name4 $ 15;
First = 'Ron ';
Last = 'Cody ';
Join = ':' || First || ':';
Name1 = First || Last;
Name2 = cat(First,Last);
Name3 = cats(First,Last);
Name4 = catx(' ',First,Last);
file print;
put Join= /
Name1= /
Name2= /
Name3= /
Name4= /;
run;
proc print data=Cat;
run;
data blanks;
String = ' ABC ';
***There are 3 leading and 2 trailing blanks in String;
JoinLeft = ':' || left(String) || ':';
JoinTrim = ':' || trim(String) || ':';
JoinStrip = ':' || strip(String) || ':';
file print;
put
JoinLeft= /
JoinTrim=/
JoinStrip=/;

run;

libname X "\\Client\C$\Users\Steven\OneDrive - University of Texas at San Antonio\SAS\SASDataSets";
data phone;
length PhoneNumber $ 10;
set X.phone;
PhoneNumber = compress(Phone,' ()-.');
drop Phone;
run;
proc print data=phone;
run;
