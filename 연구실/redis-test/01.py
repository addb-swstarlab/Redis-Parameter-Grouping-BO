import random
import paramiko

def random_choice(dict):
    boolean_value = ['yes', 'no']
    for name, list in dict.items():
        if list[0] == "boolean":
            list[1] = random.choice(boolean_value)
        elif list[0] == 'categorical':
            list[2] = random.choice(list[1])
    return dict

def config_generator(conf_file, dict):
    for name, list in dict.items():
        if list[0] == "boolean":
            conf_file += ("\n"+name +" "+list[1])

        elif list[0] == 'categorical':
            conf_file += ("\n"+name+" "+list[2])
    return conf_file

def file_generator(filename, filecontent, fileextension):
    f = open("./"+filename+"."+fileextension, 'w')
    f.write(filecontent)
    f.close()


#########

count_params = 17

params_list = [
    ["stop-writes-on-bgsave-error", "boolean", ""]
]  ###[name, type, value]


params_dict = {
    "loglevel":["categorical",['debug','verbose','notice','warning'],None],
    "stop-writes-on-bgsave-error":["boolean",None],
    "rdbcompression":["boolean",None],
    "rdbchecksum":["boolean",None],
    "rdb-save-incremental-fsync":["boolean",None],
    "appendonly":["boolean",None],
    "appendfsync":["categorical",['always', 'everysec','no'],None],
    "no-appendfsync-on-rewrite":["boolean",None],
    "aof-load-truncated":["boolean",None],
    "aof-use-rdb-preamble":["boolean",None],
    "maxmemory policy":["categorical",["volatile-lru","allkeys-lru","volatile-lfu","alkeys-lfu","volatile-random","allkeys-random","volatile-ttl","noeviction"],None],
    "lazyfree-lazy-user-del":["boolean",None],
    "replica-lazy-flush":["boolean",None],
    "activerehashing":["boolean",None],
    "dynamic-hz":["boolean",None],
    "activedefrag":["boolean",None]
}

# original conf file copy
init_config = "#original\n"

# readline_all.py
f = open("init_config.conf", 'r')
while True:
    line = f.readline()
    if not line: break
    init_config += line
f.close()

count_file = 2

config_list = [init_config for _ in range(count_file)]

for i in range(count_file):
    config_list[i] = config_generator(config_list[i], random_choice(params_dict))

# conf file generate step
for i in range(count_file):
    file_generator("config"+str(i), config_list[i], "conf")


##################

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
local = '165.132.172.73'
username = 'swredis'
password = 'lab53295@'
ssh.connect('165.132.172.73',username=username, password=password)
file_dir = "redis-test"

count_file = 0
result = ""

for i in range(2):
    result = 'config'+str(i)

    stdin, stdout, stderr = ssh.exec_command('cd '+file_dir+';'+' redis-server')
    stdin, stdout, stderr = ssh.exec_command('cd '+file_dir+';'+' memtier_benchmark')

    line_count = 0
    for line in stdout.read().splitlines():
        line_count += 1
        if line_count == 15:
            break
        result += ('\n'+line.decode())
    stdin, stdout, stderr = ssh.exec_command("sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'")  # cache 비우기
    stdin.write('lab53295@\n')

    stdin, stdout, stderr = ssh.exec_command('cd '+file_dir+';'+' redis-cli shutdown')

    file_generator("result"+str(i), result, 'txt')

stdin.close()
stdout.close()
stderr.close()
ssh.close()


