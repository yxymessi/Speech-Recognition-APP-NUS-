import json
import sys
import numpy as np
import json
#适用于中英文词库 将中英文分别进行储存


def my_split(string,space_1,space_2):
	index=[i for i, x in enumerate(string) if ord(x)<32 or ord(x)>128]
	english_string=string[0:min(index)-space_1]
	chinese_string=string[min(index):len(string)+1-space_2]
	return english_string,chinese_string

def add_word(word_list,cn_animal_list,en_animal_list,space_1,space_2):
	for string in word_list:
		if string==['']: #the end
			return
		if (len(string) == 1):
			temp_en, temp_cn = my_split(string[0], space_1,space_2)
			cn_animal_list.append(temp_cn)
			en_animal_list.append(temp_en)




cn_animal_list = []
en_animal_list = []

word_list_1= []
with open('animal_1.txt', 'r', encoding='UTF-8') as f:
	for line in f:
		word_list_1.append(list(line.strip('\n').split(',')))

word_list_2= []
with open('animal_2.txt', 'r', encoding='UTF-8') as f:
	for line in f:
		word_list_2.append(list(line.strip('\n').split(',')))

word_list_3= []
with open('animal_3.txt', 'r', encoding='UTF-8') as f:
	for line in f:
		word_list_3.append(list(line.strip('\n').split(',')))

add_word(word_list_1,cn_animal_list,en_animal_list,1,1)

add_word(word_list_2,cn_animal_list,en_animal_list,0,0)
add_word(word_list_3,cn_animal_list,en_animal_list,1,0)


cn_animal_list=set(cn_animal_list)
en_animal_list=set(en_animal_list)

