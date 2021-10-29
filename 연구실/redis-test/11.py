
import paramiko
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

ssh.connect('165.132.172.73',username='swredis', password='lab53295@')

stdin, stdout, stderr = ssh.exec_command('redis-server')  ## excute redis server

stdin, stdout, stderr = ssh.exec_command('memtier_benchmark')

print(stdout.read())

stdin, stdout, stderr = ssh.exec_command('redis-cli shutdown')

stdin.close()
ssh.close()

