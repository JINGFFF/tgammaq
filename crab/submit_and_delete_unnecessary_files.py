#!/bin/env python3

import os
import sys
import re

path = "config_crab_2016apv"
files = os.listdir(path)
for file in files:
    if os.path.isfile(os.path.join(path, file)):
        if ".pyc" not in file and "init" not in file  and "list_input_sample" not in file and file.endswith("py"):
            os.popen("crab submit -c "+path+"/"+file).read()
            # print "crab submit -c "+path+"/"+file
            fld = os.popen('ls -td -- */ | head -n 1').read().rstrip()
            # print fld
            fld = "rm "+fld+"/inputs/*.tgz"
            os.popen(fld).read().rstrip()
