mod chunk0;
mod chunk1;

use orion::operators::tensor::{FP16x16Tensor, Tensor, TensorTrait};
use orion::numbers::{FixedTrait, FP16x16};

fn get_node_sequential_dense_matmul_readvariableop_0() -> Tensor<FP16x16> {
    let mut shape = array![10, 128];

    let mut data = array![];
     chunk0::compute(ref data);
     chunk1::compute(ref data);

    TensorTrait::new(shape.span(), data.span())
}