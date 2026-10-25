module decoder_3_8_tb;
reg [2:0] in;
reg en;
wire [7:0] out;
integer i;

decoder_3_8 uut (
    .in(in),
    .en(en),
    .out(out)
);

initial begin
    $dumpfile("decoder_3_8.vcd");
    $dumpvars(0, decoder_3_8_tb);
    
    $monitor("en=%b, in=%d, out=%b", en, in, out);
    for (i=0; i<16; i=i+1)
    begin 
        {en,in}=i;
        #10;
    end

    $finish;
    
end
endmodule