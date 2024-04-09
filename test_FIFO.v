`timescale 1ns/1ps
module test_FIFO;
	reg write_en,read_en,clk,rst;
	reg [7:0] data_in;           
	wire full,empty;
	wire [7:0] data_out;
	integer i;
	
	Synchronous_FIFO test_FIFO(clk,rst,read_en,write_en,data_out,data_in,full,empty);
	
	initial begin
		clk=0;
		rst=0;
		read_en=0;
		write_en=0;
		#2 rst=1;
		#2 rst=0;
		end
		
	always #5 clk= ~clk;
	
	initial begin
		#9 write_en=1;
		for(i=0;i<6;i=i+1)
			@(negedge clk)                 //write random 5 value in FIFO and same read from FIFO.
			begin
				data_in=i;
		   end
		write_en=0;	
		read_en=1;
		end
		
	initial begin
		$monitor("%d %d %d" ,$time,data_in,data_out);     //debugging 
		end
		
		
	initial begin
		#70 read_en=1;
		#300 $finish;
		end
		
		
endmodule