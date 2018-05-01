import csv
import numpy as np

from time import sleep

import cv2
import time


results = []
with open("peso1.csv") as csvfile:
    reader = csv.reader(csvfile, quoting=csv.QUOTE_NONNUMERIC) # change contents to floats
    for row in reader: # each row is a list
        results.append(row)
#print results
w1=np.asarray(results)
w11=w1.transpose()
print (w11.shape)

results2 = []
with open("peso2.csv") as csvfile:
    reader = csv.reader(csvfile, quoting=csv.QUOTE_NONNUMERIC) # change contents to floats
    for row in reader: # each row is a list
        results2.append(row)
#print results
w2=np.asarray(results2)
print (w2.shape)

frame = cv2.imread('166.jpg')

a2=np.ones((1,11))

image=frame#Reemplazar por la imagen de camara
gray=cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
scaled_img=cv2.resize(gray,(50,50))
X1=scaled_img.flatten('F');
X1=X1.astype(float)
X=np.ones((1,2501))
X[:,1:2501] = X1
X=X/255
a_1=X
z_1=1/(1+np.exp(-w11.dot(a_1.transpose())))
print (z_1.shape)
a2[:,1:11]=z_1.transpose()
a_2=a2
z2=1/(1+np.exp(-w2.dot(a_2.transpose())))
print (z2)


