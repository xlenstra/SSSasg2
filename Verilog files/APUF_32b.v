`timescale 1ns / 1ps

(* DONT_TOUCH="yes"*)
module APUF_32b(
    input [31:0] Challenge,
    input Pulse,
    input Reset,
    output wire Result
);

(* DONT_TOUCH="yes"*) wire top01;
(* DONT_TOUCH="yes"*) wire bot01;
(* DONT_TOUCH="yes"*) wire top12;
(* DONT_TOUCH="yes"*) wire bot12;
(* DONT_TOUCH="yes"*) wire top23;
(* DONT_TOUCH="yes"*) wire bot23;
(* DONT_TOUCH="yes"*) wire top3A;
(* DONT_TOUCH="yes"*) wire bot3A;

(* DONT_TOUCH="yes"*)
PUF_8b puf0(
    .Challenge (Challenge[7:0]),
    .in_top(Pulse),
    .in_bot(Pulse),
    .out_top(top01),
    .out_bot(bot01)
);

(* DONT_TOUCH="yes"*)
PUF_8b puf1(
    .Challenge (Challenge[15:8]),
    .in_top(top01),
    .in_bot(bot01),
    .out_top(top12),
    .out_bot(bot12)
);

(* DONT_TOUCH="yes"*)
PUF_8b puf2(
    .Challenge (Challenge[23:16]),
    .in_top(top12),
    .in_bot(bot12),
    .out_top(top23),
    .out_bot(bot23)
);

(* DONT_TOUCH="yes"*)
PUF_8b puf3(
    .Challenge (Challenge[31:24]),
    .in_top(top23),
    .in_bot(bot23),
    .out_top(top3A),
    .out_bot(bot3A)
);

(* DONT_TOUCH="yes"*)
arbiter Arbiter(
    .In (top3A),
    .enable (bot3A),
    .reset (Reset),
    .Out (Result)
);




endmodule
