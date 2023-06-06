#!/bin/bash

export SCRAM_ARCH=el8_amd64_gcc10
source /cvmfs/cms.cern.ch/cmsset_default.sh
scram p CMSSW CMSSW_12_4_11_patch3
cd CMSSW_12_4_11_patch3/src
eval `scram runtime -sh`

mkdir -p Configuration/GenProduction/python/GJets_1j_Gpt-130To270_479192
wget  https://cms-pdmv.cern.ch/mcm/public/restapi/requests/get_fragment/EXO-RunIISummer20UL18wmLHEGEN-00745/0 -O GJets_1j_Gpt-130To270_fragment_479192.py --no-check-certificate
mv GJets_1j_Gpt-130To270_fragment_479192.py Configuration/GenProduction/python/GJets_1j_Gpt-130To270_479192

scram b

cmsenv

pwd
# cmsDriver command
cmsDriver.py Configuration/GenProduction/python/GJets_1j_Gpt-130To270_479192/GJets_1j_Gpt-130To270_fragment_479192.py --python_filename Configuration/GenProduction/python/GJets_1j_Gpt-130To270_479192/GJets_1j_Gpt-130To270_479192.py --eventcontent NANOAODSIM --datatier NANOAODSIM --fileout file:Configuration/GenProduction/python/GJets_1j_Gpt-130To270_479192/GJets_1j_Gpt-130To270_479192.root --conditions 124X_mcRun3_2022_realistic_postEE_v1 --beamspot Realistic25ns13p6TeVEarly2022Collision --customise_commands process.RandomNumberGeneratorService.externalLHEProducer.initialSeed=5292 --step LHE,GEN,NANOGEN --era Run3 --no_exec --mc -n 3000

cmsRun Configuration/GenProduction/python/GJets_1j_Gpt-130To270_479192/GJets_1j_Gpt-130To270_479192.py

python3 /afs/cern.ch/user/g/gdecastr/GenStudies/histo.py -i Configuration/GenProduction/python/GJets_1j_Gpt-130To270_479192/GJets_1j_Gpt-130To270_479192.root -o Configuration/GenProduction/python/GJets_1j_Gpt-130To270_479192/GJets_1j_Gpt-130To270_479192_histos

xrdcp Configuration/GenProduction/python/GJets_1j_Gpt-130To270_479192/GJets_1j_Gpt-130To270_479192_histos.root root://eosuser.cern.ch///eos/user/g/gdecastr/genStuff/GJets_1j_Gpt-130To270/GJets_1j_Gpt-130To270_479192_histos.root
