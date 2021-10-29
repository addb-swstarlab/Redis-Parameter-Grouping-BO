import paramiko

def file_generator(filename, filecontent, fileextension):
    f = open("./" + filename + "." + fileextension, 'w')
    f.write(filecontent)
    f.close()

count_file = 2

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
local = '165.132.172.73'
username = 'swredis'
password = 'lab53295@'
ssh.connect('165.132.172.73', username=username, password=password)
file_dir = "benchmarking"
i=0

# stdin, stdout, stderr = ssh.exec_command('cd ' + file_dir + ';' + ' redis-server' + ' ./config' + str(i) + '.conf')
stdin, stdout, stderr = ssh.exec_command('echo kk')

print(stdout.read().splitlines())

stdin.close()
stdout.close()
stderr.close()
ssh.close()
