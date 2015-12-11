clear all
cd "/Users/lili/Documents/Harvard/Courses/Fall 2015/SYPA/data/NRVA 2011"

u "NRVA12_All.dta", clear

*recode Q_3_4 (1=0) (2=1) /*Female=1, Male=0*?*/
rename Q_3_4 sex
rename Q_3_5 age
drop working_age Q_24_6 Q_12_2
drop HH_No /*keep hhid*/

**create working-age pop. 15+
gen working_age=0
replace working_age=1 if (age>=18 & age<=49 & age!=.)
replace working_age=. if age==.
label drop working_age
label define working_age 1 "18-49" 0 "not in labor force"
label values working_age working_age
label var working_age "working age from 18 to 65"

****calculte labor force participation rate****
gen labor_force=0
replace labor_force=1 if Q_8_2==1
replace labor_force=1 if Q_8_3==1
replace labor_force=1 if Q_8_5==1
replace labor_force=1 if Q_8_6==1
replace labor_force=1 if Q_8_7==6 | Q_8_7==7 |  Q_8_7==8 |  Q_8_7==10 
label var labor_force "in labor force"

gen housewife=0
replace housewife=1 if Q_8_5==2
replace housewife=. if sex==0
****drop variable that doesnt make sense to me****
drop Q_11_7 Q_11_2 /*migration data*/
recode water_time (888=.)
recode Q_4_5 (7=.)
recode slum_dwelling safe_water overcrowding impr_sanitation durable_dwelling Q_8_8 Q_8_2 Q_8_3 Q_8_15 Q_8_14 Q_7_11 ///
       Q_6_6 Q_6_5 Q_6_28 Q_6_18 Q_6_17 Q_6_16 Q_6_1 Q_5_7 Q_5_6_Sheep Q_5_6_Poultry Q_5_6_Other Q_5_6_Goats Q_5_6_Cattle ///
       Q_5_5 Q_5_4 Q_5_12 Q_5_10 Q_5_1 Q_4_17 Q_4_12_Wind Q_4_12_Solar Q_4_12_Priv_Gen_Hydro Q_4_12_Priv_Gen_Engine Q_4_12_Gov_Generator ///
       Q_4_12_Electic_Grid Q_4_12_Comm_Gen_Hydro Q_4_12_Comm_Gen_Engine Q_4_12_Battery Q_3_8 Q_3_10 (2=0) /*Yes=1, No=0, slum_dwelling only has Yes and missing*/
recode Q_3_8 Q_3_10 (.=0)

/*married women question*/
recode Q_24_8 Q_24_5 (2=0) (1=1) 
recode Q_24_20 Q_24_15 (2=0) (1=1) (3=.)
recode Q_24_19 (6=.)
recode Q_24_18 (8=.)
recode Q_24_16 (9=.)
recode Q_24_14 (1=0) (2=1) /*Boy=0, Girl=1*/

***general living conditions***
recode Q_22_6_Women Q_22_6_Men Q_22_6_Girls Q_22_6_Boys Q_22_4_l Q_22_4_k Q_22_4_j Q_22_4_i Q_22_4_h Q_22_4_g Q_22_4_f Q_22_4_e /// 
       Q_22_4_d Q_22_4_c Q_22_4_b Q_22_4_a Q_22_3_l Q_22_3_k Q_22_3_j Q_22_3_i Q_22_3_h Q_22_3_g Q_22_3_f Q_22_3_e Q_22_3_d Q_22_3_c /// 
       Q_22_3_b Q_22_3_a Q_22_1 (2=0) (1=1) 

***shocks***
recode Q_13_3 Q_13_1_z Q_13_1_y Q_13_1_x Q_13_1_w Q_13_1_v Q_13_1_u Q_13_1_t Q_13_1_s Q_13_1_r Q_13_1_q Q_13_1_p Q_13_1_o Q_13_1_n Q_13_1_m ///
       Q_13_1_l Q_13_1_k Q_13_1_j Q_13_1_i Q_13_1_h Q_13_1_g Q_13_1_f Q_13_1_e Q_13_1_d Q_13_1_c Q_13_1_b Q_13_1_ad Q_13_1_ac Q_13_1_ab Q_13_1_aa ///
       Q_13_1_a (2=0) (1=1) 
       
***education***
recode Q_12_8 Q_12_5 Q_12_4 (2=0) (1=1) 
recode Q_12_3 (2=0)

drop Q_12_4 Q_12_5 Q_12_7 Q_12_9

***expense***
recode Q_10_49 (2=0) (1=1)

label drop yes_no
label define yes_no 1 "Yes" 0 "No"
label values slum_dwelling yes_no

****drop variable that doesnt make sense to me****
drop season month_field int_month_s int_month_c int_day_s int_day_c int_day_s int_day_c ///
	 calendar _merge Supervisor_Code Regional_Supervisor_No Q_8_7_Specify
drop int_year_s int_year_c Shura_id five_year ten_year major_year
drop Office_Editor_Code Office_Editing_Date Interviewers_No_Male Interviewers_No_Female ///
     Interview_Date Data_Entry_Officer_Code Data_Entry_Date
drop Q_8_8 Q_8_7 Q_8_6 Q_8_5 Q_8_4_Specify Q_8_4 Q_8_3  Q_8_15 Q_8_14
drop Q_8_9 Q_8_10 Q_8_11 Q_8_12 Q_8_13
*drop Q_8_2
drop Q_7_7_Mobile_Sold Q_7_7_Kitchen_Utensils_Sold Q_7_7_Gilim_Sold Q_7_7_Carpets_Sold ///
	 Q_7_7_Blankets_Sold Q_6_9 Q_6_33 Q_6_32_Specify Q_6_32 Q_6_31 Q_6_30_Specify Q_6_30 ///
	 Q_6_27 Q_6_26 Q_6_25 Q_6_24 Q_6_23 Q_6_22 Q_6_21 Q_6_15 Q_6_14 Q_6_13 Q_6_12 Q_6_11 Q_6_10
drop Q_5_2* Q_5_3* Q_5_4 Q_5_5 Q_5_6* Q_5_7 Q_5_11* Q_5_13* Q_5_9 Q_5_8
drop Q_4_18_Specify 

***married women***
drop Q_24_3 Q_24_2 Q_24_17_8

***Food consumption***
drop Q_23*

***shocks***
drop Q_13_4_Specify Q_13_2_Specify

***educaiton***
drop Q_12_6

***migratoin***
drop Q_11_*

***expense***
drop Q_10_51* Q_10_52* Q_10_53* Q_10_54* Q_10_55* Q_10_56* Q_10_57* Q_10_58* 
drop Q_10_40* Q_10_41* Q_10_42* Q_10_43* Q_10_44* Q_10_45* Q_10_46* Q_10_47* Q_10_48*
save "NRVA12_All_clean.dta", replace

***data management***
use "NRVA12_All_clean.dta", clear
sort hhid HH_Mem_ID
***household head***
gen head_male=0
replace head_male=1 if Q_3_3==1 & sex==0
label var head_male "Is the hh head male?"

br Respondents_Line_No hhid HH_Mem_ID sex working_age housewife head_male Q_3_9 Q_3_8 Q_3_7 Q_3_6 Q_3_3 Q_3_11 Q_3_10 Q_24_22 Q_24_9 Q_24_10
***children under 14***
gen child=0
replace child=1 if (age<=13 & age!=.)
gen daughter=0 
replace daughter=1 if child==1 & sex==1
gen son=0
replace son=1 if child==1 & sex==0

bys hhid Q_3_11: egen n_child=total(child)
bys hhid Q_3_11: egen n_daughter=total(daughter)
bys hhid Q_3_11: egen n_son=total(son)

***children under 5***
gen child_lq5=0
replace child_lq5=1 if (age<=5 & age!=.)
gen daughter_lq5=0 
replace daughter_lq5=1 if child_lq5==1 & sex==1
gen son_lq5=0
replace son_lq5=1 if child_lq5==1 & sex==0

bys hhid Q_3_11: egen n_child_lq5=total(child_lq5)
bys hhid Q_3_11: egen n_daughter_lq5=total(daughter_lq5)
bys hhid Q_3_11: egen n_son_lq5=total(son_lq5)

***children attending school***
bys hhid Q_3_11: gen child_sch=1 if child==1 & Q_12_8==1
bys hhid Q_3_11: egen n_child_sch=total(child_sch)

drop daughter son child_lq5 daughter_lq5 son_lq5 child_sch

preserve
tempfile child
keep hhid HH_Mem_ID sex age working_age child Q_3_11 n_child n_daughter n_son n_child_lq5 n_daughter_lq5 n_son_lq5 n_child_sch
br
keep if child==1
keep hhid Q_3_11 n_child n_daughter n_son n_child_lq5 n_daughter_lq5 n_son_lq5 n_child_sch
drop if Q_3_11==.
rename Q_3_11 HH_Mem_ID
duplicates drop hhid HH_Mem_ID, force
save `child'
restore

drop n_child n_daughter n_son n_child_lq5 n_daughter_lq5 n_son_lq5 n_child_sch
merge 1:1 hhid HH_Mem_ID using "`child'"
drop if _m==2
br hhid HH_Mem_ID sex working_age n_child n_daughter n_son n_child_lq5 n_daughter_lq5 n_son_lq5 n_child_sch
br hhid HH_Mem_ID n_child_lq5 Q_24_22
br

gen child_sch=0 if n_child_sch==0
replace child_sch=1 if n_child_sch!=0 & n_child_sch!=.

label var n_child "number of children under or equal to 14 in HH"
label var n_daughter "number of daughters under or equal to 14 in HH"
label var n_son "number of sons under or equal to 14 in HH"
label var n_child_lq5 "number of children under or equal to 5 in HH"
label var n_daughter_lq5  "number of daughters under or equal to 5 in HH"
label var n_son_lq5 "number of sons under or equal to 5 in HH"
label var n_child_sch "number of children are in school in HH"
label var child_sch "Is at least one of your children in school in HH?"

drop if child==1
drop child _m

***husband***
preserve
tempfile husband
keep hhid HH_Mem_ID Q_3_3 Q_3_6 Q_24_4 sex working_age labor_force age head_male ///
	 attendance highest_education attainment school_attending Q_12_8 school_attending ///
	 Q_8_2 /*Q_8_9 Q_8_10 Q_8_11 Q_8_12 Q_8_13*/
order hhid HH_Mem_ID Q_3_3 Q_3_6 Q_24_4

gen husband=0
replace husband=1 if sex==0 & (Q_3_6==1 | Q_3_6==2 | Q_3_6==3)
keep if husband==1

foreach x in age labor_force attendance highest_education attainment school_attending Q_8_2 /*Q_8_9 Q_8_10 Q_8_11 Q_8_12 Q_8_13*/ Q_12_8 {
gen husband_`x'=`x'
drop `x'
}

drop Q_24_4
gen Q_24_4=HH_Mem_ID
drop HH_Mem_ID
duplicates drop hhid Q_24_4, force
save `husband'
restore

merge m:1 hhid Q_24_4 using "`husband'"
drop if _m==2
drop _m

br hhid HH_Mem_ID Q_3_3 Q_3_6 Q_24_4 sex working_age labor_force age head_male husband_*
br
***householdhead***
preserve
tempfile head
keep hhid HH_Mem_ID Q_3_3 sex working_age labor_force age head_male ///
	 attendance highest_education attainment school_attending Q_12_8 school_attending ///
	 Q_8_2 /*Q_8_9 Q_8_10 Q_8_11 Q_8_12 Q_8_13*/
keep if Q_3_3==1
foreach x in age labor_force attendance highest_education attainment school_attending Q_8_2 /*Q_8_9 Q_8_10 Q_8_11 Q_8_12 Q_8_13*/ Q_12_8 {
gen head_`x'=`x'
drop `x'
}
drop HH_Mem_ID Q_3_3
duplicates drop hhid, force
br hhid head_*
br
save `head'
restore

merge m:1 hhid using "`head'"
drop if _m==2
drop _m

br hhid HH_Mem_ID Q_3_3 Q_3_6 Q_24_4 sex working_age labor_force age head_male head_*
br
drop if sex==0
keep if working_age==1
save "NRVA12_All_clean4.dta", replace

**************************************************************************************
u "NRVA12_All_clean4.dta", clear

keep if Q_3_6==1 | Q_3_6==2 | Q_3_6==3

drop Q_3_7 Q_3_9 Q_3_11 Q_8_2 husband
drop Q_12_8 school_age attendance Q_24_4 Q_24_11 Q_24_12 Q_24_14
drop Q_24_13
drop Q_24_17_1 Q_24_17_2 Q_24_17_3 Q_24_17_4 Q_24_17_5 Q_24_17_6 Q_24_17_7

foreach x in attainment safe_water overcrowding impr_sanitation durable_dwelling slum_dwelling ///
             Q_12_3 Q_24_5 Q_24_8 Q_24_10 Q_24_9 n_child n_daughter n_son n_child_lq5 n_daughter_lq5 n_son_lq5 n_child_sch child_sch ///
             Q_24_15 Q_24_16 Q_24_20 Q_5_12 husband_labor_force head_labor_force {
replace `x'=0 if `x'==.
}

replace Q_6_2=0 if Q_6_1==0
replace Q_6_3=0 if Q_6_1==0
replace Q_6_4=0 if Q_6_1==0

foreach x in Q_4_12_Electic_Grid Q_4_12_Gov_Generator Q_4_12_Priv_Gen_Engine ///
        Q_4_12_Priv_Gen_Hydro Q_4_12_Comm_Gen_Engine Q_4_12_Comm_Gen_Hydro Q_4_12_Solar ///
        Q_4_12_Wind Q_4_12_Battery Q_6_1 Q_6_2 Q_6_3 Q_6_4 Q_6_6 Q_6_18 Q_6_28 ///
        Q_4_15_Electicity Q_4_15_Gas Q_4_15_Fule Q_4_15_Firewood Q_4_15_Charcoal Q_4_15_Ping ///
        Q_7_6_Blankets_Own Q_7_6_Mobile_Own Q_7_6_Gilim_Own Q_7_6_Carpets_Own Q_7_8 Q_7_9 Q_7_11 Q_7_12 {
replace `x'=0 if `x'==.
}


foreach x in husband_Q_8_2 head_Q_8_2 Q_10_13 Q_10_3 Q_10_6 Q_10_14 Q_10_2 Q_10_1 Q_10_16 Q_10_12 Q_10_10 ///
             Q_10_5 Q_10_15 Q_10_18 Q_10_17 Q_10_11 Q_10_8 Q_10_7 Q_10_19 Q_10_4 Q_10_9{
replace `x'=0 if `x'==.
}

foreach x in Q_13_4_k Q_13_1_g Q_13_1_d Q_13_4_f Q_13_1_ab Q_13_1_f Q_13_4_j Q_13_4_o Q_13_4_h Q_13_1_p Q_13_1_y ///
             Q_13_4_i Q_13_1_w Q_13_4_b Q_13_1_i Q_13_1_i Q_13_1_a Q_13_1_b Q_13_4_c Q_13_1_c Q_13_1_j Q_13_1_e ///
             Q_13_1_u Q_13_1_t Q_13_1_r Q_13_1_v Q_13_1_n Q_13_1_s Q_13_1_l Q_13_1_ad Q_13_1_ac Q_13_1_h Q_13_1_o Q_13_1_q Q_13_1_m ///
             Q_13_1_k Q_13_1_aa Q_13_1_z Q_13_1_x Q_13_4_g Q_13_4_e Q_13_4_q Q_13_1_e Q_13_4_a Q_13_1_u Q_13_1_t Q_13_1_r Q_13_1_v Q_13_1_n Q_13_1_s Q_13_1_l ///
             Q_13_4_l Q_13_1_ad Q_13_1_ac Q_13_1_h Q_13_4_n Q_13_4_m Q_13_4_d Q_13_4_p Q_13_3 {
replace `x'=0 if `x'==.
}     

foreach x in Q_22_1 Q_22_3_e Q_22_3_g Q_22_3_h Q_22_3_f Q_22_3_k Q_22_3_a Q_22_3_b Q_22_3_d Q_22_3_j Q_22_3_i Q_22_3_c Q_22_3_l ///
             Q_22_10 Q_22_11 {
replace `x'=0 if `x'==.
}     

foreach mis in Q_24_7 Q_24_22 Q_4_10 Q_22_10 Q_22_11 Q_22_12 woman_weight husband_age head_age {
sum `mis' [aweight=woman_weight]
replace `mis'=r(mean) if `mis'==.
}

recode Q_22_8 Q_22_9 (1 2=2) (3=1) (4 5=0) (.=1) /*0=not satisfied 1=indifferent 2=satisfied*/
label drop police
label drop security

recode Q_13_4_a Q_13_4_b Q_13_4_c Q_13_4_d Q_13_4_e Q_13_4_f Q_13_4_g Q_13_4_h Q_13_4_i Q_13_4_j ///
       Q_13_4_k Q_13_4_l Q_13_4_m Q_13_4_n Q_13_4_o Q_13_4_p Q_13_4_q (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 =1)
 
recode Q_13_5 (2=0) (1=1)
replace Q_13_5=0 if Q_13_5==.

*rename vars:
/*rename Q_3_3 relationHH_Q_3_3
rename Q_24_19 
rename Q_3_6 maritalstatus_Q_3_6
rename Q_3_8 dadinHH_Q_3_8
rename Q_3_10 mominHH_Q_3_8
rename Q_12_3 literate_Q_12_3
rename Q_24_5 polygamy_Q_24_5
rename Q_24_7 marryage_Q_24_7
rename Q_24_8 childbirth_Q_24_8
rename Q_24_9 boysborn_Q_24_9
rename Q_24_10 girlsborn_Q_24_10
rename Q_24_15 ANC_Q_24_15
rename Q_24_16 numberANC_Q_24_16*/


* categorical to binary:
recode highest_education highest_education_adult attainment Q_3_6 Resident_Location_Code head_attainment husband_attainment ///
       Q_24_18 Q_4_2 Q_4_3 Q_4_4 Q_4_9 Q_4_11 Q_4_13 Q_4_14 Q_4_16 Q_4_18 Q_22_8 Q_22_9 (.=9999)

***Q_3***
foreach x in highest_education highest_education_adult attainment Q_3_6 Resident_Location_Code head_attainment husband_attainment {
tab `x', gen(`x')
drop `x'
}

***Houshing****
foreach x in Q_24_18 Q_4_2 Q_4_3 Q_4_4 Q_4_9 Q_4_11 Q_4_13 Q_4_14 Q_4_16 Q_4_18 {
tab `x', gen(`x')
drop `x'
}

gen birthcert_child=1
replace birthcert_child=0 if Q_24_23==0
replace birthcert_child=0 if Q_24_23==.
drop Q_24_23

**Q_22**
foreach x in Q_22_8 Q_22_9 {
tab `x', gen(`x')
drop `x'
}

drop school_attending husband_school_attending husband_attendance head_attendance head_school_attending water_time Respondents_Line_No ///
     husband_highest_education head_highest_education
***Q_3*** 
drop Q_3_3 Q_4_1

***Q_6***
drop Q_6_5 Q_6_7 Q_6_8 Q_6_16 Q_6_17 Q_6_19 Q_6_20 Q_6_29 Q_6_34_*

**Housing**
drop Q_4_5 Q_4_6 Q_4_7 Q_4_8 Q_4_17 Q_4_19

*child illness vars
drop Q_24_24 Q_24_25 Q_24_26 Q_24_27 Q_24_28 

*Q9**
drop Q_9_1 Q_9_7 Q_9_2 Q_9_8 Q_9_4 Q_9_6 Q_9_3 Q_9_5 Q_9_9

*other vars to drop
drop Q_24_19
drop Q_24_21

*spending Q10**
drop Q_10_37 Q_10_31 Q_10_34 Q_10_22 Q_10_35 Q_10_21 Q_10_29 Q_10_32 ///
     Q_10_27 Q_10_26 Q_10_25 Q_10_23 Q_10_24 Q_10_36 Q_10_30 Q_10_33 Q_10_28 Q_10_49
     
drop husband_Q_12_8 head_Q_12_8

***Q13**
drop Q_13_2 Q_13_6* Q_13_7 Q_13_8 Q_13_9

**condiiton**
drop Q_22_4_* Q_22_5_* Q_22_6_* Q_22_2 Q_22_7


save "NRVA12_All_clean5.dta", replace


