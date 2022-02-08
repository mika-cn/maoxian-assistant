import time

with open('plans/zh/plans.json') as f:
    lines = f.read().splitlines()
    for line in lines:
        if line.find('\"version\":') != -1:
            f.write('  \"version\": '+time.strftime("%Y%m%d", time.localtime())+',\n')
        else:
            f.write(line+'\n')

with open('plans/test/plans.json') as f:
    lines = f.read().splitlines()
    for line in lines:
        if line.find('\"version\":') != -1:
            f.write('  \"version\": '+time.strftime("%Y%m%d", time.localtime())+',\n')
        else:
            f.write(line+'\n')

with open('plans/default/plans.json') as f:
    lines = f.read().splitlines()
    for line in lines:
        if line.find('\"version\":') != -1:
            f.write('  \"version\": '+time.strftime("%Y%m%d", time.localtime())+',\n')
        else:
            f.write(line+'\n')
