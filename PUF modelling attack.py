import pypuf.io, pypuf.attack, pypuf.metrics
import numpy as np

challengeLength = 32


def postProcessResponses(responses):
    apuf1 = responses[:, 0]
    apuf3 = np.logical_xor(responses[:, 2], responses[:, 1])
    responses[:, 1] = np.logical_xor(apuf3, apuf1)
    for index, row in enumerate(responses):
        for bit, response in enumerate(row):
            if response == 0:
                responses[index][bit] = -1
    return responses


def readNpFile(fileName):
    fileData = np.load(fileName)
    challenges = fileData[:, :challengeLength].astype(int)
    for index, challenge in enumerate(challenges):
        for index2, bit in enumerate(challenge):
            if bit == 0:
                challenges[index][index2] = -1
    responses = postProcessResponses(fileData[:, challengeLength:].astype(float))
    return challenges, responses


def trainModel(crps, k, test_challenges, test_responses) -> float:
    """
    Train a model on the given training data and test it on the given test data.
    :param crps: Training data.
    :param test_challenges: Test challenges.
    :param test_responses: Test responses.
    :return: Similarity between the test responses and the model's predictions.
    """
    attack = pypuf.attack.MLPAttack2021(
        crps, seed=0, net=[2 ** (k - 1), 2 ** k, 2 ** (k - 1)],
        epochs=128, lr=.001, bs=1024, early_stop=.08,
    )
    attack.fit()
    model = attack.model
    return pypuf.metrics.similarity_data(test_responses, model.eval(test_challenges))[0]


print("Loading training data...")
train_challenges, train_responses = readNpFile('training-CRPs-1to8.npy')
print("Loading testing data...")
test_challenges, test_responses = readNpFile('testing-CRPs-1to8.npy')

results = {}

# k = number of APUFs in the XOR-PUF
for k in range(1, 9):
    # n = number of CRPs required to learn the PUF
    n = 2 ** 10
    modelResult = 0.0
    while modelResult < 0.9:
        n *= np.sqrt(np.sqrt(2))
        intN = int(n)
        print("Training model with", intN, "examples...")
        current_train_challenges = train_challenges[:intN]
        current_train_responses = train_responses[:intN, k-1]
        train_crps = pypuf.io.ChallengeResponseSet(current_train_challenges, current_train_responses)
        modelResult = trainModel(train_crps, k, test_challenges, test_responses[:, k-1])
        print("Accuracy =", modelResult)
        if n >= 2 ** 20:
            print("Model could not be trained with", n, "examples.")
            break

    print("Minimal number of examples to learn {0}-XOR-PUF = {1}".format(k, n))
    results[k] = (n, modelResult)
    print("Accuracy =", modelResult)

print(results)
