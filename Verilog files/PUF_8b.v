`timescale 1ns / 1ps

(* DONT_TOUCH="yes"*)
module PUF_8b(
    input [7:0] Challenge,
    input in_top,
    input in_bot,
    output wire out_top,
    output wire out_bot
);

wire [1:0]w0to1;
wire [1:0]w1to2;
wire [1:0]w2to3;
wire [1:0]w3to4;
wire [1:0]w4to5;
wire [1:0]w5to6;
wire [1:0]w6to7;

(* DONT_TOUCH="yes"*)
switch_block sb0(
    .Challenge (Challenge[0]),
    .In0 (in_top),
    .In1 (in_bot),
    .Out0 (w0to1[0]),
    .Out1 (w0to1[1])
);

(* DONT_TOUCH="yes"*)
switch_block sb1(
    .Challenge (Challenge[1]),
    .In0 (w0to1[0]),
    .In1 (w0to1[1]),
    .Out0 (w1to2[0]),
    .Out1 (w1to2[1])
);

(* DONT_TOUCH="yes"*)
switch_block sb2(
    .Challenge (Challenge[2]),
    .In0 (w1to2[0]),
    .In1 (w1to2[1]),
    .Out0 (w2to3[0]),
    .Out1 (w2to3[1])
);

(* DONT_TOUCH="yes"*)
switch_block sb3(
    .Challenge (Challenge[3]),
    .In0 (w2to3[0]),
    .In1 (w2to3[1]),
    .Out0 (w3to4[0]),
    .Out1 (w3to4[1])
);

(* DONT_TOUCH="yes"*)
switch_block sb4(
    .Challenge (Challenge[4]),
    .In0 (w3to4[0]),
    .In1 (w3to4[1]),
    .Out0 (w4to5[0]),
    .Out1 (w4to5[1])
);

(* DONT_TOUCH="yes"*)
switch_block sb5(
    .Challenge (Challenge[5]),
    .In0 (w4to5[0]),
    .In1 (w4to5[1]),
    .Out0 (w5to6[0]),
    .Out1 (w5to6[1])
);

(* DONT_TOUCH="yes"*)
switch_block sb6(
    .Challenge (Challenge[6]),
    .In0 (w5to6[0]),
    .In1 (w5to6[1]),
    .Out0 (w6to7[0]),
    .Out1 (w6to7[1])
);

(* DONT_TOUCH="yes"*)
switch_block sb7(
    .Challenge (Challenge[7]),
    .In0 (w6to7[0]),
    .In1 (w6to7[1]),
    .Out0 (out_top),
    .Out1 (out_bot)
);




endmodule
