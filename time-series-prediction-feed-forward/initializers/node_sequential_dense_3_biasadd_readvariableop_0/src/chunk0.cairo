use orion::numbers::{FixedTrait, FP16x16};

fn compute(ref a: Array<FP16x16>) {
a.append(FP16x16 { mag: 583, sign: false });
a.append(FP16x16 { mag: 1538, sign: true });
a.append(FP16x16 { mag: 1506, sign: false });
a.append(FP16x16 { mag: 706, sign: true });
a.append(FP16x16 { mag: 700, sign: true });
a.append(FP16x16 { mag: 550, sign: true });
a.append(FP16x16 { mag: 531, sign: true });
a.append(FP16x16 { mag: 698, sign: true });
a.append(FP16x16 { mag: 706, sign: false });
a.append(FP16x16 { mag: 1552, sign: true });
a.append(FP16x16 { mag: 0, sign: false });
a.append(FP16x16 { mag: 925, sign: false });
a.append(FP16x16 { mag: 710, sign: false });
a.append(FP16x16 { mag: 559, sign: true });
a.append(FP16x16 { mag: 747, sign: false });
a.append(FP16x16 { mag: 325, sign: true });
}