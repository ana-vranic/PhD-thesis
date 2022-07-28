import numpy as np
import math as mt
import sys

def load_data(file_name):
    data = []
    f = open(file_name, 'r')
    for line in f:
        if not line.startswith('#'):
            data.append(tuple((line.strip().split(' '))))
    f.close()
    return data

def load_data_tab(file_name):
    data = []
    f = open(file_name, 'r')
    for line in f:
        if not line.startswith('#'):
            data.append(tuple(line.strip().split('\t')))
    f.close()
    return data

def load_data_mat(file_name):
    data = []
    f = open(file_name, 'r')
    for line in f:
        if not line.startswith('#'):
            data.append(tuple((line.strip().split(','))))
    f.close()
    return data

def load_data_array(file_name):
    data = []
    f = open(file_name, 'r')
    for line in f:
        if not line.startswith('#'):
            data.append(line)
    f.close()
    return data

def write_in_file (f, sn):
    l = len(sn[0])
    g = open(f, 'w')
    for element in sn:
        for i in range(0,l):
            g.write(str(element[i]))
            g.write(" ")
        g.write("\n")
    g.close()

def write_in_file_array (f, sn):
    #l = len(sn[0])
    g = open(f, 'w')
    for element in sn:
            g.write(str(element))
            g.write(" ")
            g.write("\n")
    g.close()

def write_in_file_append (f, sn):
    l = len(sn[0])
    g = open(f, 'a')
    for element in sn:
        for i in xrange(0,l):
            g.write(str(element[i]))
            g.write(" ")
        g.write("\n")
    g.close()

def binning(bin, data):
    #x0 = data[0][0]
    data = sorted(data)
    for a in data:
        x0 = a[0]
        #print x0
        if x0!=0:
            break
    def j(x):
        return int((x-x0)/bin)

    bin_clust = []
    acc = {}
    for x,y in data:

        key = j(x)
        current_avg = acc.get(key, [0,0,0])
        current_avg[0] += x
        current_avg[1] += y
        current_avg[2] += 1
        acc[key] = current_avg

    for a in acc:
        b = acc[a]
        bin_clust.append((1.0*b[0]/b[2], 1.0*b[1]/b[2]))
    return bin_clust

def log_binning(base, data):
    #x0 = data[0][0]
    data = sorted(data)
    for a in data:
        x0 = a[0]
        #print x0
        if x0!=0:
            break
    def llim(x):
        j = (mt.log(x) - mt.log(x0))/base
        return x0*mt.exp(base*int(j))
    def ulim(x):
        return llim(x)*mt.exp(base)

    bin_clust = []
    acc = {}
    for x,y in data:
        key = (llim(x), ulim(x))
        current_avg = acc.get(key, [0,0,0])
        current_avg[0] += x
        current_avg[1] += y
        current_avg[2] += 1
        acc[key] = current_avg
    for a in acc:
        b = acc[a]
        bin_clust.append((1.0*b[0]/b[2], 1.0*b[1]/b[2]))
    return bin_clust

def log_binning_dist(base, data): #from raw data = (x) find logbin data
    data = sorted(data)
    for a in data:
        x0 = a
        #print x0
        if x0!=0:
            break
    Nc = len(data)
    #x0=1.0
    def llim(x):
        j = (mt.log(x) - mt.log(x0))/base
        return x0*mt.exp(base*int(j))
    def ulim(x):
        return llim(x)*mt.exp(base)

    bin_clust = []
    acc = {}
    zero = 0
    for x in data:
        if x!=0:
            key = (llim(x), ulim(x))
            current_avg = acc.get(key, [0,0])
            current_avg[0] += x
            current_avg[1] += 1
            acc[key] = current_avg
        else:
            zero += 1

    for a in acc:
        b = acc[a]
        bin = float(a[1]) - float(a[0])
        bin_clust.append((1.0*b[0]/b[1], 1.0*b[1]/Nc/bin))
    return bin_clust

def bin_distribution(bin, data): #from raw data = (x) find bin distribution data
    data = sorted(data)

    Nc = len(data)
    x0 = data[0]
    def j(x):
        return int((x-x0)/bin)

    bin_clust = []
    acc = {}
    for x in data:

        key = j(x)
        current_avg = acc.get(key, [0,0])
        current_avg[0] += x
        current_avg[1] += 1
        acc[key] = current_avg

    for a in acc:
        b = acc[a]
        bin_clust.append((1.0*b[0]/b[1], 1.0*b[1]/Nc))
    return bin_clust
