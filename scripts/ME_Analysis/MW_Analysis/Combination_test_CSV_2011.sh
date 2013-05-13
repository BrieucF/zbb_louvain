//! /bin/sh
echo
echo --------------------------------------------------------------------------------------------------------------------------------------------
echo 																		
echo ------------ Hello $USER -----------------------												
echo 																		
echo
echo --------- input File--------------														
echo
echo  ggToZbb Weight   : /home/fynu/arnaudp/scratch/MW_5/new_madweight/madweight/gg_Zbb_ee_2505012/Events/CSV_2011_ $1 _Cor0/CSV_2011_ $1 _Cor0_weights.out
echo  qqToZbb Weight   : /home/fynu/arnaudp/scratch/MW_5/new_madweight/madweight/qq_Zbb_ee_2505012/Events/CSV_2011_ $1 _Cor0/CSV_2011_ $1 _Cor0_weights.out
echo  ttbar   Weights  : /home/fynu/arnaudp/scratch/MW_5/new_madweight/madweight/tt_ee_2505012/Events/CSV_2011_ $1 _Cor2/CSV_2011_ $1 _Cor2_weights.out
echo  zz C0 Weight   : /home/fynu/arnaudp/scratch/MW_5/new_madweight/madweight/ZZ_C0_ee_2505012/Events/CSV_2011_ $1 _Cor0/CSV_2011_ $1 _Cor0_weights.out
echo  zz C3 Weight   : /home/fynu/arnaudp/scratch/MW_5/new_madweight/madweight/ZZ_C3_ee_2505012/Events/CSV_2011_ $1 _Cor3/CSV_2011_ $1 _Cor3_weights.out
echo  zh C0 Weight   : /home/fynu/arnaudp/scratch/MW_5/new_madweight/madweight/ZH_C0_ee_2505012/Events/CSV_2011_ $1 AllMH_Cor0/CSV_2011_ $1 _ee_AllMH_Cor0_weights.out
echo  zh C3 Weight   :/home/fynu/arnaudp/scratch/MW_5/new_madweight/madweight/ZH_ee_250512/Events/CSV_2011_ $1 AllMH_Cor3/CSV_2011_ $1 _ee_AllMH_Cor3_weights.out 
echo  LHCO file info   : /home/fynu/arnaudp/scratch/MW_5/inputFiles/JUNE_12/$2				
echo  Event info       : /home/fynu/arnaudp/scratch/MW_5/inputFiles/JUNE_12/$3 									
echo
echo -------- Sample info -------------													
echo  output name      : $1														
echo -------- Sample info -------------													
echo  is D-Y            = $5  0 or 1													
echo  channel           = $6  0 ee --- 1 mumu												
echo  Event to process  - $4														
echo -------- Executable ---------------												
echo       MW_analysis_All_Full_v7.C														
echo
echo --------------------------------------------------------------------------------------------------------------------------------------------
echo
echo
echo ---- Do you want to submit this job ? yes - no  -------
echo
read tag
echo
echo $tag

if [ "$tag" = "yes" ] ; then

root -l -b << EOF

gSystem->Load("libPhysics")
gSystem->Load("libEG")
gSystem->Load("ExRootAnalysis/lib/libExRootAnalysis.so")

TString file("$1")
TString file2("$2")
TString file3("$3")

TString gg;
TString qq;
TString tt;
TString zz_c0;
TString zz_c3;
TString hi_c0;
TString hi_c3;
TString LHCO;
TString EvtInfo;

int channel($6);
int isZbb4f($7);

if (channel==1){
  gg="/home/fynu/arnaudp/scratch/MW_5/new_madweight/madweight/gg_Zbb_mm_2505012/Events/CSV_2011_"+file+"_Cor0/CSV_2011_"+file+"_Cor0_weights.out";
  qq="/home/fynu/arnaudp/scratch/MW_5/new_madweight/madweight/qq_Zbb_mm_2505012/Events/CSV_2011_"+file+"_Cor0/CSV_2011_"+file+"_Cor0_weights.out";
  tt="/home/fynu/arnaudp/scratch/MW_5/new_madweight/madweight/tt_mm_250512/Events/CSV_2011_"+file+"_Cor2/CSV_2011_"+file+"_Cor2_weights.out";
  zz_c0="/home/fynu/arnaudp/scratch/MW_5/new_madweight/madweight/ZZ_C0_mm_2505012/Events/CSV_2011_"+file+"_Cor0/CSV_2011_"+file+"_Cor0_weights.out";
  zz_c3="/home/fynu/arnaudp/scratch/MW_5/new_madweight/madweight/ZZ_C3_mm_2505012/Events/CSV_2011_"+file+"_Cor3/CSV_2011_"+file+"_Cor3_weights.out";
  hi_c0="/home/fynu/arnaudp/scratch/MW_5/new_madweight/madweight/ZH_C0_mm_2505012/Events/CSV_2011_"+file+"_Cor0/CSV_2011_"+file+"_Cor0_weights.out";
  hi_c3="/home/fynu/arnaudp/scratch/MW_5/new_madweight/madweight/ZH_C3_mm_2505012/Events/CSV_2011_"+file+"_Cor3/CSV_2011_"+file+"_Cor3_weights.out";
  twb="/home/fynu/arnaudp/scratch/MW_5/new_madweight/madweight/twb_ee_2505012/Events/CSV_2011_"+file+"_Cor2/CSV_2011_"+file+"2_weights.out";
  LHCO="/home/fynu/arnaudp/scratch/MW_5/inputFiles/CSV_2011/";
  EvtInfo="/home/fynu/arnaudp/scratch/MW_5/inputFiles/CSV_2011/";
  
}
if (isZbb4f==0 && channel==1){
  gg="/home/fynu/cbeluffi/scratch/MW_5/June_2012/madweight/gg_Zbb_mumu_030413/Events/CSV_2011_"+file+"_Cor0/CSV_2011_"+file+"_Cor0_weights.out";
  qq="/home/fynu/cbeluffi/scratch/MW_5/June_2012/madweight/qq_Zbb_mumu_030413/Events/CSV_2011_"+file+"_Cor0/CSV_2011_"+file+"_Cor0_weights.out";
  tt="/home/fynu/cbeluffi/scratch/MW_5/June_2012/madweight/tt_mumu_030413/Events/CSV_2011_"+file+"_Cor2/CSV_2011_"+file+"_Cor2_weights.out";
  zz_c0="/home/fynu/cbeluffi/scratch/MW_5/June_2012/madweight/ZZ_C0_mumu_030413/Events/CSV_2011_"+file+"_Cor0/CSV_2011_"+file+"_Cor0_weights.out";
  zz_c3="/home/fynu/cbeluffi/scratch/MW_5/June_2012/madweight/ZZ_C3_mumu_030413/Events/CSV_2011_"+file+"_Cor3/CSV_2011_"+file+"_Cor3_weights.out";
  hi_c0="/home/fynu/cbeluffi/scratch/MW_5/June_2012/madweight/ZH_C0_mumu_030413/Events/CSV_2011_"+file+"_Cor0/CSV_2011_"+file+"_Cor0_weights.out";
  hi_c3="/home/fynu/cbeluffi/scratch/MW_5/June_2012/madweight/ZH_C3_mumu_030413/Events/CSV_2011_"+file+"_Cor3/CSV_2011_"+file+"_Cor3_weights.out";
  twb="/home/fynu/cbeluffi/scratch/MW_5/June_2012/madweight/twb_mumu_2505012/Events/CSV_2011_"+file+"_Cor2/CSV_2011_"+file+"2_weights.out";
  LHCO="/home/fynu/cbeluffi/scratch/MW_5/madweight/MW_Analysis/";
  EvtInfo="/home/fynu/cbeluffi/scratch/MW_5/madweight/MW_Analysis/";
}
if (channel==0){
  gg="/home/fynu/arnaudp/scratch/MW_5/new_madweight/madweight/gg_Zbb_ee_2505012/Events/CSV_2011_"+file+"_Cor0/CSV_2011_"+file+"_Cor0_weights.out";
  qq="/home/fynu/arnaudp/scratch/MW_5/new_madweight/madweight/qq_Zbb_ee_2505012/Events/CSV_2011_"+file+"_Cor0/CSV_2011_"+file+"_Cor0_weights.out";
  tt="/home/fynu/arnaudp/scratch/MW_5/new_madweight/madweight/tt_ee_2505012/Events/CSV_2011_"+file+"_Cor2/CSV_2011_"+file+"_Cor2_weights.out";
  zz_c0="/home/fynu/arnaudp/scratch/MW_5/new_madweight/madweight/ZZ_C0_ee_2505012/Events/CSV_2011_"+file+"_Cor0/CSV_2011_"+file+"_Cor0_weights.out";
  zz_c3="/home/fynu/arnaudp/scratch/MW_5/new_madweight/madweight/ZZ_C3_ee_2505012/Events/CSV_2011_"+file+"_Cor3/CSV_2011_"+file+"_Cor3_weights.out";
  hi_c0="/home/fynu/arnaudp/scratch/MW_5/new_madweight/madweight/ZH_C0_ee_2505012/Events/CSV_2011_"+file+"_Cor0/CSV_2011_"+file+"_Cor0_weights.out";
  hi_c3="/home/fynu/arnaudp/scratch/MW_5/new_madweight/madweight/ZH_ee_250512/Events/CSV_2011_"+file+"_Cor3/CSV_2011_"+file+"_Cor3_weights.out";
  twb="/home/fynu/arnaudp/scratch/MW_5/new_madweight/madweight/twb_ee_2505012/Events/CSV_2011_"+file+"_Cor2/CSV_2011_"+file+"2_weights.out";
  LHCO="/home/fynu/arnaudp/scratch/MW_5/inputFiles/CSV_2011/";
  EvtInfo="/home/fynu/arnaudp/scratch/MW_5/inputFiles/CSV_2011/";
  
}

if (isZbb4f==0 && channel==0){
  gg="/home/fynu/cbeluffi/scratch/MW_5/June_2012/madweight/gg_Zbb_ee_030413/Events/CSV_2011_"+file+"_Cor0/CSV_2011_"+file+"_Cor0_weights.out";
  qq="/home/fynu/cbeluffi/scratch/MW_5/June_2012/madweight/qq_Zbb_ee_030413/Events/CSV_2011_"+file+"_Cor0/CSV_2011_"+file+"_Cor0_weights.out";
  tt="/home/fynu/cbeluffi/scratch/MW_5/June_2012/madweight/tt_ee_030413/Events/CSV_2011_"+file+"_Cor2/CSV_2011_"+file+"_Cor2_weights.out";
  zz_c0="/home/fynu/cbeluffi/scratch/MW_5/June_2012/madweight/ZZ_C0_ee_030413/Events/CSV_2011_"+file+"_Cor0/CSV_2011_"+file+"_Cor0_weights.out";
  zz_c3="/home/fynu/cbeluffi/scratch/MW_5/June_2012/madweight/ZZ_C3_ee_030413/Events/CSV_2011_"+file+"_Cor3/CSV_2011_"+file+"_Cor3_weights.out";
  hi_c0="/home/fynu/cbeluffi/scratch/MW_5/June_2012/madweight/ZH_C0_ee_030413/Events/CSV_2011_"+file+"_Cor0/CSV_2011_"+file+"_Cor0_weights.out";
  hi_c3="/home/fynu/cbeluffi/scratch/MW_5/June_2012/madweight/ZH_C3_ee_030413/Events/CSV_2011_"+file+"_Cor3/CSV_2011_"+file+"_Cor3_weights.out";
  twb="/home/fynu/cbeluffi/scratch/MW_5/June_2012/madweight/twb_ee_2505012/Events/CSV_2011_"+file+"_Cor2/CSV_2011_"+file+"2_weights.out";
  LHCO="/home/fynu/cbeluffi/scratch/MW_5/madweight/MW_Analysis/";
  EvtInfo="/home/fynu/cbeluffi/scratch/MW_5/madweight/MW_Analysis/";
}


.L include.h
.L MW_analysis_All_Full_v7.C+ 

MWToRoot(gg,qq,tt,twb,zz_c3,zz_c0,hi_c3,hi_c0,LHCO+file2,EvtInfo+file3,file,$4,$5,$6,$7)
//cout<<"exit"<<endl

.q

EOF

fi