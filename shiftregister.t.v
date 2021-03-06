//------------------------------------------------------------------------
// Shift Register test bench
//------------------------------------------------------------------------
`include "shiftregister.v"

module testshiftregister();

    reg             clk;
    reg             peripheralClkEdge;
    reg             parallelLoad;
    wire[7:0]       parallelDataOut;
    wire            serialDataOut;
    reg[7:0]        parallelDataIn;
    reg             serialDataIn;

    // Instantiate with parameter width = 8
    shiftregister #(8) dut(.clk(clk),
    		           .peripheralClkEdge(peripheralClkEdge),
    		           .parallelLoad(parallelLoad),
    		           .parallelDataIn(parallelDataIn),
    		           .serialDataIn(serialDataIn),
    		           .parallelDataOut(parallelDataOut),
    		           .serialDataOut(serialDataOut));
    
    initial clk = 0;
    
    initial begin
        $dumpfile("shiftregister.vcd");
        $dumpvars;

        peripheralClkEdge = 0;
        // Test parallel loads
    	parallelLoad = 1;
        parallelDataIn = 8'b00000000;
        clk = 1; #10 clk = 0; #10
        if (parallelDataOut == 8'b00000000) begin
            $display("Test Case 1 Passed");
        end
        else begin
            $display("Test Case 1 Failed!");
        end

        parallelDataIn = 8'b00001111;
        clk = 1; #10 clk = 0; #10;
        if (parallelDataOut == 8'b00001111) begin
            $display("Test Case 2 Passed");
        end
        else begin
            $display("Test Case 2 Failed!");
        end

        parallelDataIn = 8'b11111111;
        clk = 1; #10 clk = 0; #10
        if (parallelDataOut == 8'b11111111) begin
            $display("Test Case 3 Passed");
        end
        else begin
            $display("Test Case 3 Failed!");
        end
        if (serialDataOut == 1) begin
            $display("Test Case 10 serialDataOut Passed");
        end
        else begin
            $display("Test Case 10 serialDataOut Failed!");
            $display("%8b", serialDataOut);
        end


        parallelLoad = 0;
        parallelDataIn = 8'b00000000;
        clk = 1; #10 clk = 0; #10
        if (parallelDataOut == 8'b00000000) begin
            $display("Test Case 4 Failed!");
        end
        else begin
            $display("Test Case 4 Passed");
        end


        // serial tests
        clk = 0; #10
        parallelLoad = 1;
        parallelDataIn = 8'b00000000;
        clk = 1; #10 clk = 0; #10
        
        parallelLoad = 0;
        serialDataIn = 1;
        peripheralClkEdge = 1;
        
        clk = 1; #5 clk = 0; #5
        if (parallelDataOut == 8'b00000001) begin
            $display("Test Case 6 Passed");
        end
        else begin
            $display("Test Case 6 Failed!");
            $display("%8b", parallelDataOut);
        end
        if (serialDataOut == 0) begin
            $display("Test Case 7 Passed");
        end
        else begin
            $display("Test Case 7 Failed!");
            $display("%8b", serialDataOut);
        end
        
        clk = 1; #5 clk = 0; #5

        if (parallelDataOut == 8'b00000011) begin
            $display("passed serial test 2");
        end
        else begin
            $display("failed serial test 2");
            $display("%8b", parallelDataOut);
        end
        
        clk = 1; #5 clk = 0; #5
        if (parallelDataOut == 8'b00000111) begin
            $display("passed serial test 3");
        end
        else begin
            $display("failed serial test 3");
            $display("%8b", parallelDataOut);
        end

        serialDataIn = 0;
        clk = 1; #5 clk = 0; #5
        if (parallelDataOut == 8'b00001110) begin
            $display("passed serial test 4");
        end
        else begin
            $display("failed serial test 4");
            $display("%8b", parallelDataOut);
        end
        if (serialDataOut == 0) begin
            $display("passed serialOut test 2");
        end
        else begin
            $display("failed serialOut test 2");
            $display("%8b", serialDataOut);
        end

        // test serialDataOut
    end

endmodule
