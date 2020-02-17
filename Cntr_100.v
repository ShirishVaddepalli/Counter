`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2020 11:48:53 AM
// Design Name: 
// Module Name: Cntr_100
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


module Cntr_100(FPGA_CPU_RESET,CLKP_IN,CLKN_IN,counter_up,reset,CLK);

input CLKP_IN, CLKN_IN;
input FPGA_CPU_RESET;
output reg [3:0] counter_up;

wire Clk,CLK;
output reset,CLK;

IBUFGDS #(.DIFF_TERM("TRUE"), .IOSTANDARD("DIFF_SSTL15"))
    IBUFGDS_CLK_IN (.O(Clk), .I(CLKP_IN), .IB(CLKN_IN)); 

    BUFG BUFG_CLK_IN (.O(CLK), .I(Clk));
 
//reg [5:0] counter_up = 6'd0;

assign reset = FPGA_CPU_RESET;

reg [27:0] Counter_oneSecond = 28'd0;

/*always @(posedge CLK) begin
    if(FPGA_CPU_RESET) counter_up <= 6'd0;     
    else begin
        if(counter_up == 6'd60) counter_up <= 6'd0;
        else counter_up <= counter_up + 6'd1;    
    end
end     */

always @(posedge CLK) begin
    if(FPGA_CPU_RESET) begin
    	Counter_oneSecond <= 28'd0;
    	counter_up <= 4'd0;
    end	
    else begin
        if(Counter_oneSecond == 28'd200000000) begin
            counter_up <= counter_up + 4'd1; 
            Counter_oneSecond <= 28'd0;
        end
        else Counter_oneSecond <= Counter_oneSecond + 28'd1;
    end

end
     
endmodule

