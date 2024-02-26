import numpy as np
from giza_actions.model import GizaModel
from giza_actions.task import task
from giza_actions.action import Action, action
import tensorflow as tf

@task(name='Prediction with Cairo')
def prediction(data, model_id, version_id):
    # Initialize a GizaModel with model and version id.
    model = GizaModel(
        id=model_id,
        version=version_id
    )
    
    # Call the predict function. 
    #Set `verifiable` to True, and define the expecting output datatype.
    (result, request_id) = model.predict(
        input_feed={"dense_input": data}, 
        verifiable=True,
        output_dtype="Tensor<FP16x16>"
    )
    return result, request_id

@action(name='Execution: Prediction with Cairo', log_prints=True)
def execution():
    loaded_array = np.load('test_input.npy')
    data = loaded_array.astype(np.float32)
    (result, request_id) = prediction(data, 369, 2)
    return result, request_id

execution()