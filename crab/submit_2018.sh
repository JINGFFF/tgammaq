echo 'Note that the list is only partial'
crab submit -c config_crab_2018/tW_cfg.py
rm  crab_tW/inputs/*.tgz
sleep 5
crab submit -c config_crab_2018/t_sch_cfg.py
rm  crab_t_sch/inputs/*.tgz
sleep 5
crab submit -c config_crab_2018/t_tch_cfg.py
rm  crab_t_tch/inputs/*.tgz
sleep 5
crab submit -c config_crab_2018/tbar_tch_cfg.py
rm  crab_tbar_tch/inputs/*.tgz
sleep 5
crab submit -c config_crab_2018/tbarW_cfg.py
rm  crab_tbarW/inputs/*.tgz
sleep 5
crab submit -c config_crab_2018/ttH_cfg.py
rm  crab_ttH/inputs/*.tgz
sleep 5
crab submit -c config_crab_2018/zz_cfg.py
rm  crab_ZZ/inputs/*.tgz
sleep 5
crab submit -c config_crab_2018/tzq_cfg.py
rm crab_tZq/inputs/*.tgz
sleep 5
crab submit -c config_crab_2018/ttWH_cfg.py
rm  crab_ttWH/inputs/*.tgz
sleep 5
crab submit -c config_crab_2018/ttZH_cfg.py
rm  crab_ttZH/inputs/*.tgz
sleep 5
crab submit -c config_crab_2018/tttJ_cfg.py
rm  crab_tttJ/inputs/*.tgz
sleep 5
crab submit -c config_crab_2018/tttW_cfg.py
rm  crab_tttW/inputs/*.tgz 

