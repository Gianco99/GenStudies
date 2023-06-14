import sys
import os
import shutil
import datetime
import random

sample = str(sys.argv[1])
nEvents = str(sys.argv[2])
url = str(sys.argv[3])
nJobs = int(sys.argv[4])

originalDirectory = os.getcwd()
os.mkdir(sample)
os.system('cp condor.jds ' + sample)
os.system('cp skeleton_condor.sh ' + sample)
os.chdir(sample)
workingDirectory = os.getcwd()

for i in range(nJobs):
    randSeed = random.randint(0,100000)
    timeStamp = str(datetime.datetime.now().timestamp())
    os.chdir(workingDirectory) 
    os.mkdir(str(i))
    os.system('cp condor.jds ' + str(i))
    os.system('cp skeleton_condor.sh ' + str(i))
    os.chdir(str(i))
    os.system("sed -i 's|\[datasetname\]|" + sample + "_" + timeStamp.split('.')[1] + "|g' condor.jds")
    os.system("sed -i 's|__sample__|"+ sample +"|g' skeleton_condor.sh")
    os.system("sed -i 's|__url__|"+ url +"|g' skeleton_condor.sh")
    os.system("sed -i 's|__randomSeed__|"+ str(randSeed) +"|g' skeleton_condor.sh")
    os.system("sed -i 's|__nEvents__|"+ nEvents +"|g' skeleton_condor.sh")
    os.system("sed -i 's|__timeStamp__|"+timeStamp.split('.')[1]+"|g' skeleton_condor.sh")
    #os.system("source " +os.getcwd() +"/skeleton_condor.sh")
    os.system("condor_submit condor.jds")
