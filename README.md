# TTC

## Steps for setup:

1. Set up NanoAOD tools
   ```bash
   cmsrel CMSSW_10_6_29
   cd CMSSW_10_6_29/src
   git clone https://github.com/cms-nanoAOD/nanoAOD-tools.git PhysicsTools/NanoAODTools
   cd PhysicsTools/NanoAODTools
   cmsenv
   scram b -j 20
   ```

2. Set up tgammaq codes
   ```bash
   cd python/postprocessing
   git clone https://github.com/JINGFFF/tgammaq.git analysis
   
   cd $CMSSW_BASE/src
   scram b -j 20
   ```
    Noticed that the `crab_help.py` is written in python3, hence the `scram b` in CMSSW would leave some error message. Since this crab helper normally would not be included by other codes, you can ignore these errors.

3. Substitute some outdated files with `init.sh`
   ```bash
   cd $CMSSW_BASE/src/PhysicsTools/NanoAODTools/python/postprocessing/analysis
   ```
   ```
   source init.sh 2016apv (FOR 2016APV)
   source init.sh 2016 (FOR 2016)
   source init.sh 2017 (FOR 2017)
   source init.sh 2018 (FOR 2018)
   ```

## submit jobs
using the configure files under 'configs', to make a test:
```
cd crab
```
MAKE BELOW CONFIGURABLE FOR EACH YEAR
```
crab submit -c configs/2018/test_EgammaB_cfg.py
rm crab_Egamma_B/inputs/*.tgz
```
Or for a local test do:
```
cd $CMSSW_BASE/src/PhysicsTools/NanoAODTools/python/postprocessing/analysis/test 
python localrun.py -m -i /eos/cms/store/group/phys_top/ExtraYukawa/input_for_tests/DY_UL18NanoAODv9_M-50_MLM.root --year 2018 -o $CMSSW_BASE/src/PhysicsTools/NanoAODTools/python/postprocessing/analysis/test -n 100
```

and to submit all jobs:
```
cd crab
crab submit -c configs/2018/EgammaB_cfg.py
rm crab_Egamma_B/inputs/*.tgz 
```

You can also check `crab/auto_crab_example` to run crab jobs automatically.

Note that the output will be /store/group/phys_top/ExtraYukawa/test/ because:
```
config.Site.storageSite = "T2_CH_CERN"
#config.Site.storageSite = "T3_CH_CERNBOX"
config.Data.outLFNDirBase = "/store/group/phys_top/ExtraYukawa/test/"
```

To write to your user cernbox area:
```
config.Site.storageSite = "T3_CH_CERNBOX"
```
See ```https://twiki.cern.ch/twiki/bin/view/CMSPublic/CRAB3FAQ#Can_I_send_CRAB_output_to_CERNBO```

To add the outputs:
```
ADD HERE ALSO THE METHOD TO HANDLE ALL OUTPUT FOLDERS AT ONCE WITH crab_helper
python ../scripts/haddnano.py combined.root /eos/cms/store/group/phys_top/ExtraYukawa/test/.../*.root
```

## corrections

the modules (most of them are corrections) used can be seen from analysis/crab/crab_script.py.
N.B. the egamma correction is already applied default in NanoAOD

#### for MC:

countHistogramsModule(): store the opsitive and negative events number for weight apply
puWeight_2017(): pileup reweight
PrefCorr(): L1-prefiring correction
muonIDISOSF2017(): muon ID/ISO SFe
muonScaleRes2017(): muon momentum correction, i.e., the Rochester correction
eleRECOSF2017(): electron RECO SF
eleIDSF2017(): electron IS SF
jmeCorrections_UL2017MC(): JetMET correction
btagSF2017UL(): b tag SF

#### for Data:

muonScaleRes2017(): muon momentum correction, i.e., the Rochester correction
jmeCorrections_UL2017*(): JetMET correction

### 1. pileup reweight 
(this correction is applied using the official module, so we need to update the rootfiles for pileup and do some modification on the official module. The files under others/for_pileup/ can be used directly)

#### data

according to https://twiki.cern.ch/twiki/bin/view/CMS/PileupJSONFileforData#Centrally_produced_ROOT_histogra, use histograms under /afs/cern.ch/cms/CAF/CMSCOMM/COMM_DQM/certification/Collisions17/13TeV/PileUp/UltraLegacy/, combine three histograms to a single one with name pileup, pileup_plus, pileup_minus

#### MC

https://twiki.cern.ch/twiki/bin/view/CMS/PileupScenariosRun2

move "mcPileupUL2017.root" and "PileupHistogram-goldenJSON-13tev-UL2017-99bins_withVar.root" to python/postprocessing/data/pileup/, and move "puWeightProducer.py" to python/postprocessing/modules/common/

### 2. prefiring correction 
(needed files are in others/for_prefiring, can be used directly)
details are here: Pre-firing: https://twiki.cern.ch/twiki/bin/viewauth/CMS/L1ECALPrefiringWeightRecipe#Accessing_the_UL2017_maps, in order to use the current NanoAOD module, extract separate rootfiles from https://github.com/cms-data/PhysicsTools-PatUtils/raw/master/L1PrefiringMaps.root

#### data & MC

move "others/for_prefiring/*.root" to NanoAODTools/data/prefire_maps/, and move "others/for_prefiring/PrefireCorr.py" to postprocessing/modules/common/

### 3. JME correction
(needed files are in others/for_jme, can be used directly)
move the *.tgz to PhysicsTools/NanoAODTools/data/jme, and move "jetmetHelperRun2.py" to PhysicsTools/NanoAODTools/python/postprocessing/modules/jme

### 4. Bjet related
(needed files are in others/for_btv, can be used directly)
move "btagSFProducer.py" to src/PhysicsTools/NanoAODTools/python/postprocessing/modules/btv, move the *.csv to PhysicsTools/NanoAODTools/data/btagSF

## After finisihing all the file moving, please remember delete the "others" directory, as the crab submission have size limit.
