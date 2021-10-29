
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

output_result = ""

for i in range(count_file):
    output_result = 'config' + str(i) + '.conf result\n\n'

    stdin, stdout, stderr = ssh.exec_command('cd ' + file_dir + ';' + ' redis-server'+' ./config'+str(i)+'.conf')
    stdin, stdout, stderr = ssh.exec_command('cd ' + file_dir + ';' + ' memtier_benchmark')
    output_result += "########################### memtier_benchmark ###########################"
    line_count = 0
    for line in stdout.read().splitlines():
        line_count += 1
        if line_count == 15:
            break
        output_result += ('\n' + line.decode())
    stdin, stdout, stderr = ssh.exec_command('cd ' + file_dir + ';' + " sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'")
    stdin.write('lab53295@\n')

    stdin, stdout, stderr = ssh.exec_command('cd ' + file_dir + ';' + ' redis-cli info')

    output_result += "\n\n\n############################## redis-info ###############################"
    for line in stdout.read().splitlines():
        if line is None:
            break
        output_result += ('\n' + line.decode())
    stdin, stdout, stderr = ssh.exec_command('cd ' + file_dir + ';' + ' redis-cli shutdown')

    stdin.close()
    stdout.close()
    stderr.close()
    file_generator("result_config" + str(i), output_result, 'txt')


ssh.close()
