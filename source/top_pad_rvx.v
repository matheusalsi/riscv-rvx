module top_pad_rvx (
    input        clock,
    input        reset_n,
    input        uart_rx,
    output       uart_tx,
    output       sclk,
    output       mosi,
    input        miso,
    output       cs,
    inout  [7:0] gpio,
    inout        i2c_sda,
    inout        i2c_scl
);

    // Parameters
    localparam TCM_SIZE_IN_BYTES      = 1024;
    localparam TCM_BOOT_IMAGE_PATH    = "";
    localparam SPI_BOOT_IMAGE_ADDRESS = 32'h00000000;
    localparam GPIO_WIDTH             = 8;
    localparam ENABLE_ZMMUL           = 1;

    // Internal wires (core side)
    wire        clock_c, reset_n_c, uart_rx_c, uart_tx_c;
    wire        sclk_c, mosi_c, miso_c, cs_c;
    wire [7:0]  gpio_in_c, gpio_oe_c, gpio_out_c;
    wire        sda_in_c, scl_in_c, sda_out_c, scl_out_c;

    // Polaridades derivadas (idênticas ao silício Silterra)
    wire        sda_oe   = ~sda_out_c;      // open-drain: OE = ~output
    wire        scl_oe   = ~scl_out_c;
    wire [7:0]  gpio_ie  = ~gpio_oe_c;      // receiver on quando NÃO dirige

    // ----- Corner cells -----
    CORNER CORNER0(); CORNER CORNER1(); CORNER CORNER2(); CORNER CORNER3();

    // ----- Power pads (4 conjuntos) -----
    VDD_NS VDD_0();  VSS_NS VSS_0();  IOVDD_NS IOVDD_0();  IOVSS_NS IOVSS_0();
    VDD_NS VDD_1();  VSS_NS VSS_1();  IOVDD_NS IOVDD_1();  IOVSS_NS IOVSS_1();
    VDD_NS VDD_2();  VSS_NS VSS_2();  IOVDD_NS IOVDD_2();  IOVSS_NS IOVSS_2();
    VDD_NS VDD_3();  VSS_NS VSS_3();  IOVDD_NS IOVDD_3();  IOVSS_NS IOVSS_3();

    // ----- Input pads -----
    I1025_NS PAD_CLK  (.PADIO(clock),   .R_EN(1'b1), .DOUT(clock_c));
    I1025_NS PAD_RSTN (.PADIO(reset_n), .R_EN(1'b1), .DOUT(reset_n_c));
    I1025_NS PAD_URX  (.PADIO(uart_rx), .R_EN(1'b1), .DOUT(uart_rx_c));
    I1025_NS PAD_MISO (.PADIO(miso),    .R_EN(1'b1), .DOUT(miso_c));

    // ----- Output pads -----
    D4I1025_NS PAD_UTX  (.DIN(uart_tx_c), .EN(1'b1), .PADIO(uart_tx));
    D4I1025_NS PAD_SCLK (.DIN(sclk_c),    .EN(1'b1), .PADIO(sclk));
    D4I1025_NS PAD_MOSI (.DIN(mosi_c),    .EN(1'b1), .PADIO(mosi));
    D4I1025_NS PAD_CS   (.DIN(cs_c),      .EN(1'b1), .PADIO(cs));

    // ----- I2C bidirectional pads (open-drain) -----
    B4I1025_NS PAD_SDA (
        .PADIO(i2c_sda), .DIN(1'b0), .EN(sda_oe),
        .DOUT(sda_in_c), .R_EN(1'b1),
        .PULL_UP(1'b0), .PULL_DOWN(1'b0)
    );
    B4I1025_NS PAD_SCL (
        .PADIO(i2c_scl), .DIN(1'b0), .EN(scl_oe),
        .DOUT(scl_in_c), .R_EN(1'b1),
        .PULL_UP(1'b0), .PULL_DOWN(1'b0)
    );

    // ----- GPIO bidirectional pads (instâncias explícitas) -----
    B4I1025_NS PAD_GPIO_0 (.PADIO(gpio[0]), .DIN(gpio_out_c[0]), .EN(gpio_oe_c[0]), .DOUT(gpio_in_c[0]), .R_EN(gpio_ie[0]), .PULL_UP(1'b0), .PULL_DOWN(1'b0));
    B4I1025_NS PAD_GPIO_1 (.PADIO(gpio[1]), .DIN(gpio_out_c[1]), .EN(gpio_oe_c[1]), .DOUT(gpio_in_c[1]), .R_EN(gpio_ie[1]), .PULL_UP(1'b0), .PULL_DOWN(1'b0));
    B4I1025_NS PAD_GPIO_2 (.PADIO(gpio[2]), .DIN(gpio_out_c[2]), .EN(gpio_oe_c[2]), .DOUT(gpio_in_c[2]), .R_EN(gpio_ie[2]), .PULL_UP(1'b0), .PULL_DOWN(1'b0));
    B4I1025_NS PAD_GPIO_3 (.PADIO(gpio[3]), .DIN(gpio_out_c[3]), .EN(gpio_oe_c[3]), .DOUT(gpio_in_c[3]), .R_EN(gpio_ie[3]), .PULL_UP(1'b0), .PULL_DOWN(1'b0));
    B4I1025_NS PAD_GPIO_4 (.PADIO(gpio[4]), .DIN(gpio_out_c[4]), .EN(gpio_oe_c[4]), .DOUT(gpio_in_c[4]), .R_EN(gpio_ie[4]), .PULL_UP(1'b0), .PULL_DOWN(1'b0));
    B4I1025_NS PAD_GPIO_5 (.PADIO(gpio[5]), .DIN(gpio_out_c[5]), .EN(gpio_oe_c[5]), .DOUT(gpio_in_c[5]), .R_EN(gpio_ie[5]), .PULL_UP(1'b0), .PULL_DOWN(1'b0));
    B4I1025_NS PAD_GPIO_6 (.PADIO(gpio[6]), .DIN(gpio_out_c[6]), .EN(gpio_oe_c[6]), .DOUT(gpio_in_c[6]), .R_EN(gpio_ie[6]), .PULL_UP(1'b0), .PULL_DOWN(1'b0));
    B4I1025_NS PAD_GPIO_7 (.PADIO(gpio[7]), .DIN(gpio_out_c[7]), .EN(gpio_oe_c[7]), .DOUT(gpio_in_c[7]), .R_EN(gpio_ie[7]), .PULL_UP(1'b0), .PULL_DOWN(1'b0));

    // ----- Core -----
    rvx #(
        .TCM_SIZE_IN_BYTES      (TCM_SIZE_IN_BYTES),
        .TCM_BOOT_IMAGE_PATH    (TCM_BOOT_IMAGE_PATH),
        .SPI_BOOT_IMAGE_ADDRESS (SPI_BOOT_IMAGE_ADDRESS),
        .GPIO_WIDTH             (GPIO_WIDTH),
        .ENABLE_ZMMUL           (ENABLE_ZMMUL)
    ) u_core (
        .clock              (clock_c),
        .reset_n            (reset_n_c),
        .uart_rx            (uart_rx_c),
        .uart_tx            (uart_tx_c),
        .gpio_input         (gpio_in_c),
        .gpio_output_enable (gpio_oe_c),
        .gpio_output        (gpio_out_c),
        .sclk               (sclk_c),
        .mosi               (mosi_c),
        .miso               (miso_c),
        .cs                 (cs_c),
        .i2c_sda_input      (sda_in_c),
        .i2c_scl_input      (scl_in_c),
        .i2c_sda_output     (sda_out_c),
        .i2c_scl_output     (scl_out_c)
    );

endmodule

// module top_pad_rvx(
//     input  clock,          //input
//     input  reset_n,        //input
//     input  uart_rx,        //input
//     input  miso,           //input
//     output uart_tx,        //output
//     output sclk,           //output
//     output mosi,           //output
//     output cs,             //output
//     inout  [7:0] gpio,     //inout
//     inout  i2c_sda,        //inout
//     inout  i2c_scl         //inout
// );

//     // Parameters
//     localparam TCM_SIZE_IN_BYTES      = 128;
//     localparam TCM_BOOT_IMAGE_PATH    = "";
//     localparam SPI_BOOT_IMAGE_ADDRESS = 32'h00000000;
//     localparam GPIO_WIDTH             = 8;
//     localparam ENABLE_ZMMUL           = 1;

//     // Inters wires
//     wire        clock_c, reset_n_c, uart_rx_c, uart_tx_c;
//     wire        sclk_c, mosi_c, miso_c, cs_c;
//     wire [7:0]  gpio_in_c, gpio_oe_c, gpio_out_c;
//     wire        sda_in_c, scl_in_c, sda_out_c, scl_out_c;

//     // ----- Corner cells -----
//     CORNER CORNER0(); CORNER CORNER1(); CORNER CORNER2(); CORNER CORNER3();

//     // ----- Power pads (4 conjuntos) -----
//     VDD_NS VDD_0();  VSS_NS VSS_0();  IOVDD_NS IOVDD_0();  IOVSS_NS IOVSS_0();
//     VDD_NS VDD_1();  VSS_NS VSS_1();  IOVDD_NS IOVDD_1();  IOVSS_NS IOVSS_1();
//     VDD_NS VDD_2();  VSS_NS VSS_2();  IOVDD_NS IOVDD_2();  IOVSS_NS IOVSS_2();
//     VDD_NS VDD_3();  VSS_NS VSS_3();  IOVDD_NS IOVDD_3();  IOVSS_NS IOVSS_3();

//     // ----- Input pads -----
//     I1025_NS PAD_CLK   (.PADIO(clock),   .R_EN(1'b1), .DOUT(clock_c));
//     I1025_NS PAD_RSTN  (.PADIO(reset_n), .R_EN(1'b1), .DOUT(reset_n_c));
//     I1025_NS PAD_URX   (.PADIO(uart_rx), .R_EN(1'b1), .DOUT(uart_rx_c));
//     I1025_NS PAD_MISO  (.PADIO(miso),    .R_EN(1'b1), .DOUT(miso_c));

//     // ----- Output pads -----
//     D4I1025_NS PAD_UTX  (.DIN(uart_tx_c), .EN(1'b1), .PADIO(uart_tx));
//     D4I1025_NS PAD_SCLK (.DIN(sclk_c),    .EN(1'b1), .PADIO(sclk));
//     D4I1025_NS PAD_MOSI (.DIN(mosi_c),    .EN(1'b1), .PADIO(mosi));
//     D4I1025_NS PAD_CS   (.DIN(cs_c),      .EN(1'b1), .PADIO(cs));

//     // core
//     rvx #(
//         .TCM_SIZE_IN_BYTES      (TCM_SIZE_IN_BYTES),
//         .TCM_BOOT_IMAGE_PATH    (TCM_BOOT_IMAGE_PATH),
//         .SPI_BOOT_IMAGE_ADDRESS (SPI_BOOT_IMAGE_ADDRESS),
//         .GPIO_WIDTH             (GPIO_WIDTH),
//         .ENABLE_ZMMUL           (ENABLE_ZMMUL)
//     ) u_core (
//         .clock              (clock_c),
//         .reset_n            (reset_n_c),
//         .uart_rx            (uart_rx_c),
//         .uart_tx            (uart_tx_c),
//         .gpio_input         (gpio_in_c),
//         .gpio_output_enable (gpio_oe_c),
//         .gpio_output        (gpio_out_c),
//         .sclk               (sclk_c),
//         .mosi               (mosi_c),
//         .miso               (miso_c),
//         .cs                 (cs_c),
//         .i2c_sda_input      (sda_in_c),
//         .i2c_scl_input      (scl_in_c),
//         .i2c_sda_output     (sda_out_c),
//         .i2c_scl_output     (scl_out_c)
//     );

// endmodule