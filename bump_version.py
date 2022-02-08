import time
file_list = ['plans/zh/plans.json', 'plans/test/plans.json', 'plans/default/plans.json']

for file_ in file_list:
    with open(file_) as f:
        lines = f.read().splitlines()
    with open(file_, 'w') as f:
        for line in lines:
            if line.find('\"version\":') != -1:
                f.write('  \"version\": '+time.strftime("%Y%m%d", time.localtime())+',\n')
            else:
                f.write(line+'\n')
