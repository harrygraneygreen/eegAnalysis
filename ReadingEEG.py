import math
import os
import numpy as np
import mne
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import sys
import time
import csv
#from xarm.wrapper import XArmAPI
#test_raw_file = os.path.expanduser("C:/Users/Maureen/Documents/DancingEEG.vhdr")
#test_raw_file = os.path.expanduser("C:/Users/Maureen/Documents/AlertEEG.vhdr")
#test_raw_file = os.path.expanduser("C:/Users/Maureen/Documents/Headnods.vhdr")
#test_raw_file = os.path.expanduser("C:/Users/Maureen/Documents/Dancing.vhdr")
#test_raw_file = os.path.expanduser("C:/Users/Maureen/Documents/WhatWeFeelEEG.vhdr")
test_raw_file = os.path.expanduser("C:/Users/Maureen/Documents/EyeBlinksEEG.vhdr")
#test_raw_file = os.path.expanduser("C:/Users/Maureen/Documents/MusicEyesClosedEEG.vhdr")
#test_raw_file = os.path.expanduser("C:/Users/Maureen/Documents/EEGtest1.vhdr")
#test_raw_file = os.path.expanduser("C:/Users/Maureen/Documents/test.vhdr")

raw = mne.io.read_raw_brainvision(test_raw_file)

print(raw)
print(raw.info)


raw.plot(duration=70, n_channels=13)


raw.plot_psd(fmax = 100)


print(raw.ch_names)


channel_list = []
i = 0
while i < 13:
    channel_list.append(raw.ch_names[i])
    i += 1


print(mne.Info)


sampling_freq = (raw.info['sfreq'])
#start_stop_seconds = np.array([0, 55.8])
start_stop_seconds = np.array([0, 56.5])
start_sample, stop_sample = (start_stop_seconds * sampling_freq).astype(int)

########################################ACC#####################################

rawACC1 = raw[8, start_sample:stop_sample]
rawACC2 = raw[9, start_sample:stop_sample]
rawACC3 = raw[10, start_sample:stop_sample]

#print(rawACC1)
#print(rawACC2)
#print(rawACC3)
#print(len(rawACC1[0][0]))

##plotting ACC data ###
x = rawACC1[1]
y = rawACC1[0].T
plt.plot(x, y)
#plt.show()

x = rawACC2[1]
y = rawACC2[0].T
plt.plot(x, y)
#plt.show()

x = rawACC3[1]
y = rawACC3[0].T
plt.plot(x, y)
plt.show()


####setting baseline####
bsl1 = rawACC1[0][0][0]
bsl2 = rawACC2[0][0][0]
bsl3 = -590000

# over under baseline #

underx = rawACC1[0][0] < (bsl1 - 1000)
undery = rawACC2[0][0] < (bsl2 - 200)
underz = rawACC3[0][0] < (bsl3 - 1000)

overx = rawACC1[0][0] > (bsl1)
overy = rawACC2[0][0] > (bsl2)
overz = rawACC3[0][0] > (bsl3)



#determine dance initiation#
#alltogther#
alltogether = []

for i in range(int((len(underx))/10)):
    if True in underx[int(i*10):int(i*10)+10] & True in undery[int(i*10):int(i*10)+10] & True in underz[int(i*10):int(i*10)+10]:
        alltogether.append((rawACC1[1][int(i*10)]))


for i in range(len(alltogether)):
    alltogether[i] = round(alltogether[i])


alltogether_times = []

for i in alltogether:
    if i not in alltogether_times:
        alltogether_times.append(i)
print("Dance all together at times:")
print(alltogether_times)

#dance2 - headnod

headnod = []

for i in range(int((len(underx))/10)):
    if True in undery[int(i*10):int(i*10)+10] & True in underz[int(i*10):int(i*10)+10] & True in overy[int(i*10):int(i*10)+10]:
        headnod.append((rawACC1[1][int(i*10)]))


for i in range(len(headnod)):
    headnod[i] = round(headnod[i])

headnod_times = []
for i in headnod:
    if i not in headnod_times:
        headnod_times.append(i)
print("Head nod at times:")
print(headnod_times)


#headdown

headdown = []
l = 0
for i in range(int((len(underx))/10)):
    if True in undery[int(i*10):int(i*10)+10]:
        l += 1
        if l >= 50:
            headdown.append((rawACC1[1][int(i*10)]))
            l = 0


for i in range(len(headdown)):
    headdown[i] = round(headdown[i])

headdown_times = []
for i in headdown:
    if i not in headdown_times:
        headdown_times.append(i)
print("Head down at times:")
print(headdown_times)

#at head down time play sad dance
#at given times in the song could be different

###############EEG##################

rawEEG1 = raw[0, start_sample:stop_sample]
rawEEG2 = raw[1, start_sample:stop_sample]
rawEEG3 = raw[2, start_sample:stop_sample]
rawEEG4 = raw[3, start_sample:stop_sample]
rawEEG5 = raw[4, start_sample:stop_sample]
rawEEG6 = raw[5, start_sample:stop_sample]
rawEEG7 = raw[6, start_sample:stop_sample]
rawEEG8 = raw[7, start_sample:stop_sample]

x = rawEEG1[1]
y = rawEEG1[0].T
plt.plot(x, y)


x = rawEEG2[1]
y = rawEEG2[0].T
plt.plot(x, y)


x = rawEEG3[1]
y = rawEEG3[0].T
plt.plot(x, y)

x = rawEEG4[1]
y = rawEEG4[0].T
plt.plot(x, y)

x = rawEEG5[1]
y = rawEEG5[0].T
plt.plot(x, y)

x = rawEEG6[1]
y = rawEEG6[0].T
plt.plot(x, y)

x = rawEEG7[1]
y = rawEEG7[0].T
plt.plot(x, y)

x = rawEEG8[1]
y = rawEEG8[0].T
plt.plot(x, y)

plt.show()

EEGS = [rawEEG1, rawEEG2, rawEEG3, rawEEG4, rawEEG5, rawEEG6, rawEEG7, rawEEG8]
EEG_avg = []
for j in range(len(rawEEG1[0][0])):
    avg = 0
    for i in range(len(EEGS)):
        avg += EEGS[i][0][0][j]
    avg = (avg/8)
    EEG_avg.append(avg)

EEG_sum = np.array(EEG_avg)

x = rawEEG1[1]
y = EEG_sum.T
plt.plot(x, y)
plt.show()

#mne.time_frequency.csd_fourier(rawEEG2[1], fmin=8, fmax=30, tmin=0, tmax=70, picks=None, n_fft=None, projs=None, n_jobs=1, verbose=None)


###Get eyeblinks###3 and 4 are good# baseliine then per minute

x = rawEEG3[1]
y = rawEEG3[0].T
plt.plot(x, y)
plt.show()

bleye = rawEEG3[0][0]

eyeblinksbool = rawEEG3[0][0] > (.000056)

eyeblinks = []

for i in range(int((len(eyeblinksbool))/10)):
    if True in eyeblinksbool[int(i*10):int(i*10)+10]:
        eyeblinks.append((rawEEG3[1][int(i*10)]))

for i in range(len(eyeblinks)):
    eyeblinks[i] = round(eyeblinks[i])


eyeblinks_times = []

for i in eyeblinks:
    if i not in eyeblinks_times:
        eyeblinks_times.append(i)
print("Eyeblinks at times:")
print(eyeblinks_times)

if ((len(eyeblinks_times)/56.5) > .3):
    print("Playing excited song!")
elif ((len(eyeblinks_times)/56.5) < .3):
    print("Playing sad song!")



#sin head bob first part#
#EEG_sum[999*j]

t = np.array([])
a = np.array([])
for j in range(12):
    x = np.arange(0+2*j,2+2*j,.01)
    y = (np.sin(x * (np.pi)) * 10000 * EEG_sum[(1000*j)])
    t = np.append(t,x)
    a = np.append(a, y)

plt.plot(t, a)
plt.show()
#for i in x:
#    setArmAngle()


#make happy dances in matlab and call them here#





# ###implement into breath####
#
# EEG_bsl = EEG_sum[1]
#
# EEG_diff = []
#
# for i in range(len(EEG_avg)):
#     EEG_diff.append(EEG_avg[i] - EEG_bsl)
#
# EEG_diff1 = np.array(EEG_diff)
#
# x = rawEEG1[1]
# y = EEG_diff1.T
# plt.plot(x, y)
# plt.show()
#
# ###xarms###
#
# arm1 = XArmAPI('192.168.1.203')
# arm2 = XArmAPI('192.168.1.226')
# arm3 = XArmAPI('192.168.1.244')
# arm4 = XArmAPI('192.168.1.206')
# arm5 = XArmAPI('192.168.1.242')
# arm6 = XArmAPI('192.168.1.204')
# arm7 = XArmAPI('192.168.1.234')
# arm8 = XArmAPI('192.168.1.211')
# arm9 = XArmAPI('192.168.1.236')
# arm10 = XArmAPI('192.168.1.215')
# arm11 = XArmAPI('192.168.1.208')
# arm12 = XArmAPI('192.168.1.237')
#
#
#
#
#
# arms = [arm1,arm2,arm3,arm4, arm5, arm6,arm7,arm8,arm9,arm10,arm11,arm12]
# totalArms = len(arms)
#
# path_j = []
#
# #EEG
# #Adding summed voltage to breath
# #only do for perimeter arms
# with open('/home/forest/Desktop/xArm/xArmScripts/breath.csv', newline='') as csvfile:
#
#             paths_reader_j = csv.reader(csvfile, delimiter=',', quotechar='|')
#
#
#
#             for path in paths_reader_j:
#                 path_j.append(cvt(path))
# length = len(path_j)
#
# for i in range(length):
#     j_angles = path_j[i] + EEG_diff
#
#
