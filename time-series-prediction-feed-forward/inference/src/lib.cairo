use orion::operators::tensor::{Tensor, TensorTrait};
use orion::operators::tensor::{U32Tensor, I32Tensor, I8Tensor, FP8x23Tensor, FP16x16Tensor, FP32x32Tensor, BoolTensor};
use orion::numbers::{FP8x23, FP16x16, FP32x32};
use orion::operators::matrix::{MutMatrix, MutMatrixImpl};
use core::array::SpanTrait;
use orion::operators::tensor::{ FP16x16TensorAdd};
use orion::operators::nn::{NNTrait, FP16x16NN};
use orion::numbers::{FixedTrait};

use node_sequential_dense_5_matmul_readvariableop_0::get_node_sequential_dense_5_matmul_readvariableop_0;
use node_sequential_dense_5_biasadd_readvariableop_0::get_node_sequential_dense_5_biasadd_readvariableop_0;
use node_sequential_dense_4_matmul_readvariableop_0::get_node_sequential_dense_4_matmul_readvariableop_0;
use node_sequential_dense_4_biasadd_readvariableop_0::get_node_sequential_dense_4_biasadd_readvariableop_0;
use node_sequential_dense_3_matmul_readvariableop_0::get_node_sequential_dense_3_matmul_readvariableop_0;
use node_sequential_dense_3_biasadd_readvariableop_0::get_node_sequential_dense_3_biasadd_readvariableop_0;
use node_sequential_dense_2_matmul_readvariableop_0::get_node_sequential_dense_2_matmul_readvariableop_0;
use node_sequential_dense_2_biasadd_readvariableop_0::get_node_sequential_dense_2_biasadd_readvariableop_0;
use node_sequential_dense_1_matmul_readvariableop_0::get_node_sequential_dense_1_matmul_readvariableop_0;
use node_sequential_dense_1_biasadd_readvariableop_0::get_node_sequential_dense_1_biasadd_readvariableop_0;
use node_sequential_dense_matmul_readvariableop_0::get_node_sequential_dense_matmul_readvariableop_0;
use node_sequential_dense_biasadd_readvariableop_0::get_node_sequential_dense_biasadd_readvariableop_0;


fn main(node_dense_input: Tensor<FP16x16>) -> Tensor<FP16x16> {
let node_sequential_dense_matmul_0 = TensorTrait::matmul(@node_dense_input, @get_node_sequential_dense_matmul_readvariableop_0());
let node_sequential_dense_biasadd_0 = TensorTrait::add(node_sequential_dense_matmul_0, get_node_sequential_dense_biasadd_readvariableop_0());
let node_sequential_dense_relu_0 = NNTrait::relu(@node_sequential_dense_biasadd_0);
let node_sequential_dense_1_matmul_0 = TensorTrait::matmul(@node_sequential_dense_relu_0, @get_node_sequential_dense_1_matmul_readvariableop_0());
let node_sequential_dense_1_biasadd_0 = TensorTrait::add(node_sequential_dense_1_matmul_0, get_node_sequential_dense_1_biasadd_readvariableop_0());
let node_sequential_dense_1_relu_0 = NNTrait::relu(@node_sequential_dense_1_biasadd_0);
let node_sequential_dense_2_matmul_0 = TensorTrait::matmul(@node_sequential_dense_1_relu_0, @get_node_sequential_dense_2_matmul_readvariableop_0());
let node_sequential_dense_2_biasadd_0 = TensorTrait::add(node_sequential_dense_2_matmul_0, get_node_sequential_dense_2_biasadd_readvariableop_0());
let node_sequential_dense_2_relu_0 = NNTrait::relu(@node_sequential_dense_2_biasadd_0);
let node_sequential_dense_3_matmul_0 = TensorTrait::matmul(@node_sequential_dense_2_relu_0, @get_node_sequential_dense_3_matmul_readvariableop_0());
let node_sequential_dense_3_biasadd_0 = TensorTrait::add(node_sequential_dense_3_matmul_0, get_node_sequential_dense_3_biasadd_readvariableop_0());
let node_sequential_dense_3_relu_0 = NNTrait::relu(@node_sequential_dense_3_biasadd_0);
let node_sequential_dense_4_matmul_0 = TensorTrait::matmul(@node_sequential_dense_3_relu_0, @get_node_sequential_dense_4_matmul_readvariableop_0());
let node_sequential_dense_4_biasadd_0 = TensorTrait::add(node_sequential_dense_4_matmul_0, get_node_sequential_dense_4_biasadd_readvariableop_0());
let node_sequential_dense_4_relu_0 = NNTrait::relu(@node_sequential_dense_4_biasadd_0);
let node_sequential_dense_5_matmul_0 = TensorTrait::matmul(@node_sequential_dense_4_relu_0, @get_node_sequential_dense_5_matmul_readvariableop_0());
let node_dense_5 = TensorTrait::add(node_sequential_dense_5_matmul_0, get_node_sequential_dense_5_biasadd_readvariableop_0());

        node_dense_5
    }