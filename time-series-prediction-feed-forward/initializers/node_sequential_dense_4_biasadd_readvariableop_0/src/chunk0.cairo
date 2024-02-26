use orion::numbers::{FixedTrait, FP16x16};

fn compute(ref a: Array<FP16x16>) {
a.append(FP16x16 { mag: 698, sign: true });
a.append(FP16x16 { mag: 2220, sign: false });
a.append(FP16x16 { mag: 205, sign: false });
a.append(FP16x16 { mag: 244, sign: true });
a.append(FP16x16 { mag: 518, sign: true });
a.append(FP16x16 { mag: 475, sign: true });
a.append(FP16x16 { mag: 623, sign: true });
a.append(FP16x16 { mag: 679, sign: true });
}