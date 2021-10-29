import random
import paramiko


def determine_dict(params_aof, params_rdb, params_activedefrag, params_maxmemory, params_etc, params_dict):

    params_dict = {**params_maxmemory, **params_etc}

    persis_choice = random.choice(['aof', 'rdb'])  ## random choice persistence
    if persis_choice == 'aof':  ## chocie AOF
        params_aof['appendonly'][2] = 'yes'
        params_dict.update(params_aof)

    elif persis_choice == 'rdb':  ## choice RDB
        save_message_list = []
        for i in range(params_rdb['save'][1][0]):
            seconds_range = params_rdb['save'][1][i+1][0]
            changes_range = params_rdb['save'][1][i+1][1]
            seconds = random.randint(seconds_range[0], seconds_range[1])
            changes = random.randint(changes_range[0], changes_range[1])
            save_message = str(seconds)+' '+str(changes)
            save_message_list.append(save_message)

        params_rdb['save'][2] = save_message_list
        params_dict.update(params_rdb)

    activedefrag_choice = random.choice(['yes', 'no'])
    if activedefrag_choice == 'yes':
        params_activedefrag['activedefrag'][2] = 'yes'
        params_dict.update(params_activedefrag)

    return params_dict


# def random_choice(dict):
#     for name, list in dict.items():
#         if name == "appendonly" or "save" or 'activedefrag':
#             continue
#         elif list[0] == "boolean" or "categorical" or "numerical_categorical":
#             list[1] = random.choice(list[1])
#         elif list[0] == 'numerical_range':
#             list[2] = random.randint(list[1][0], list[1][1])
#     return dict
#
#
# def config_generator(conf_file, dict):
#     for name, list in dict.items():
#         if list[0] == "boolean":
#             conf_file += ("\n" + name + " " + list[1])
#         elif list[0] == 'categorical':
#             conf_file += ("\n" + name + " " + list[2])
#         elif list[0] == 'numerical_categorical':
#             conf_file += ("\n" + name + " " + list[2])
#         elif list[0] == 'numerical_range':
#             conf_file += ("\n" + name + " " + list[2])
#     return conf_file
#
#
# def file_generator(filename, filecontent, fileextension):
#     f = open("./" + filename + "." + fileextension, 'w')
#     f.write(filecontent)
#     f.close()


#########
params_aof = {
    "appendonly": ["boolean", ["yes", "no"], None],
    "appendfsync": ["categorical", ['always', 'everysec', 'no'], None],
    "auto-aof-rewrite-percentage": ["numerical_categorical", ['50', '100', '150', '200', '250', '300'], None],
    "auto-aof-rewrite-min-size": ['numerical_categorical', ['32mb', '64mb', '128mb', '256mb', '512mb'], None],
    "no-appendfsync-on-rewrite": ['boolean', ['yes', 'no'], None],
    "aof-rewrite-incremental-fsync": ['boolean', ['yes', 'no'], None],
    "aof-use-rdb-preamble": ['boolean', ['yes', 'no'], None]
}

params_rdb = {
    "save": ['string', [3,[[700, 1200],[1, 20]], [[100, 500],[1, 50]], [[300, 900],[7500, 12500]]], []],
    "rdbcompression": ['boolean', ['yes', 'no'], None],
    "rdbchecksum": ['boolean', ['yes', 'no'], None],
    "rdb-save-incremental-fsync": ['boolean', ['yes', 'no'], None]
}

params_activedefrag = {
    "activedefrag": ['boolean', ['yes', 'no'], None],
    "active-defrag-threshold-lower": ['numerical_range', [1, 40], None],
    "active-defrag-threshold-upper": ['numerical_range', [60, 100], None],
    "active-defrag-cycle-min": ["numerical_range", [1, 20], None],
    "active-defrag-cycle-max": ['numerical_range', [60, 90], None]
}

params_maxmemory = {
    "maxmemory": ['numerical_categorical', ['1gb', '2gb', '3gb', '4gb', '5gb', '6gb', '7gb', '8gb', '9gb', '10gb'],
                  None],
    "maxmemory policy": ["categorical", ["volatile-lru", "allkeys-lru", "volatile-lfu", "alkeys-lfu", "volatile-random",
                                         "allkeys-random", "volatile-ttl", "noeviction"], None],
    "maxmemory-samples": ['numerical_range', [1, 10], None]
}

params_etc = {
    "loglevel": ["categorical", ['debug', 'verbose', 'notice', 'warning'], None],
    "lazyfree-lazy-eviction": ['boolean', ['yes', 'no'], None],
    "lazyfree-lazy-expire": ['boolean', ['yes', 'no'], None],
    "lazyfree-lazy-server-del": ['boolean', ['yes', 'no'], None],
    "hash-max-ziplist-entries": ['numerical_categorical', ['256', '512', '1024'], None],
    "hash-max-ziplist-value": ['numerical_categorcial', ['32', '64', '128'], None],
    "activerehashing": ['boolean', ['yes', 'no'], None],
    "hz": ['numerical_range', [1, 500], None],
    "dynamic-hz": ['boolean', ['yes', 'no'], None]
}

# # original conf file copy
# init_config = "#original\n"
#
# # readline_all.py
# f = open("init_config.conf", 'r')
# while True:
#     line = f.readline()
#     if not line: break
#     init_config += line
# f.close()
#
# count_file = 2
#
# config_list = [init_config for _ in range(count_file)]

params_dict = {}

params_dict = determine_dict(params_aof, params_rdb, params_activedefrag, params_maxmemory, params_etc,params_dict)
print(params_dict)
params_dict = determine_dict(params_aof, params_rdb, params_activedefrag, params_maxmemory, params_etc,params_dict)
print(params_dict)
params_dict = determine_dict(params_aof, params_rdb, params_activedefrag, params_maxmemory, params_etc,params_dict)
print(params_dict)
params_dict = determine_dict(params_aof, params_rdb, params_activedefrag, params_maxmemory, params_etc,params_dict)
print(params_dict)
params_dict = determine_dict(params_aof, params_rdb, params_activedefrag, params_maxmemory, params_etc,params_dict)
print(params_dict)

# for i in range(count_file):
#     params_dict = determine_dict(params_dict)
#     config_list[i] = config_generator(config_list[i], random_choice(params_dict))

# # conf file generate step
# for i in range(count_file):
#     file_generator("config" + str(i), config_list[i], "conf")


##################
#
# ssh = paramiko.SSHClient()
# ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
# local = '165.132.172.73'
# username = 'swredis'
# password = 'lab53295@'
# ssh.connect('165.132.172.73', username=username, password=password)
# file_dir = "redis-test"
#
# count_file = 0
# result = ""
#
# for i in range(2):
#     result = 'config' + str(i)
#
#     stdin, stdout, stderr = ssh.exec_command('cd ' + file_dir + ';' + ' redis-server')
#     stdin, stdout, stderr = ssh.exec_command('cd ' + file_dir + ';' + ' memtier_benchmark')
#
#     line_count = 0
#     for line in stdout.read().splitlines():
#         line_count += 1
#         if line_count == 15:
#             break
#         result += ('\n' + line.decode())
#     stdin, stdout, stderr = ssh.exec_command("sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'")  # cache 비우기
#     stdin.write('lab53295@\n')
#
#     stdin, stdout, stderr = ssh.exec_command('cd ' + file_dir + ';' + ' redis-cli shutdown')
#
#     file_generator("result" + str(i), result, 'txt')
#
# stdin.close()
# stdout.close()
# stderr.close()
# ssh.close()


