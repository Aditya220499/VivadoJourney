module sync_fifo #( 
  parameter DEPTH = 4,
  parameter WIDTH = 8,
  parameter ALMOST = 1
)(
  input  wire             clk,
  input  wire             rst,

  input  wire             wr_en,
  input  wire [WIDTH-1:0] wr_data,

  input  wire             rd_en,
  output reg  [WIDTH-1:0] rd_data,

  output wire             full,
  output wire             empty,
  output wire             almost_full,
  output wire             almost_empty
);

  localparam ADDR_BITS = $clog2(DEPTH);

  reg [WIDTH-1:0] mem [0:DEPTH-1];
  reg [ADDR_BITS:0] wr_ptr;
  reg [ADDR_BITS:0] rd_ptr;

  // --------------------------------------------------
  // Status logic
  // --------------------------------------------------

  wire [ADDR_BITS:0] used;
  assign used = wr_ptr - rd_ptr;

  assign empty = (wr_ptr == rd_ptr);

  assign full =
    (wr_ptr[ADDR_BITS]     != rd_ptr[ADDR_BITS]) &&
    (wr_ptr[ADDR_BITS-1:0] == rd_ptr[ADDR_BITS-1:0]);

  assign almost_full  = (used >= (DEPTH - ALMOST));
  assign almost_empty = (used <= ALMOST);

  // --------------------------------------------------
  // Write logic
  // --------------------------------------------------

  always @(posedge clk) begin
    if (rst) begin
      wr_ptr <= 0;
    end else if (wr_en && !full) begin
      mem[wr_ptr[ADDR_BITS-1:0]] <= wr_data;
      wr_ptr <= wr_ptr + 1;
    end
  end

  // --------------------------------------------------
  // Read logic
  // --------------------------------------------------

  always @(posedge clk) begin
    if (rst) begin
      rd_ptr  <= 0;
      rd_data <= 0;
    end else if (rd_en && !empty) begin
      rd_data <= mem[rd_ptr[ADDR_BITS-1:0]];
      rd_ptr  <= rd_ptr + 1;
    end
  end

endmodule
