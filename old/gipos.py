import csv
import numpy as np

import RPi.GPIO as GPIO
import time

shh = 1

GPIO.setmode(GPIO.BCM)

A1 = 7
A2 = 15
B1 = 11
B2 = 13

GPIO.setup(A1, GPIO.OUT)
GPIO.setup(B1, GPIO.OUT)
GPIO.setup(A2, GPIO.OUT)
GPIO.setup(B2, GPIO.OUT)


print ("MARCHA HACIA ADALANTE")
GPIO.output(A1, GPIO.LOW)
GPIO.output(B1, GPIO.LOW)
GPIO.output(A2, GPIO.HIGH)
GPIO.output(B2, GPIO.LOW)


GPIO.cleanup()


