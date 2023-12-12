`timescale 1ns / 1ps

(* DONT_TOUCH="yes"*)
module XOR_8_APUF(
    input [31:0] Challenge,
    input Pulse,
    input Reset,
    output wire [7:0]Result
);

wire outAPUF1;
wire outAPUF2;
wire outAPUF3;
wire outAPUF4;
wire outAPUF5;
wire outAPUF6;
wire outAPUF7;
wire outAPUF8;


APUF_32b apuf0(
    .Challenge (Challenge),
    .Pulse (Pulse),
    .Reset (Reset),
    .Result (outAPUF1)
);

APUF_32b apuf1(
    .Challenge (Challenge),
    .Pulse (Pulse),
    .Reset (Reset),
    .Result (outAPUF2)
);

APUF_32b apuf2(
    .Challenge (Challenge),
    .Pulse (Pulse),
    .Reset (Reset),
    .Result (outAPUF3)
);

APUF_32b apuf3(
    .Challenge (Challenge),
    .Pulse (Pulse),
    .Reset (Reset),
    .Result (outAPUF4)
);

APUF_32b apuf4(
    .Challenge (Challenge),
    .Pulse (Pulse),
    .Reset (Reset),
    .Result (outAPUF5)
);

APUF_32b apuf5(
    .Challenge (Challenge),
    .Pulse (Pulse),
    .Reset (Reset),
    .Result (outAPUF6)
);

APUF_32b apuf6(
    .Challenge (Challenge),
    .Pulse (Pulse),
    .Reset (Reset),
    .Result (outAPUF7)
);

APUF_32b apuf7(
    .Challenge (Challenge),
    .Pulse (Pulse),
    .Reset (Reset),
    .Result (outAPUF8)
);

assign Result[7] = outAPUF1 ^ outAPUF2 ^ outAPUF3 ^ outAPUF4 ^ outAPUF5 ^ outAPUF6 ^ outAPUF7 ^ outAPUF8;
assign Result[6] = outAPUF1 ^ outAPUF2 ^ outAPUF3 ^ outAPUF4 ^ outAPUF5 ^ outAPUF6 ^ outAPUF7;
assign Result[5] = outAPUF1 ^ outAPUF2 ^ outAPUF3 ^ outAPUF4 ^ outAPUF5 ^ outAPUF6;
assign Result[4] = outAPUF1 ^ outAPUF2 ^ outAPUF3 ^ outAPUF4 ^ outAPUF5;
assign Result[3] = outAPUF1 ^ outAPUF2 ^ outAPUF3 ^ outAPUF4;
assign Result[2] = outAPUF1 ^ outAPUF2 ^ outAPUF3;
assign Result[1] = outAPUF1 ^ outAPUF2;
assign Result[0] = outAPUF1;


endmodule
