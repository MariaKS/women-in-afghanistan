///Survey of Afghan Peeps 2015

svyset psu [pweight= W10_wgt3], strata(Strata)

drop if m8!=2015

**admin variables
drop i1 i2 m2 m5 m6a m6b m9 m10 m11 m12 m13 m14 m15_hh m15_mm m16_hh m16_mm m17 m18 m19

*Only 2015 remaining
drop m8

gen province=" "

replace province="Badakhshan" if m7==14replace province="Badghis" if m7==23replace province="Baghlan" if m7==16replace province="Balkh" if m7==18replace province="Bamyan" if m7==32replace province="Daykundi" if m7==34replace province="Farah" if m7==25replace province="Faryab" if m7==22replace province="Ghazni" if m7==6replace province="Ghor" if m7==31replace province="Helmand" if m7==27replace province="Herat" if m7==24replace province="Jawzjan" if m7==20replace province="Kabul" if m7==1replace province="Kandahar" if m7==28replace province="Kapisa" if m7==2replace province="Khost" if m7==9replace province="Kunarha" if m7==12replace province="Kunduz" if m7==17replace province="Laghman" if m7==11replace province="Logar" if m7==5replace province="Nangarhar" if m7==10replace province="Nimroz" if m7==26replace province="Nooristan" if m7==13replace province="Paktika" if m7==8replace province="Paktya" if m7==7replace province="Panjsher" if m7==33replace province="Parwan" if m7==3replace province="Samangan" if m7==19replace province="Sar-e-Pul" if m7==21replace province="Takhar" if m7==15replace province="Urozgan" if m7==30replace province="Wardak" if m7==4replace province="Zabul" if m7==29

* not asked in 2015
*drop x277 x278 x279 x200 x1a x1b x1c x1d x1e x1f x1g x1h x2 x3a x3b x3c x3d x3e x3f x3g x3h
*drop x350 x351 x154 x201a x201b x202 x203 x204a x204b x205 x206 x258 x259
*drop x352a x352b x352c x352d x352e x352f x352g
*drop x9a x9b x9c x9d x9e x9f x9g x9_8 x9_9 x10a x10b x10c x10d x10e x10f x10g x10h x10i x10j

*DROP ALL THE VARS NOT ASKED IN 2015
ds, not(type string)
foreach varname of varlist `r(varlist)' {
	quietly sum `varname'
	if `r(N)'==0 {
		drop `varname'
		disp "dropped `varname' for too much missing data"
	}
}

drop Wave

*Drop individual level stuff
drop z18 
drop m15 m16 m21
drop z11
drop eoi
drop z9
drop z13a
drop z6 z4
drop z43 z44 z45a z45b z46 z48 GeoCode
drop z2 z16 z17




*Cleaning

*Binary Yes = 1 No = 0
foreach x in x153a x153b x153c x153f {
	replace `x'=0 if `x'==2
	replace `x'=. if `x'==98
	replace `x'=. if `x'==99
} 
	
*If unemployment was a top 2 issue for people!
gen women_issue_unemployment=0
replace women_issue_unemployment=1 if x66==112 | x66==138
replace women_issue_unemployment=1 if x66b==112 | x66b==138

*place for women to talk about issues
replace x111a=1 if x111a==101
replace x111a=0 if x111a==102
replace x111a=. if x111a==999
replace x111a=. if x111a==998

*vars to drop
drop x111b x111c
drop x5a x5b x6a x6b x7a x7b x380a x380b
drop x11aa x11ab x11ae x11ai x11aj x11ak x11ac
drop x11an x11Ao x11Ap x11as x11at
drop x14a x14b x14c x14d x14e x14f x14g x14h


*afghan going in right or wrong direction
replace x4=0 if x4==102
replace x4=1 if x4==101
replace x4=. if x4==998
replace x4=. if x4==999

*biggest problem in local area - unemployment
gen problem_local_unemployment=0
replace problem_local_unemployment=1 if x8a==106
replace problem_local_unemployment=1 if x8b==106

*Satisfaction with services
foreach x in x353a x353b x353c x353d x353e x353f x353g {
	replace `x'=1 if `x'==1 | `x'==2
	replace `x'=0 if `x'==3 | `x'==4
	replace `x'=. if `x'==98 | `x'==99
}

*Fearing for your own personal safety/security 
replace x15B=1 if x15B==1 | x15B==2 | x15B==3
replace x15B=0 if x15B==4 | x15B==5
replace x15B=. if x15B==98 | x15B==99

*Victim of violence
replace x16=1 if x16==101
replace x16=0 if x16==102
replace x16=. if x16==998 | x16==999

drop x170a x170b x170c x170d x172_1a x172_1c x172_1d x17 x17b
drop x19 x19b x21 x22a


*violence
gen violence=0
replace violence=1 if x374==1 | x374==2 | x374==3
replace violence=. if x374==98 | x374==99
replace violence=0 if x374==4

drop x373 x372 x374 x376
drop x23a x23b x23d x23e x25a x25b x25c x25e x25f x25g x25h x26b x26c x26d x23c x25d x25i x26e x26f x26g x26h x25k x26i


*women working - allowed yes or no?
replace x68=0 if x68==2
replace x68=. if x68==8
replace x68=. if x68==9


*Where can women work?
foreach x in x367a x367b x367d x367e x367f x367g x367h x367i {
	replace `x'=1 if `x'==1 | `x'==2
	replace `x'=0 if `x'==3 | `x'==4
	replace `x'=. if `x'==98 | `x'==99
}

drop z38 z39a z39b z39c z39d z39e z39f z39g z39h z39i z39j z39k z40

*women in leadership positions
foreach x in x379a x379b x379c x379d x379e {
	replace `x'=1 if `x'==1 | `x'==2
	replace `x'=0 if `x'==3 | `x'==4
	replace `x'=. if `x'==98 | `x'==99
}

*best age to marry for a man and woman
replace x370=. if x370==98 | x370==99
replace x369=. if x369==98 | x369==99

drop x368 x69 
drop x117 x364
drop x64b x64d x64e x64f x65b x65c x65d x65e x64g
drop x79_1 x71a_2 x77a x75
drop x34x x34o x34q x34e x34j x34k x34n x34l x34y x34m x34t x34ab

drop x37a x37b x37c x37d
drop x377 x378
drop z49 z50a z50b z51a z51b z51c
drop x35f x35a x35d
drop x356

*women and educational opps
foreach x in x366a x366b x366c x366d x366e x366f z47 {
	replace `x'=1 if `x'==1 | `x'==2
	replace `x'=0 if `x'==3 | `x'==4
	replace `x'=. if `x'==98 | `x'==99
}

drop z7_1 z7_2 z7_3 z7_4 z7_5 z7_6 z7_7 z7_8 z7_9 z7_11 z7_12 z7_13 z7_16
drop z11 z20 z7_14 z7_15 z7_17 z31a z31b z14a z14b z14c z10 z13_1 z19

*vote in elections
replace x362=0 if x362==2
replace x362=. if x362==98
replace x362=. if x362==99

drop x363a x90_1 x90_2 x90_3 x90_96 x90_97 x90_99 x92 x93
drop x156a x156b
drop x147 x134a x134b x134c x134d
drop x135d x135e x135f x136
drop m20 
drop x82 x89
drop x18 x109 x36a x36d method method2 x146 x145 x144 x115b x115a x115 x115c
drop MergeWgt1 MergeWgt2 MergeWgt3 MergeWgt4
drop x65g

*religion and politics: Should religious leaders be consulted?
replace x88=1 if x88==101
replace x88=0 if x88==102
replace x88=. if x88==999
replace x88=. if x88==998

drop m1 m4 M22 MergeWgt7 MergeWgt8 MergeWgt5 MergeWgt6 W10_wgt4 W10_wgt6 W10_wgt5 W10_wgt7 W10_wgt8 W10_wgt1 W10_wgt2
drop z13_1 z19
drop z7_14 z7_15 z20 z7_17 z31a z31b z14a z14b z14c z10 z3

*percent of female who contribute to HH
replace z13b=1 if z13b==101
replace z13b=0 if z13b==102
replace z13b=. if z13b==999
replace z13b=. if z13b==998

*happiness z47- 0 no happy 1- happy

*women have equal opps as men
replace x67=1 if x67==101 | x67==102
replace x67=0 if x67==103 | x67==104
replace x67=. if x67==998 | x67==999


drop dis x8a x8b x66 x66b x36e


	
