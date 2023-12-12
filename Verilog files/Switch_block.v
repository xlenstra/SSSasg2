`timescale 1ns / 1ps

(* DONT_TOUCH="true"*)
module switch_block(
    (* dont_touch = "true" *) input wire Challenge,
    (* dont_touch = "true" *) input wire In0,
    (* dont_touch = "true" *) input wire In1,
    (* dont_touch = "true" *) output wire Out0,
    (* dont_touch = "true" *) output wire Out1
);

(* DONT_TOUCH="true"*)
mux top_mux(
    .selector (Challenge),
    .in1 (In0),
    .in2 (In1),
    .selected (Out0)
);

(* DONT_TOUCH="true"*)
mux bottom_mux(
    .selector (Challenge),
    .in1 (In1),
    .in2 (In0),
    .selected (Out1)
);


endmodule
