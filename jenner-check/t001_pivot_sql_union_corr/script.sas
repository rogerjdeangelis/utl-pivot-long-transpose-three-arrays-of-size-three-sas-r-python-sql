/* Solution 1 (SAS SQL) from
   utl-pivot-long-transpose-three-arrays-of-size-three-sas-r-python-sql.sas
   Pivot three arrays of size three from wide to long with PROC SQL UNION CORR.
   Only change vs. upstream: libname sd1 "d:/sd1" is dropped so the input dataset
   lands in WORK (SRDB) -- the DATA step and PROC SQL logic are the author's, verbatim. */

data srdb;
 input ID
           AanD1 AanD2 AanD3
           UvD1 UvD2 UvD3
           FrqD1 FrqD2 FrqD3
 ;
cards4;
1.012 1 2 2 0 1 2 14 12 13
1.014 2 3 3 2 2 2 7 5 8
1.021 2 2 2 1 1 2 10 8 6
1.022 3 2 2 1 1 1 6 2 8
1.024 2 3 3 2 0 0 9 3 9
1.030 2 2 2 0 1 1 9 10 12
1.031 3 1 1 1 2 0 5 12 11
;;;;
run;quit;

proc sql;

  create
     table want as
  select
      ID
     ,1       as day
     ,AanD1   as  Aan
     ,UvD1    as  UvD
     ,FrqD1   as  FrqD
  from
      srdb
  union
      corr
  select
      ID
     ,2       as day
     ,AanD2   as  Aan
     ,UvD2    as  UvD
     ,FrqD2   as  FrqD
  from
      srdb
  union
      corr
  select
      ID
      ,3       as day
     ,AanD3   as  Aan
     ,UvD3    as  UvD
     ,FrqD3   as  FrqD
  from
      srdb
  order
      by id, day

;quit;

proc print data=want;
run;quit;
