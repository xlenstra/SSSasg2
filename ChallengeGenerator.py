from typing import List
from random import randint
import time
import numpy as np


def challengeDistance(challenge1: List[int], challenge2: List[int]) -> float:
    """
    Calculate the distance between two challenges.
    :param challenge1: First challenge.
    :param challenge2: Second challenge.
    :return: Distance between the two challenges.
    """
    distance = 0
    for index in range(len(challenge1)):
        if challenge1[index] != challenge2[index]:
            distance += 1
    return distance


def shouldSwap(challenges: np.ndarray[List[int]]) -> bool:
    """
    Check if two challenges should be swapped.
    :param challenges: List of challenges.
    :return: True if the challenges should be swapped, False otherwise.
    """
    distance01 = challengeDistance(challenges[0], challenges[1])
    distance02 = challengeDistance(challenges[0], challenges[2])
    distance13 = challengeDistance(challenges[1], challenges[3])
    distance23 = challengeDistance(challenges[2], challenges[3])
    if distance01 + distance23 < distance02 + distance13:
        return False
    return True


def swapChallenges(challenges: np.ndarray[List[int]]) -> None:
    for index in range(4, len(challenges)-4):
        if shouldSwap(challenges[index-4:index]):
            challenges[index-2], challenges[index-3] = challenges[index-3], challenges[index-2]


def calculateTotalDistance(challenges: np.ndarray[List[int]]) -> int:
    totalDistance = 0
    for index in range(1, len(challenges)):
        totalDistance += challengeDistance(challenges[index-1], challenges[index])
    return totalDistance


def generateChallenges(count: int) -> np.ndarray[List[bool]]:
    """
    Generate a list of challenges.
    :param count: Number of challenges to generate.
    :return: List of challenges.
    """
    challenges = np.empty((count, 32), dtype=int)
    for index in range(count):
        challenges[index] = [1 if randint(0, 1) == 1 else 0 for _ in range(32)]

    # print(calculateTotalDistance(challenges))
    swapChallenges(challenges)
    print(calculateTotalDistance(challenges))

    return challenges


startTime = time.time()
challenges = generateChallenges(16384)
print(time.time() - startTime)
# print(challenges)
np.save("challenges_test", challenges)

# print(challengeDistance([1, 1, -1, 1], [1, 1, 1, -1]))