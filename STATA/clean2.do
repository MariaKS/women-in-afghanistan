clear all
cd "/Users/lili/Documents/Harvard/Courses/Fall 2015/SYPA/data/Afghan_People 2015"

u "new_dataset.dta", clear
svyset psu [pweight=W10_wgt3], strata(Strata)
/*
preserve
tempfile all
collapse (mean) x153a x153b x153c x153f x4 x16 x88 x67 x68 z13b x111a x153g x153h ///
                x353a x353b x353c x353d x353e x353f x353g x362 x366a x366b x366c ///
                x366d x366e x366f x367a x367b x367d x367e x369 x370 z47 x15B x375 ///
                x367f x367g x367h x367i x379a x379b x379c x379d x379e[aw=W10_wgt3], by (province)
save `all'
restore           
*/

collapse (mean) x153a x153b x153c x153f x4 x16 x88 x67 x68 z13b x111a x153g x153h ///
                x353a x353b x353c x353d x353e x353f x353g x362 x366a x366b x366c ///
                x366d x366e x366f x367a x367b x367d x367e x369 x370 z47 x15B x375 ///
                x367f x367g x367h x367i x379a x379b x379c x379d x379e[aw=W10_wgt3], by (province z1)
                
recode z1 (1=0) (2=1)
label drop Z1

reshape wide x153a x153b x153c x153f x4 x16 x88 x67 x68 z13b x111a x153g x153h ///
                x353a x353b x353c x353d x353e x353f x353g x362 x366a x366b x366c ///
                x366d x366e x366f x367a x367b x367d x367e x369 x370 z47 x15B x375 ///
                x367f x367g x367h x367i x379a x379b x379c x379d x379e, i(province) j(z1)
/*                
merge 1:1 province using "`all'"
drop _m*/
rename province Province_Name
save "new_dataset2.dta", replace

u "new_dataset2.dta", clear
merge 1:m Province_Name using "/Users/lili/Documents/Harvard/Courses/Fall 2015/SYPA/data/NRVA 2011/NRVA12_All_clean5.dta"

gen province=trim(Province_Name)
drop Province_Name
order hhid HH_Mem_ID memid sex age hh_weight ind_weight woman_weight Province_Code province District_Code
drop _m
save "/Users/lili/Documents/Harvard/Courses/Fall 2015/SYPA/data/NRVA 2011/merged_dataset.dta", replace
