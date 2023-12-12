import pypuf.metrics
import numpy as np

# Load data
challengeLength = 32

def readNpFile(fileName):
    fileData = np.load(fileName)
    responses = fileData[:, challengeLength:].astype(int)
    return responses

print("Loading training data...")
train_responses = readNpFile('training-CRPs-1to8.npy')


# Count the number of 1s in each APUF
apufResponses = train_responses[:, 0]
for i in range(1, 8):
    apufResponses = np.c_[apufResponses, np.logical_xor(train_responses[:, i], train_responses[:, i-1])]

for i in range(0, 8):
    print("APUF", i, ":", np.sum(apufResponses[:, i]))


# Calculate similarity between all APUFs
results = []

for i in range(0, 8):
    currentResult = []
    for j in range(0, 8):
        currentResult.append(pypuf.metrics.similarity_data(apufResponses[:, i], apufResponses[:, j])[0])
    results.append(currentResult)

print("[")
for result in results:
    print(result)
print("]")


# Count how often all APUFs agree
counts = [0, 0, 0, 0, 0, 0, 0, 0, 0]
for row in apufResponses:
    counts[np.sum(row)] += 1

print(counts)

