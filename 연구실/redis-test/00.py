# original conf file copy
conf_file1 = "#original\n"
# readline_all.py
f = open("init_config.conf", 'r')
while True:
    line = f.readline()
    if not line: break
    conf_file1 += line
f.close()

count = 2 ### conf file count

conf_file2 = {}

## conf_file2 init
for i in range(count):
    conf_file2[i] = "\n"
    conf_file2[i] += conf_file1

conf_file2[0] += "\nappendonly no"
conf_file2[0] += "\nappendfsync always"

conf_file2[1] += "\nappendonly yes"
conf_file2[1] += "\nappendfsync everysec"

# conf file generate step
for i in range(count):
    f = open("./conf_file2_"+str(i)+".conf", 'w')
    f.write(conf_file2[i])
    f.close()

