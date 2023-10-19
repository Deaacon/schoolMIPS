

module de10_lite(

    input               ADC_CLK_10,
    input               MAX10_CLK1_50,
    input               MAX10_CLK2_50,

    output  [  7:0 ]    HEX0,
    output  [  7:0 ]    HEX1,
    output  [  7:0 ]    HEX2,
    output  [  7:0 ]    HEX3,
    output  [  7:0 ]    HEX4,
    output  [  7:0 ]    HEX5,

    input   [  1:0 ]    KEY,

    output  [  9:0 ]    LEDR,

    input   [  9:0 ]    SW,

    inout   [ 35:0 ]    GPIO
);

    // wires & inputs
    wire          clk;
    wire          clkIn     =  MAX10_CLK1_50;
    wire          rst_n     =  KEY[0];
    wire          clkEnable =  SW [9] | ~KEY[1];
    wire [  3:0 ] clkDevide =  SW [8:5];
    wire [  4:0 ] regAddr   =  SW [4:0];
    wire [ 31:0 ] regData;

    //cores
    wire [7:0] dbgIn = GPIO[15:8];
    wire [7:0] dbgOut;
    wire [31:0] dbgRaw = { 24'b0, dbgIn };
    sm_top sm_top
    (
        .clkIn      ( clkIn     ),
        .rst_n      ( rst_n     ),
        .clkDevide  ( clkDevide ),
        .clkEnable  ( clkEnable ),
        .clk        ( clk       ),
        .regAddr    ( regAddr   ),
        .regData    ( regData   ),

        .dbgIn(dbgIn),
        .dbgOut(dbgOut)
    );

    //outputs
    assign LEDR[0]   = clk;
    assign LEDR[8:1] = dbgOut;
    // assign GPIO[7:0] = dbgOut;

    wire [ 31:0 ] h7segment = regData;

    assign HEX0 [7] = 1'b1;
    assign HEX1 [7] = 1'b1;
    assign HEX2 [7] = 1'b1;
    assign HEX3 [7] = 1'b1;
    assign HEX4 [7] = 1'b1;
    assign HEX5 [7] = 1'b1;

    sm_hex_display digit_5 ( h7segment [23:20] , HEX5 [6:0] );
    sm_hex_display digit_4 ( h7segment [19:16] , HEX4 [6:0] );
    sm_hex_display digit_3 ( h7segment [15:12] , HEX3 [6:0] );
    sm_hex_display digit_2 ( h7segment [11: 8] , HEX2 [6:0] );
    sm_hex_display digit_1 ( h7segment [ 7: 4] , HEX1 [6:0] );
    sm_hex_display digit_0 ( h7segment [ 3: 0] , HEX0 [6:0] );

    sm_hex_display_8 hex_display
    (
        .clock (CLOCK_50),
        .resetn (KEY[0]),
        .number (dbgRaw),

        .seven_segments (GPIO[25:19]),
        .anodes (GPIO[18:15])
    );

endmodule
