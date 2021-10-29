# -*- coding: utf-8 -*-

import pandas as pd
from knobs import *
from func import *


knobs_DictList = {}

# 리스트로 초기화
for knob in knobs:
    knobs_DictList[knob] = []

print(knobs_DictList)
print(len(knobs_DictList))

# 1.config 파일에서 파라미터 value를 parmas_dict로 복사
knobs_dict = Extract_knobs("config2.conf", knobs)

print(knobs_dict)
print(len(knobs_dict))

for knob in knobs_DictList:
    knobs_DictList[knob].append(knobs_dict[knob])

knobs_dict = Extract_knobs("config1.conf", knobs)
print(knobs_dict)
for knob in knobs_DictList:
    knobs_DictList[knob].append(knobs_dict[knob])

knobs_DataFrame = pd.DataFrame(knobs_DictList)
print(knobs_DataFrame)