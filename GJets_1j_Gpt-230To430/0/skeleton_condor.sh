#!/bin/bash

export SCRAM_ARCH=el8_amd64_gcc10
source /cvmfs/cms.cern.ch/cmsset_default.sh
scram p CMSSW CMSSW_12_4_11_patch3
cd CMSSW_12_4_11_patch3/src
eval `scram runtime -sh`

mkdir -p Configuration/GenProduction/python/GJets_1j_Gpt-230To430_323154
wget  https://cms-pdmv.cern.ch/mcm/public/restapi/requests/get_fragment/EXO-RunIISummer20UL18wmLHEGEN-00746/0 -O GJets_1j_Gpt-230To430_fragment_323154.py --no-check-certificate
mv GJets_1j_Gpt-230To430_fragment_323154.py Configuration/GenProduction/python/GJets_1j_Gpt-230To430_323154

scram b

cmsenv

pwd
# cmsDriver command
cmsDriver.py Configuration/GenProduction/python/GJets_1j_Gpt-230To430_323154/GJets_1j_Gpt-230To430_fragment_323154.py --python_filename Configuration/GenProduction/python/GJets_1j_Gpt-230To430_323154/GJets_1j_Gpt-230To430_323154.py --eventcontent NANOAODSIM --datatier NANOAODSIM --fileout file:Configuration/GenProduction/python/GJets_1j_Gpt-230To430_323154/GJets_1j_Gpt-230To430_323154.root --conditions 124X_mcRun3_2022_realistic_postEE_v1 --beamspot Realistic25ns13p6TeVEarly2022Collision --customise_commands process.RandomNumberGeneratorService.externalLHEProducer.initialSeed=46613 --step LHE,GEN,NANOGEN --era Run3 --no_exec --mc -n 3000

cmsRun Configuration/GenProduction/python/GJets_1j_Gpt-230To430_323154/GJets_1j_Gpt-230To430_323154.py

python3 /afs/cern.ch/user/g/gdecastr/GenStudies/histo.py -i Configuration/GenProduction/python/GJets_1j_Gpt-230To430_323154/GJets_1j_Gpt-230To430_323154.root -o Configuration/GenProduction/python/GJets_1j_Gpt-230To430_323154/GJets_1j_Gpt-230To430_323154_histos

xrdcp Configuration/GenProduction/python/GJets_1j_Gpt-230To430_323154/GJets_1j_Gpt-230To430_323154_histos.root root://eosuser.cern.ch///eos/user/g/gdecastr/genStuff/GJets_1j_Gpt-230To430/GJets_1j_Gpt-230To430_323154_histos.root
