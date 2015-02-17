from ROOT import *
from listForRDS import lumi
import array
import os

gROOT.SetBatch()

class options_():
    #list of samples
    samples = [
        #"DATA",
        "DYjets",
        "TTFullLept",
        "TTSemiLept",
        "ZZ",
        "WZ",
        "WW",
        "Wt",
        "Wtbar",
        "ZH125",
#        "ZA_350_70",
        ]

    #SYST = "Nominal" 
    #SYST = "JESup" 
    #SYST = "JESdown" 
    #SYST = "JERup" 
    #SYST = "JERdown" 
    #SYST = "BTAG_bc_up" 
    #SYST = "BTAG_bc_down" 
    SYST = "BTAG_light_up" 
    #SYST = "BTAG_light_down" 
	
    #template for file name
    #path = "/nfs/user/acaudron/ControlPlots/cp5314p1/latestRDS/NAME_Summer12_final_skimedLL.root"
    #path = "/home/fynu/amertens/storage/Zbb_Analysis/"+Condition+"_Syst/RDS_NAME/NAME_Summer12_final_skimedLL.root"
    path_data = "/nfs/user/acaudron/ControlPlots/cp5314p1/AllRDS/Nominal/RDS_NAME/NAME_Summer12_final_skimed_zmet.root"
    path = "/nfs/user/acaudron/ControlPlots/cp5314p1/AllRDS/"+SYST+"/RDS_NAME/NAME_Summer12_final_skimed_zmet.root"
    #option to split or not the DY sample
    doDYsplit = True
    #stages
    stages = {
        "Mu" : "rc_stage_8_idx",
        "El" : "rc_stage_19_idx"
        }
    print "stages:", stages
    #BTAG weight
    BTAG = "btaggingReweightingMM"
    print "BTAG:", BTAG
    #define cuts
    presel = "("+stages["El"]+"_idx || "+stages["Mu"]+"_idx)"
    
    rangeMassA = []
    mbb=10
    for i in range(1,36):
      dmbb=0.15*mbb*1.5
      step_mbb = dmbb/1.5
      rangeMassA.append([int(mbb-dmbb),int(mbb+dmbb),int(mbb)])
      mbb+=step_mbb

    rangeMassH = []
    mllbb=10
    for i in range(1,36):
      dmllbb=0.15*mllbb*1.5
      step_mllbb = dmllbb/1.5
      rangeMassH.append([int(mllbb-dmllbb),int(mllbb+dmllbb),int(mllbb)])
      mllbb+=step_mllbb

    cut = {}
    mA_list = {}
    mA_list_down = {}
    mA_list_up = {}
    mH_list = {}
    mH_list_down = {}
    mH_list_up = {}

    for mA in rangeMassA:
        for mH in rangeMassH:
            key = "mA"+str(mA[0])+"to"+str(mA[1])+"_mH"+str(mH[0])+"to"+str(mH[1])
            cut[key] = "boostselectiondijetM>="+str(mA[0])+"&&boostselectiondijetM<"+str(mA[1])+"&&boostselectionZbbM>="+str(mH[0])+"&&boostselectionZbbM<"+str(mH[1])
            mA_list[key] = mA[2]
            mA_list_down[key] = mA[0]
            mA_list_up[key] = mA[1]
            mH_list[key] = mH[2]
            mH_list_down[key] = mH[0]
            mH_list_up[key] = mH[1]

            print "signal regions:", key, cut[key]
    #categories
    categories = {
        "Mu" : stages["Mu"],
        "El" : stages["El"],
        #"El2j" : stages["El"]+"&&jetmetnj==2",
        #"El3j" : stages["El"]+"&&jetmetnj>2",
        #"Mu2j" : stages["Mu"]+"&&jetmetnj==2",
        #"Mu3j" : stages["Mu"]+"&&jetmetnj>2"
        }

    BTAG = "*"+BTAG
    #define reweighting formula              
    baseForm = "*leptonsReweightingweight*lumiReweightingLumiWeight*mcReweightingweight"+BTAG
    rewForm = {"Mu":baseForm,"El":baseForm}

    wZbb  = "( abs(jetmetbjet1Flavor)==5 && abs(jetmetbjet2Flavor)==5 && jetmetnj==2 )"
    wZbbj = "( abs(jetmetbjet1Flavor)==5 && abs(jetmetbjet2Flavor)==5 && jetmetnj>2 )"
    wZbx  = "( (abs(jetmetbjet1Flavor)!=5 && abs(jetmetbjet2Flavor)==5) || (abs(jetmetbjet1Flavor)==5 && abs(jetmetbjet2Flavor)!=5) )"
    wZxx  = "( abs(jetmetbjet1Flavor)!=5 && abs(jetmetbjet2Flavor)!=5 )"
    wtt   = "*1.05"
    #wdy   = "*("+wZbb+"+"+wZbbj+"+"+wZbx+"+"+wZxx+")"

    TTBKG = [1.00,1.02,1.00,0.98]
    ZbbBKG = [1.00,0.99,0.97,0.99]
    ZbbjBKG = [0.99,0.97,1.02,0.98]
    ZxxBKG = [1.08,0.98,1.00,0.99]

    print "categories:", categories
    #name of the output file
    output = "tree_"+SYST+".root"
    #name of the directory where the txt for the limit will be written
    #dirLimits = "/home/fynu/amertens/scratch/CMSSW/CMSSW_6_1_1/src/2HDM/"
    dirLimits = "/home/fynu/acaudron/scratch/CMSSW_6_1_1/src/2HDM/"

