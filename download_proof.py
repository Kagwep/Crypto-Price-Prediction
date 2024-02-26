import requests
from giza import API_HOST

print(API_HOST)

MODEL_ID = 369  # Update with your model ID
VERSION_ID = 2  # Update with your version ID
DEPLOYMENT_ID = 60  # Update with your deployment id
REQUEST_ID = "07a17b1fe34a4839b9abc5cb2d463eea"  # Update with your request id
API_KEY = "vbnDFYbnn1Gj4cEs6ATRBA" # Update with your API key

url = f"{API_HOST}/api/v1/models/{MODEL_ID}/versions/{VERSION_ID}/deployments/{DEPLOYMENT_ID}/proofs/{REQUEST_ID}:download"

print(url)

headers = {"X-API-KEY": API_KEY}

d_url = requests.get(url, headers=headers).json()["download_url"]

proof = requests.get(d_url)

with open("zk.proof", "wb") as f:
    f.write(proof.content)


