# -*- coding: utf-8 -*-

def Extract_knobs(config, knobs):
    knobs_dict = {}
    for knob in knobs:
        knobs_dict[knob] = None

    f = open("./configfile/"+config, 'r')
    while True:
        line = f.readline()  # 한줄 읽기
        if not line: break

        if '#' in line:  # 주석문일 경우 건너뛰기
            continue

        list_line = line.split()  # [param, value]

        if list_line[0] in knobs:  # params_dict에서 파라미터 명 탐색
            
            knobs_dict[list_line[0]] = list_line[1]
            # 파라미터 값 2개일 경우 ex) save
            if list_line[-1] != list_line[1]:  
                knobs_dict[list_line[0]] = knobs_dict[list_line[0]]+' '+list_line[-1]
                    
    f.close()
    
    return knobs_dict

def init_dict(dict):
    for knob in dict:
        dict[knob] = None
