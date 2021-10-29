import paramiko
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect('165.132.172.73',username='swredis', password='lab53295@')

file_dir = "redis-test"

stdin, stdout, stderr = ssh.exec_command('cd '+file_dir+';'+' memtier_benchmark')
line_count = 0
for line in stdout.read().splitlines():
    line_count += 1
    if line_count == 15:
        break
    print(line.decode())

stdin.close()
stdout.close()
stderr.close()
ssh.close()