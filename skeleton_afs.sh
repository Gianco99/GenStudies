#!/bin/bash

export SCRAM_ARCH=el8_amd64_gcc10
source /cvmfs/cms.cern.ch/cmsset_default.sh
scram p CMSSW CMSSW_12_4_11_patch3
cd CMSSW_12_4_11_patch3/src
eval `scram runtime -sh`

mkdir -p Configuration/GenProduction/python/__sample_____timeStamp__
wget  __url__ -O __sample___fragment___timeStamp__.py --no-check-certificate
mv __sample___fragment___timeStamp__.py Configuration/GenProduction/python/__sample_____timeStamp__

scram b

cmsenv

pwd
# cmsDriver command
cmsDriver.py Configuration/GenProduction/python/__sample_____timeStamp__/__sample___fragment___timeStamp__.py --python_filename Configuration/GenProduction/python/__sample_____timeStamp__/__sample_____timeStamp__.py --eventcontent NANOAODSIM --datatier NANOAODSIM --fileout file:Configuration/GenProduction/python/__sample_____timeStamp__/__sample_____timeStamp__.root --conditions 124X_mcRun3_2022_realistic_postEE_v1 --beamspot Realistic25ns13p6TeVEarly2022Collision --customise_commands process.RandomNumberGeneratorService.externalLHEProducer.initialSeed=__randomSeed__ --step LHE,GEN,NANOGEN --era Run3 --no_exec --mc -n __nEvents__

cmsRun Configuration/GenProduction/python/__sample_____timeStamp__/__sample_____timeStamp__.py

python3 /afs/cern.ch/user/g/gdecastr/GenStudies/histo.py -i Configuration/GenProduction/python/__sample_____timeStamp__/__sample_____timeStamp__.root -o Configuration/GenProduction/python/__sample_____timeStamp__/__sample_____timeStamp___histos
