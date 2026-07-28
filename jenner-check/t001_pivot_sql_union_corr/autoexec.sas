/* cap input rows for the captured run */
options obs=100;
/* upstream sets uppercase varnames; original libname sd1 "d:/sd1" -> WORK for portability */
options validvarname=upcase;
