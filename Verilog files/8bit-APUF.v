(* DONT_TOUCH="yes"*)
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2023 02:55:48 PM
// Design Name: 
// Module Name: 8bit-APUF
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


(*KEEP_HIERARCHY = "TRUE"*)
module APUF_8bit(
    input [7:0] Challenge,
    input Pulse,
    input Reset,
    output wire Result,
    output wire Done
);

wire top01;
wire bot01;
wire top12;
wire bot12;
wire top23;
wire bot23;
wire top34;
wire bot34;
wire top45;
wire bot45;
wire top56;
wire bot56;
wire top67;
wire bot67;
wire top7a;
wire bot7a;

switch_block sb0(
    .Selector (Challenge[0]),
    .Pulse1 (Pulse),
    .Pulse2 (Pulse),
    .Out1 (top01),
    .Out2 (bot01)
);

switch_block sb1(
    .Selector (Challenge[1]),
    .Pulse1 (top01),
    .Pulse2 (bot01),
    .Out1 (top12),
    .Out2 (bot12)
);

switch_block sb2(
    .Selector (Challenge[2]),
    .Pulse1 (top12),
    .Pulse2 (bot12),
    .Out1 (top23),
    .Out2 (bot23)
);

switch_block sb3(
    .Selector (Challenge[3]),
    .Pulse1 (top23),
    .Pulse2 (bot23),
    .Out1 (top34),
    .Out2 (bot34)
);

switch_block sb4(
    .Selector (Challenge[4]),
    .Pulse1 (top34),
    .Pulse2 (bot34),
    .Out1 (top45),
    .Out2 (bot45)
);

switch_block sb5(
    .Selector (Challenge[5]),
    .Pulse1 (top45),
    .Pulse2 (bot45),
    .Out1 (top56),
    .Out2 (bot56)
);

switch_block sb6(
    .Selector (Challenge[6]),
    .Pulse1 (top56),
    .Pulse2 (bot56),
    .Out1 (top67),
    .Out2 (bot67)
);

switch_block sb7(
    .Selector (Challenge[7]),
    .Pulse1 (top67),
    .Pulse2 (bot67),
    .Out1 (bot7a),
    .Out2 (top7a)
);

arbiter Arbiter(
    .in1 (top7a),
    .in2 (bot7a),
    .reset (Reset),
    .value (Value),
    .done (Done)
);





endmodule
