#!/usr/bin/env python

### to be run as
#python Launch.py --which=TT_MC
#python Launch.py --which=DY_MC
#python Launch.py --which=El_Data
#python Launch.py --which=Mu_Data
###

import urllib
import string
import os
import sys
import LaunchOnCondor
import glob

from optparse import OptionParser
#import sys
#usage="""%prog [options]"""
#description="""A simple script to generate control plots."""
#epilog="""Example:
#./ControlPlots.py -i /storage/data/cms/store/user/favereau/MURun2010B-DiLeptonMu-Dec22/ -o controlPlots_MURun2010B.root --all
#"""
#parser = OptionParser(usage=usage,add_help_option=True,description=description,epilog=epilog)
parser = OptionParser()
parser.add_option("-w", "--which", dest="which",
                  help="which sample to analyse.", metavar="WHICH")
(options, args) = parser.parse_args()

whichSample = options.which

print "sample = ", whichSample

FarmDirectory = "FARM"
JobName = "Zmumubb_herwig"
LaunchOnCondor.Jobs_RunHere = 1
LaunchOnCondor.SendCluster_Create(FarmDirectory, JobName)
LaunchOnCondor.Jobs_RunHere= 1
for i in range(1,101):
    command = "/home/fynu/tdupree/scratch/test444/CMSSW_4_4_4/src/UserCode/zbb_louvain/test/patTuple_llbb_cmssw444_cfg_dataMC.py"  
    option  = " slice="+str(i)+" boolMC=1"  
    print "command = ", command
    print "option  = ", option
    LaunchOnCondor.SendCluster_Push(["CMSSW", command, option ])
LaunchOnCondor.SendCluster_Submit()

