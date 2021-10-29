import paramiko

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
local = '165.132.172.73'
username = 'swredis'
password = 'lab53295@'
ssh.connect('165.132.172.73', username=username, password=password)
file_dir = "benchmarking"

output_result = ""

stdin, stdout, stderr = ssh.exec_command('cd ' + file_dir + ';' + ' redis-server')
stdin, stdout, stderr = ssh.exec_command('cd ' + file_dir + ';' + ' memtier_benchmark')
line_count = 0
for line in stdout.read().splitlines():
    line_count += 1
    if line_count == 15:
        break
    output_result += ('\n' + line.decode())


stdin, stdout, stderr = ssh.exec_command('cd ' + file_dir + ';' + ' redis-cli info')

for line in stdout.read().splitlines():
    if line is None:
        break
    output_result += ('\n' + line.decode())

stdin.close()
stdout.close()
stderr.close()

ssh.close()
