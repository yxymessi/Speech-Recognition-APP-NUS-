import requests
import numpy as np
import nltk
from nltk.stem import PorterStemmer
from nltk.stem import WordNetLemmatizer
#from collections import Counter   估计没有对应包，故自己手撸

def find_same(list_1):
    remove_index=[]
    remove_list=[]
    for i in range(0,len(list_1)-1):
        for j in range(i+1,len(list_1)):
            if list_1[i]==list_1[j]:
                remove_index.append(j)
    return remove_index




if __name__ == '__main__':
#构造模拟词库
    word_site = "http://svnweb.freebsd.org/csrg/share/dict/words?view=co&content-type=text/plain"

    response = requests.get(word_site)
    WORDS = response.content.splitlines()

    for i in range(0,len(WORDS)):
        WORDS[i]=str(WORDS[i], encoding = "utf-8")




    WORDS_F=[];WORDS_S=[];WORDS_A=[]

    for i in range(0,len(WORDS)):
        if WORDS[i][0]=='f'or WORDS[i][0]=='F':
            WORDS_F.append(WORDS[i])
        elif WORDS[i][0]=='s'or WORDS[i][0]=='S':
            WORDS_S.append(WORDS[i])
        elif WORDS[i][0] == 'a' or WORDS[i][0] == 'A':
            WORDS_A.append(WORDS[i])

    #考察大写字母
    capital_A = [i for i in WORDS_A if i[0].islower()==False]
    capital_S=[i for i in WORDS_S if i[0].islower()==False]
    capital_F=[i for i in WORDS_F if i[0].islower()==False]


    #WORDS_A=np.array(WORDS_A);WORDS_S=np.array(WORDS_S);WORDS_F=np.array(WORDS_F)

    #去除所有大写字母



    #若能调用类似nltk的库
    stemmer = PorterStemmer()     #词干提取
    lemmatizer = WordNetLemmatizer()    #变体还原
    lancaster = nltk.LancasterStemmer()
    #按照词性进行还原    动词词态，副词-形容词，名词


    port_list=[]
    lem_list=[]
    lan_list=[]

    test_list=['fisher','fish','do','done','wonderful','wonderfully','act','actor']
    for word in test_list:
        temp_word1=WordNetLemmatizer().lemmatize(word,'v')
        lem_list.append(temp_word1)
        temp_word2=lancaster.stem(word)
        lan_list.append(temp_word2)
        temp_word3=stemmer.stem(word)
        port_list.append(temp_word3)

    remove_index_1=find_same(port_list)
    remove_index_2=find_same(lem_list)
    remove_index_3=find_same(lan_list)
    remove_index=set(remove_index_1+remove_index_2+remove_index_3)

    true_list=[]
    for index in range(0,len(test_list)):
        if index not in remove_index:
            true_list.append(test_list[index])

    score=len(true_list)
    print(score)


    #若无相应符合库，自己构建匹配算法

