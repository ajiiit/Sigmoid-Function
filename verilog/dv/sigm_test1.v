`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2023 10:59:29
// Design Name: 
// Module Name: sigm_test1
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


module sigmoid_test;
reg clk;
reg signed [7:0] x;
wire signed [15:0] out;


sigmoid dut(clk,x,out); 


initial begin   
  clk=0;
     forever #10 clk = ~clk;  
end 
initial begin 
 
 #50;  x=8'hC0;  

#50 x=8'hC4;
#50 x=8'hC8;
#50 x=8'hCC;
#50 x=8'hD0; 

#50 x=8'hD4;
#50 x=8'hD8; 
#50 x=8'hDC;
#50 x=8'hE0;



#50 x=8'hE4;
#50 x=8'hE8;
#50 x=8'hEC;
#50 x=8'hF0;

#50 x=8'hF4;
#50 x=8'hF8;
#50 x=8'hFC; 


#50 x=8'h00;
#50 x=8'h04;
#50 x=8'h08;
#50 x=8'h0C;

#50 x=8'h10;
#50 x=8'h14;
#50 x=8'h18;
#50 x=8'h1C;

#50 x=8'h20;
#50 x=8'h24;
#50 x=8'h28;
#50 x=8'h2C;

#50 x=8'h30;
#50 x=8'h34;
#50 x=8'h38;
#50 x=8'h38;
#50 x=8'h3C;


#50 x=8'h40; 
 #1000 $finish;
end 
  

endmodule