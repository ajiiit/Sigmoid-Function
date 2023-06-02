// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_proj_example
 *
 * This is an example of a (trivially simple) user project,
 * showing how the user project can connect to the logic
 * analyzer, the wishbone bus, and the I/O pads.
 *
 * This project generates an integer count, which is output
 * on the user area GPIO pads (digital output only).  The
 * wishbone connection allows the project to be controlled
 * (start and stop) from the management SoC program.
 *
 * See the testbenches in directory "mprj_counter" for the
 * example programs that drive this user project.  The three
 * testbenches are "io_ports", "la_test1", and "la_test2".
 *
 *-------------------------------------------------------------
 */

module user_proj_example #(
    parameter BITS = 32
)(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [15:0] io_in,
    output [15:0] io_out,
    output [15:0] io_oeb,

    // IRQ
    output [2:0] irq
);
    wire clk;
    wire rst;

    wire [15:0] io_in;
    wire [15:0] io_out;
    wire [15:0] io_oeb;

    //wire [15:0] rdata; 
    //wire [15:0] wdata;
    //wire [15:0] count;
     wire signed [8:0] x;
     wire signed [15:0] out;

    wire valid;
    wire [3:0] wstrb;
    wire [31:0] la_write;

    // WB MI A
    assign valid = wbs_cyc_i && wbs_stb_i; 
    assign wstrb = wbs_sel_i & {4{wbs_we_i}};
    assign wbs_dat_o = out;
    //assign wdata = wbs_dat_i[15:0];
    assign x = wbs_dat_i[7:0];

    // IO
    //assign io_out = count;
   // assign io_oeb = {(15){rst}};

    // IRQ
    assign irq = 3'b000;	// Unused

    // LA
   // assign la_data_out = {{(127-BITS){1'b0}}, count};
    // Assuming LA probes [63:32] are for controlling the count register  
    assign la_write = ~la_oenb[63:32] & ~{BITS{valid}};
    // Assuming LA probes [65:64] are for controlling the count clk & reset  
    assign clk = (~la_oenb[64]) ? la_data_in[64]: wb_clk_i;
   // assign rst = (~la_oenb[65]) ? la_data_in[65]: wb_rst_i;

    sigmoid #(
        .BITS(BITS)
    ) sigmoid(
        .clk(clk),
        //.reset(rst),
        //.ready(wbs_ack_o),
        //.valid(valid),
        .out(out),
        .x(wbs_dat_i),
        //.wstrb(wstrb),
        //.la_write(la_write),
        //.la_input(la_data_in[63:32]),
        //.count(count)
    );

endmodule

module sigmoid #(
    parameter BITS = 32
)(
    input clk,
    //input reset,
    //input valid,
    //input [3:0] wstrb,
    input signed [8:0] x,
    //input [BITS-1:0] la_write,
    //input [BITS-1:0] la_input,
    //output ready,
    output reg signed [15:0] out,
    //output [15:0] count
);
    reg signed [7:0] y,z,sum;
   reg signed [15:0] sq,sh;

    always @(posedge clk) begin
        begin
   if(x[7]==1'b1)
       y=-x;
   else
       y=x;
   z=y>>>2 ;
      
   sum= z+8'b1111_0000;
      
   sq=sum*sum;

   sh=sq>>>1;

   if(x[7]==1'b1)
       out=sh;
   else
       out=16'b00000001_00000000-sh;
   end
        
    end

endmodule
`default_nettype wire
