from pynq import Overlay
from pynq import GPIO
from random import randint
import numpy as np


XOR_PUF = Overlay("32_bit_APUF.bit")

resultPinCount = 8
challengeBits = 32

resetPin = GPIO(GPIO.get_gpio_pin(60), 'out')
runPin = GPIO(GPIO.get_gpio_pin(61), 'out')
challengePins = [GPIO(GPIO.get_gpio_pin(i), 'out') for i in range(challengeBits)]

resultPins = [GPIO(GPIO.get_gpio_pin(i), 'in') for i in range(48, 48+resultPinCount)


lastChallenge = [0] * challengeBits

def reset():
    runPin.write(0)
    resetPin.write(1)
    resetPin.write(0)

def setChallenge(challenge):
    global lastChallenge
    for index, challengeBit in enumerate(challenge):
        if lastChallenge[index] != challenge[index]:
            challengePins[index].write(challengeBit)
    lastChallenge = challenge
    
def run(challenge):
    responses = []
    setChallenge(challenge)
    runPin.write(1)
    for resultPin in resultPins:
        responses.append(resultPin.read())
    reset()
    return responses

    
challenges = np.load("training_challenges.npy")
challengeCount = 2**20

results = np.empty((challengeCount, challengeBits + resultPinCount), dtype=int)

reset()
for i in range(2**22):
    challenge = challenges[i]
    responses = run(challenge)
    results[i, :challengeBits] = challenge
    results[i, challengeBits:] = responses

np.save("training_CRPs.npy", results)