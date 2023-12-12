`timescale 1ns / 1ps



(* DONT_TOUCH="yes"*)
module mux(
    input wire selector,
    input wire in1,
    input wire in2,
    output wire selected
);

assign selected = selector ? in2 : in1;

endmodule
