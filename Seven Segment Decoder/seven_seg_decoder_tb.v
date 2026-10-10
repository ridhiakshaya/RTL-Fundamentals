`timescale 1ns/1ps

module seven_seg_decoder_tb;

reg [3:0] bin;
wire [6:0] seg;

integer i;

seven_seg_decoder uut(
    .bin(bin),
    .seg(seg)
);

initial begin

    $dumpfile("seven_seg_decoder.vcd");
    $dumpvars(0, seven_seg_decoder_tb);

    $display("Time\tInput\tSegment Output");
    $monitor("%0t\t%h\t%b", $time, bin, seg);

    for (i = 0; i < 16; i = i + 1) begin
        bin = i;
        #10;
    end

    $finish;

end

endmodule