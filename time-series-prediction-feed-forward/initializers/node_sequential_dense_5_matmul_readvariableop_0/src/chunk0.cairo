use orion::numbers::{FixedTrait, FP16x16};

fn compute(ref a: Array<FP16x16>) {
a.append(FP16x16 { mag: 21982, sign: true });
a.append(FP16x16 { mag: 21606, sign: false });
a.append(FP16x16 { mag: 46550, sign: false });
a.append(FP16x16 { mag: 52208, sign: true });
a.append(FP16x16 { mag: 51850, sign: true });
a.append(FP16x16 { mag: 26686, sign: true });
a.append(FP16x16 { mag: 8163, sign: true });
a.append(FP16x16 { mag: 49773, sign: true });
}