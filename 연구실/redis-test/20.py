# 텍스트 파일 저장
import paramiko

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
local = '165.132.172.73'
username = 'swredis'
password = 'lab53295@'
ssh.connect('165.132.172.73',username=username, password=password)
file_dir = "redis-test"

stdin, stdout, stderr = ssh.exec_command('cd ' + file_dir + ';' + ' redis_server')
stdin, stdout, stderr = ssh.exec_command('cd ' + file_dir + ';' + ' memtier_benchmark')

