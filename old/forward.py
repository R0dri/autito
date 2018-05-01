import csv
import numpy as np

import RPi.GPIO as GPIO
from time import sleep

import cv2
import time

GPIO.setmode(GPIO.BOARD)

m=501
cap = cv2.VideoCapture(0)
i=1
#Declaración de pines

1A=4
1B=22

2A=17
2B=27

	
GPIO.setup(1A, GPIO.OUT)
GPIO.setup(1B, GPIO.OUT)

	
GPIO.setup(2A, GPIO.OUT)
GPIO.setup(2B, GPIO.OUT)

adelante=np.array([1,0,0])
derecha=np.array([0,1,0])
izquierda=np.array([0,0,1])

results = []
with open("peso1.csv") as csvfile:
    reader = csv.reader(csvfile, quoting=csv.QUOTE_NONNUMERIC) # change contents to floats
    for row in reader: # each row is a list
        results.append(row)
#print results
w1=np.asarray(results)
w11=w1.transpose()
print w11.shape

results2 = []
with open("peso2.csv") as csvfile:
    reader = csv.reader(csvfile, quoting=csv.QUOTE_NONNUMERIC) # change contents to floats
    for row in reader: # each row is a list
        results2.append(row)
#print results
w2=np.asarray(results2)
print w2.shape

while i<10
#for i in range(1,m): #m+1 o m 
    # Capture frame-by-frame
    ret, frame = cap.read()
    
    YF = np.zeros(out.shape);



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
    print z_1.shape
    a2[:,1:11]=z_1.transpose()
    a_2=a2
    z2=1/(1+np.exp(-w2.dot(a_2.transpose())))
    print z2

    p= np.zeros(1,3)
    b=np.nonzero(a==YF.max())
    p[b]=1

    if p==adelante:

        print ("MARCHA HACIA ADALANTE")
        GPIO.output(1A, GPIO.LOW)
        GPIO.output(1B, GPIO.LOW)

        GPIO.output(2A, GPIO.HIGH)
        GPIO.output(2B, GPIO.LOW)

            
        time.sleep(0.5)
            
    #print ("MARCHA HACIA ATRAS")
    #GPIO.output(motor1A, GPIO.LOW)
    #GPIO.output(motor1B, GPIO.LOW)
            
    #GPIO.output(motor2A, GPIO.LOW)
    #GPIO.output(motor2B, GPIO.HIGH)

            
    #sleep(2)
    if p==izquierda:

        print ("MARCHA HACIA IZQUIERDA")
        GPIO.output(1A, GPIO.HIGH)
        GPIO.output(1B, GPIO.LOW)
                
        GPIO.output(2A, GPIO.HIGH)
        GPIO.output(2B, GPIO.LOW)

            
        time.sleep(0.5)
    if p==derecha:

        print ("MARCHA HACIA DERECHA")
        GPIO.output(1A, GPIO.LOW)
        GPIO.output(1B, GPIO.HIGH)
                
        GPIO.output(2A, GPIO.HIGH)
        GPIO.output(2B, GPIO.LOW)

            
        time.sleep(0.5)
    else        
        print("PARADA")
        GPIO.output(1A, GPIO.LOW)
        GPIO.output(1B, GPIO.LOW)
                
        GPIO.output(2A, GPIO.LOW)
        GPIO.output(2B, GPIO.LOW)

    GPIO.cleanup()


