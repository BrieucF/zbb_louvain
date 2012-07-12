#! /usr/bin/env python

import ROOT
import sys
import os
from DataFormats.FWLite import Events, Handle
from baseControlPlots import BaseControlPlots
from monteCarloSelection import *
from zbbCommons import zbblabel
#from myFuncTimer import print_timing

class MonteCarloSelectionControlPlots(BaseControlPlots):
    """A class to create control plots for MC event selection"""

    def __init__(self, dir=None, dataset=None, mode="plots"):
      # create output file if needed. If no file is given, it means it is delegated
      BaseControlPlots.__init__(self, dir=dir, purpose="mcSelection", dataset=dataset, mode=mode)

    def beginJob(self, genlabel=zbblabel.genlabel):
      # declare histograms
      self.add("eventType","Event Type (0,l,c,b)+Z",4,0,4)
      # prepare handles
      self.genlabel=genlabel
      self.genHandle = Handle ("vector<reco::GenParticle>")
      # various local variables
      self.cjet = 0
      self.bjet = 0
      self.ljet = 0
      self.i = 0

    #@print_timing      
    def process(self,event):
      """monteCarloSelectionControlPlots"""
      result = { }
      event.getByLabel (self.genlabel,self.genHandle)
      particles = self.genHandle.product()
      self.i += 1
      if isZbEvent(particles,0,False):
        self.bjet += 1
        result["eventType"] = 3
        return result
      if isZcEvent(particles,0,False):
        self.cjet += 1
        result["eventType"] = 2
        return result
      if isZlEvent(particles,0,False):
        self.ljet += 1
        result["eventType"] = 1
        return result
      result["eventType"] = 0
      return result

    def endJob(self):
      BaseControlPlots.endJob(self)
      print "summary: out of",self.i,"events:",self.cjet,"cZ events",self.bjet,"bZ events and",self.ljet," light jets events."

def runTest():
  controlplots = MonteCarloSelectionControlPlots()
  path="/home/fynu/tdupree/store/zbb_13Sep/TT_MC/skim/"
  #path="../testfiles/"
  dirList=os.listdir(path)
  files=[]
  for fname in dirList:
    files.append(path+fname)
  events = Events (files)
  controlplots.beginJob()
  i = 0
  for event in events:
    if i==10000: break
    if i%1000==0 : print "Processing... event ", i
    controlplots.processEvent(event)
    i += 1
  controlplots.endJob()

#runTest()
