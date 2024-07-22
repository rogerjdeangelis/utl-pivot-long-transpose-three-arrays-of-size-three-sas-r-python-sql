%let pgm=utl-pivot-long-transpose-three-arrays-of-size-three-sas-r-python-sql;

Pivot transpose long three arrays of size three sas r python sql

Depending on the compiler this could be quite fast even though it is in sql

      SOLUTIONS
         1 sas sql
         2 sas sql arrays
         3 r sql
         4 r sql arrays
         5 python sql
         6 related repos


github
https://tinyurl.com/mve2ruyw
https://github.com/rogerjdeangelis/utl-pivot-long-transpose-three-arrays-of-size-three-sas-r-python-sql

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

 /**************************************************************************************************************************/
 /*                                                      |                           |                                     */
 /*                   INPUT                              |       PROCESS             |              OUTPUT                 */
 /*                   =====                              |       =======             |              ======                 */
 /*                                                      |                           |                                     */
 /* Pivot by groups of three                             |                           |                                     */
 /*                                                      |                           |                                     */
 /*       Aan Aan Aan                      Frq Frq Frq   | proc sql;                 |                                     */
 /*   ID   D1  D2  D3    UvD1 UvD2 UvD3     D1  D2  D3   |                           |   ID     day    Aan    UvD    FrqD  */
 /*                                                      |   create                  |                                     */
 /* 1.012  1   2   2       0    1    2      14  12  13   |      table want as        | 1.012     1      1      0      14   */
 /*                                                      |   select                  | 1.012     2      2      1      12   */
 /*                                                      |       ID                  | 1.012     3      2      2      13   */
 /*                                                      |      ,1       as day      |                                     */
 /*                                                      |      ,AanD1   as  Aan     | 1.014     1      2      2       7   */
 /* 1.014  2   3   3       2    2    2       7   5   8   |      ,UvD1    as  UvD     | 1.014     2      3      2       5   */
 /* 1.021  2   2   2       1    1    2      10   8   6   |      ,FrqD1   as  FrqD    | 1.014     3      3      2       8   */
 /* 1.022  3   2   2       1    1    1       6   2   8   |   from                    | 1.021     1      2      1      10   */
 /* 1.024  2   3   3       2    0    0       9   3   9   |       srdb                | 1.021     2      2      1       8   */
 /* 1.030  2   2   2       0    1    1       9  10  12   |   union                   | 1.021     3      2      2       6   */
 /* 1.031  3   1   1       1    2    0       5  12  11   |       corr                | 1.022     1      3      1       6   */
 /*                                                      |   select                  | 1.022     2      2      1       2   */
 /*                                                      |       ID                  | 1.022     3      2      1       8   */
 /*                                                      |      ,2       as day      | 1.024     1      2      2       9   */
 /*  data srdb;                                          |      ,AanD2   as  Aan     | 1.024     2      3      0       3   */
 /*   input ID                                           |      ,UvD2    as  UvD     | 1.024     3      3      0       9   */
 /*             AanD1 AanD2 AanD3                        |      ,FrqD2   as  FrqD    | 1.030     1      2      0       9   */
 /*             UvD1 UvD2 UvD3                           |   from                    | 1.030     2      2      1      10   */
 /*             FrqD1 FrqD2 FrqD3                        |       srdb                | 1.030     3      2      1      12   */
 /*   ;                                                  |   union                   | 1.031     1      3      1       5   */
 /*  cards4;                                             |       corr                | 1.031     2      1      2      12   */
 /*  1.012 1 2 2 0 1 2 14 12 13                          |   select                  | 1.031     3      1      0      11   */
 /*  1.014 2 3 3 2 2 2 7 5 8                             |       ID                  |                                     */
 /*  1.021 2 2 2 1 1 2 10 8 6                            |       ,3       as day     |                                     */
 /*  1.022 3 2 2 1 1 1 6 2 8                             |      ,AanD3   as  Aan     |                                     */
 /*  1.024 2 3 3 2 0 0 9 3 9                             |      ,UvD3    as  UvD     |                                     */
 /*  1.030 2 2 2 0 1 1 9 10 12                           |      ,FrqD3   as  FrqD    |                                     */
 /*  1.031 3 1 1 1 2 0 5 12 11                           |   from                    |                                     */
 /*  ;;;;                                                |       srdb                |                                     */
 /*  run;quit;                                           |   order                   |                                     */
 /*                                                      |       by id, day          |                                     */
 /*                                                      |                           |                                     */
 /*                                                      | ;quit;                    |                                     */
 /*                                                      |                           |                                     */
 /*                                                      |                           |                                     */
 /**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

libname sd1 "d:/sd1";
options validvarname=upcase;

data sd1.srdb;
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

/*                             _
/ |  ___  __ _ ___   ___  __ _| |
| | / __|/ _` / __| / __|/ _` | |
| | \__ \ (_| \__ \ \__ \ (_| | |
|_| |___/\__,_|___/ |___/\__, |_|
                            |_|
*/

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  SD1.SRDB total obs=7                                                                                                  */
/*                                                                                                                        */
/*                  Aan    Aan    Aan                            Frq    Frq    Frq                                        */
/*  Obs      ID      D1     D2     D3    UvD1    UvD2    UvD3     D1     D2     D3                                        */
/*                                                                                                                        */
/*   1     1.012     1      2      2       0       1       2      14     12     13                                        */
/*   2     1.014     2      3      3       2       2       2       7      5      8                                        */
/*   3     1.021     2      2      2       1       1       2      10      8      6                                        */
/*   4     1.022     3      2      2       1       1       1       6      2      8                                        */
/*   5     1.024     2      3      3       2       0       0       9      3      9                                        */
/*   6     1.030     2      2      2       0       1       1       9     10     12                                        */
/*   7     1.031     3      1      1       1       2       0       5     12     11                                        */
/*                                                                                                                        */
/**************************************************************************************************************************/

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
      sd1.srdb
  union
      corr
  select
      ID
     ,2       as day
     ,AanD2   as  Aan
     ,UvD2    as  UvD
     ,FrqD2   as  FrqD
  from
      sd1.srdb
  union
      corr
  select
      ID
      ,3       as day
     ,AanD3   as  Aan
     ,UvD3    as  UvD
     ,FrqD3   as  FrqD
  from
      sd1.srdb
  order
      by id, day

;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  WORK.WANT total obs=21                                                                                                */
/*                                                                                                                        */
/*  Obs   day    ID     Aan    UvD    FrqD                                                                                */
/*                                                                                                                        */
/*    1    1   1.012     1      0      14                                                                                 */
/*    2    2   1.012     2      1      12                                                                                 */
/*    3    3   1.012     2      2      13                                                                                 */
/*    ...                                                                                                                 */
/*   19    1   1.031     1      0      11                                                                                 */
/*   20    2   1.031     1      2      12                                                                                 */
/*   21    3   1.031     3      1       5                                                                                 */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*___                              _
|___ \   ___  __ _ ___   ___  __ _| |   __ _ _ __ _ __ __ _ _   _ ___
  __) | / __|/ _` / __| / __|/ _` | |  / _` | `__| `__/ _` | | | / __|
 / __/  \__ \ (_| \__ \ \__ \ (_| | | | (_| | |  | | | (_| | |_| \__ \
|_____| |___/\__,_|___/ |___/\__, |_|  \__,_|_|  |_|  \__,_|\__, |___/
                                |_|                         |___/
*/

proc datasets lib=sd1 nodetails nolist;
 delete want;
run;quit;

%array(_ary,values=1-3);

proc sql;
  create
     table want as
  %do_over(_ary,phrase=%str(
      select
          ID
         ,?       as  day
         ,AanD?   as  Aan
         ,UvD?    as  UvD
         ,FrqD?   as  FrqD
      from
          sd1.srdb ), between=union corr)
  order
      by id, day
 ;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  WORK.WANT total obs=21                                                                                                */
/*                                                                                                                        */
/*  Obs   day    ID     Aan    UvD    FrqD                                                                                */
/*                                                                                                                        */
/*    1    1   1.012     1      0      14                                                                                 */
/*    2    2   1.012     2      1      12                                                                                 */
/*    3    3   1.012     2      2      13                                                                                 */
/*    ...                                                                                                                 */
/*   19    1   1.031     1      0      11                                                                                 */
/*   20    2   1.031     1      2      12                                                                                 */
/*   21    3   1.031     3      1       5                                                                                 */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*____                    _
|___ /   _ __   ___  __ _| |
  |_ \  | `__| / __|/ _` | |
 ___) | | |    \__ \ (_| | |
|____/  |_|    |___/\__, |_|
                       |_|
*/

proc datasets lib=sd1 nodetails nolist;
 delete want;
run;quit;

%utl_rbeginx;
parmcards4;
library(haven)
library(sqldf)
source("c:/oto/fn_tosas9x.R")
srdb<-read_sas("d:/sd1/srdb.sas7bdat")
want<-sqldf('
  select
      ID
     ,1       as day
     ,AanD1   as  Aan
     ,UvD1    as  UvD
     ,FrqD1   as  FrqD
  from
      srdb
  union
      all
  select
      ID
     ,2       as day
     ,AanD2   as  Aan
     ,UvD2    as  UvD
     ,FrqD2   as  FrqD
  from
      srdb
  union
      all
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
')
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

proc print data=sd1.want;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* R                                                                                                                      */
/*                                                                                                                        */
/* > want                                                                                                                 */
/*       ID day Aan UvD FrqD                                                                                              */
/* 1  1.012   1   1   0   14                                                                                              */
/* 2  1.012   2   2   1   12                                                                                              */
/* 3  1.012   3   2   2   13                                                                                              */
/* ....                                                                                                                   */
/* 19 1.031   1   3   1    5                                                                                              */
/* 20 1.031   2   1   2   12                                                                                              */
/* 21 1.031   3   1   0   11                                                                                              */
/*                                                                                                                        */
/*                                                                                                                        */
/*   rownames      ID     day    Aan    UvD    FrqD                                                                       */
/*                                                                                                                        */
/*       1       1.012     1      1      0      14                                                                        */
/*       2       1.012     2      2      1      12                                                                        */
/*       3       1.012     3      2      2      13                                                                        */
/*      ....                                                                                                              */
/*      19       1.031     1      3      1       5                                                                        */
/*      20       1.031     2      1      2      12                                                                        */
/*      21       1.031     3      1      0      11                                                                        */
/*                                                                                                                        */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*  _                      _
| || |    _ __   ___  __ _| |   __ _ _ __ _ __ __ _ _   _ ___
| || |_  | `__| / __|/ _` | |  / _` | `__| `__/ _` | | | / __|
|__   _| | |    \__ \ (_| | | | (_| | |  | | | (_| | |_| \__ \
   |_|   |_|    |___/\__, |_|  \__,_|_|  |_|  \__,_|\__, |___/
                        |_|                         |___/
*/

proc datasets lib=sd1 nodetails nolist;
 delete want;
run;quit;

%array(_ary,values=1-3);

%utl_submit_r64x('
library(haven);
library(sqldf);
source("c:/oto/fn_tosas9x.R");
srdb<-read_sas("d:/sd1/srdb.sas7bdat");
want<-sqldf("
  %do_over(_ary,phrase=%str(
      select
          ID
         ,?       as  day
         ,AanD?   as  Aan
         ,UvD?    as  UvD
         ,FrqD?   as  FrqD
      from
          srdb), between=union all)");
want;
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     );
',resolve=Y);

proc print data=sd1.want;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  R                                                                                                                     */
/*                                                                                                                        */
/*  > want                                                                                                                */
/*        ID day Aan UvD FrqD                                                                                             */
/*  1  1.012   1   1   0   14                                                                                             */
/*  2  1.012   2   2   1   12                                                                                             */
/*  3  1.012   3   2   2   13                                                                                             */
/*  ....                                                                                                                  */
/*  19 1.031   1   3   1    5                                                                                             */
/*  20 1.031   2   1   2   12                                                                                             */
/*  21 1.031   3   1   0   11                                                                                             */
/*                                                                                                                        */
/* SAS                                                                                                                    */
/*                                                                                                                        */
/*  rownames      ID     day    Aan    UvD    FrqD                                                                        */
/*                                                                                                                        */
/*      1       1.012     1      1      0      14                                                                         */
/*      2       1.012     2      2      1      12                                                                         */
/*      3       1.012     3      2      2      13                                                                         */
/*     ....                                                                                                               */
/*     19       1.031     1      3      1       5                                                                         */
/*     20       1.031     2      1      2      12                                                                         */
/*     21       1.031     3      1      0      11                                                                         */
/*                                                                                                                        */
/*                                                                                                                        */
/**************************************************************************************************************************/

proc datasets lib=sd1 nodetails nolist;
 delete want;
run;quit;

/*___                _   _                             _
| ___|   _ __  _   _| |_| |__   ___  _ __    ___  __ _| |
|___ \  | `_ \| | | | __| `_ \ / _ \| `_ \  / __|/ _` | |
 ___) | | |_) | |_| | |_| | | | (_) | | | | \__ \ (_| | |
|____/  | .__/ \__, |\__|_| |_|\___/|_| |_| |___/\__, |_|
        |_|    |___/                                |_|
*/

%utl_pybeginx;
parmcards4;
import pyperclip
import os
from os import path
import sys
import subprocess
import time
import pandas as pd
import pyreadstat as ps
import numpy as np
import pandas as pd
from pandasql import sqldf
mysql = lambda q: sqldf(q, globals())
from pandasql import PandaSQL
pdsql = PandaSQL(persist=True)
sqlite3conn = next(pdsql.conn.gen).connection.connection
sqlite3conn.enable_load_extension(True)
sqlite3conn.load_extension('c:/temp/libsqlitefunctions.dll')
mysql = lambda q: sqldf(q, globals())
exec(open('c:/temp/fn_tosas9.py').read())
srdb, meta = ps.read_sas7bdat("d:/sd1/srdb.sas7bdat")
want = pdsql("""
  select
      ID
     ,1       as day
     ,AanD1   as  Aan
     ,UvD1    as  UvD
     ,FrqD1   as  FrqD
  from
      srdb
  union
      all
  select
      ID
     ,2       as day
     ,AanD2   as  Aan
     ,UvD2    as  UvD
     ,FrqD2   as  FrqD
  from
      srdb
  union
      all
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
""")
print(want)
fn_tosas9(
   want
   ,dfstr="want"
   ,timeest=3
   )
;;;;
%utl_pyendx;

libname tmp "c:/temp";
proc print data=tmp.want;
run;quit;


/**************************************************************************************************************************/
/*                                                                                                                        */
/*  Python                                                                                                                */
/*  ======                                                                                                                */
/*                                                                                                                        */
/*         ID  day  Aan  UvD  FrqD                                                                                        */
/*  0   1.012    1  1.0  0.0  14.0                                                                                        */
/*  1   1.012    2  2.0  1.0  12.0                                                                                        */
/*  2   1.012    3  2.0  2.0  13.0                                                                                        */
/*  ....                                                                                                                  */
/*  18  1.031    1  3.0  1.0   5.0                                                                                        */
/*  19  1.031    2  1.0  2.0  12.0                                                                                        */
/*  20  1.031    3  1.0  0.0  11.0                                                                                        */
/*                                                                                                                        */
/* SAS                                                                                                                    */
/* ===                                                                                                                    */
/*                                                                                                                        */
/*     ID     day    Aan    UvD    FrqD                                                                                   */
/*                                                                                                                        */
/*   1.012     1      1      0      14                                                                                    */
/*   1.012     2      2      1      12                                                                                    */
/*   1.012     3      2      2      13                                                                                    */
/*   1.014     1      2      2       7                                                                                    */
/*   1.014     2      3      2       5                                                                                    */
/*   1.014     3      3      2       8                                                                                    */
/*   1.021     1      2      1      10                                                                                    */
/*   1.021     2      2      1       8                                                                                    */
/*   1.021     3      2      2       6                                                                                    */
/*   1.022     1      3      1       6                                                                                    */
/*   1.022     2      2      1       2                                                                                    */
/*   1.022     3      2      1       8                                                                                    */
/*   1.024     1      2      2       9                                                                                    */
/*   1.024     2      3      0       3                                                                                    */
/*   1.024     3      3      0       9                                                                                    */
/*   1.030     1      2      0       9                                                                                    */
/*   1.030     2      2      1      10                                                                                    */
/*   1.030     3      2      1      12                                                                                    */
/*   1.031     1      3      1       5                                                                                    */
/*   1.031     2      1      2      12                                                                                    */
/*   1.031     3      1      0      11                                                                                    */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*__              _       _           _
 / /_    _ __ ___| | __ _| |_ ___  __| |  _ __ ___ _ __   ___  ___
| `_ \  | `__/ _ \ |/ _` | __/ _ \/ _` | | `__/ _ \ `_ \ / _ \/ __|
| (_) | | | |  __/ | (_| | ||  __/ (_| | | | |  __/ |_) | (_) \__ \
 \___/  |_|  \___|_|\__,_|\__\___|\__,_| |_|  \___| .__/ \___/|___/
                                                  |_|
*/

https://github.com/rogerjdeangelis/utl-adding-sequence-numbers-and-partitions-in-SAS-sql-without-using-monotonic
https://github.com/rogerjdeangelis/utl-create-equally-spaced-values-using-partitioning-in-sql-wps-r-python
https://github.com/rogerjdeangelis/utl-find-first-n-observations-per-category-using-proc-sql-partitioning
https://github.com/rogerjdeangelis/utl-macro-to-enable-sql-partitioning-by-groups-montonic-first-and-last-dot
https://github.com/rogerjdeangelis/utl-partitioning-your-table-for-a-big-parallel-systask-sort
https://github.com/rogerjdeangelis/utl-pivot-long-pivot-wide-transpose-partitioning-sql-arrays-wps-r-python
https://github.com/rogerjdeangelis/utl-pivot-transpose-by-id-using-wps-r-python-sql-using-partitioning
https://github.com/rogerjdeangelis/utl-top-four-seasonal-precipitation-totals--european-cities-sql-partitions-in-wps-r-python
https://github.com/rogerjdeangelis/utl-transpose-pivot-wide-using-sql-partitioning-in-wps-r-python
https://github.com/rogerjdeangelis/utl-transposing-rows-to-columns-using-proc-sql-partitioning
https://github.com/rogerjdeangelis/utl-transposing-words-into-sentences-using-sql-partitioning-in-r-and-python
https://github.com/rogerjdeangelis/utl-using-DOW-loops-to-identify-different-groups-and-partition-data
https://github.com/rogerjdeangelis/utl-using-sql-in-wps-r-python-select-the-four-youngest-male-and-female-students-partitioning
https://github.com/rogerjdeangelis/utl_partition_a_list_of_numbers_into_3_groups_that_have_the_similar_sums_python
https://github.com/rogerjdeangelis/utl_partition_a_list_of_numbers_into_k_groups_that_have_the_similar_sums
https://github.com/rogerjdeangelis/utl_scalable_partitioned_data_to_find_statistics_on_a_column_by_a_grouping_variable

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
