mod chunk0;
mod chunk1;
mod chunk2;

use orion::operators::tensor::{FP16x16Tensor, Tensor, TensorTrait};
use orion::numbers::{FixedTrait, FP16x16};

fn get_node_sequential_dense_2_matmul_readvariableop_0() -> Tensor<FP16x16> {
    let mut shape = array![64, 32];

    let mut data = array![];
     chunk0::compute(ref data);
     chunk1::compute(ref data);
     chunk2::compute(ref data);

    TensorTrait::new(shape.span(), data.span())
}