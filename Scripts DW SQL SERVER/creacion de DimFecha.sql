


/* DDL for the date dimension */
create table Date_Dimension (
date_key int not null,
full_date smalldatetime,
day_of_week tinyint,
day_num_in_month tinyint,
day_num_overall smallint,
day_name varchar(9),
day_abbrev varchar(3),
weekday_flag varchar(7),
week_num_in_year tinyint,
week_num_overall smallint,
week_begin_date smalldatetime,
week_begin_date_key int,
month tinyint,
month_num_overall smallint,
month_name varchar(12),
month_abbrev varchar(3),
quarter tinyint,
year smallint,
yearmo int,
fiscal_month tinyint,
fiscal_quarter tinyint,
fiscal_year smallint,
last_day_in_month_flag varchar(15),
same_day_year_ago_date smalldatetime,
primary key (date_key))
;

/* Lllenado de DimFecha */
insert into DimFecha
select date_key,full_date,day_name,month_name,day_num_in_month,week_num_in_year,[month],[quarter],[year] from Date_Dimension

