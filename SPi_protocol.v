module SPI(clk, reset, data_valid, data_MOSI, data_ready, data_MISO, MISO, MOSI, clk_flash, CS_flash);
 
parameter MOSI_DATA_BITWIDTH = 8;
parameter MISO_DATA_BITWIDTH = 8;
 
input clk, reset;
 
input data_valid;
input [MOSI_DATA_BITWIDTH-1:0] data_MOSI; // data going into the slave (SPI flash)
 
output reg data_ready;
output reg [MISO_DATA_BITWIDTH-1:0] data_MISO; // data originating from slave (SPI flash)
 
input MISO;
output reg MOSI;
output clk_flash;
output reg CS_flash;
 
reg [($clog2(MISO_DATA_BITWIDTH)-1):0] in_index;
reg [($clog2(MOSI_DATA_BITWIDTH)-1):0] out_index;
 
assign clk_flash = clk;
 
always @(posedge clk)
begin
    if(reset) begin
        CS_flash <= 1;
    end
 
    else begin
        if(data_valid) CS_flash <= 0;  // new SPI flash transaction
 
        else CS_flash <= 1;  // SPI flash transaction finished
    end
end
 
always @(posedge clk)
begin
    if(reset) begin
        MOSI <= 1;
        out_index <= 0;
    end
 
    else begin
        MOSI <= data_MOSI[out_index];
        out_index <= out_index + 1;
    end
end
 
always @(negedge clk) // this SPI flash sends out its data on the falling edge, so this flash controller has to follow SPI flash spec
begin
    if(reset) begin
        data_ready <= 0;
        data_MISO <= 0; // all zeroes
        in_index <= 0;  // the shift register 'data_MISO' stores the data starting from LSB
    end
 
    else begin
        if(in_index == MISO_DATA_BITWIDTH) begin
            data_ready <= 1;  // data collection from slave is complete or finished now
            in_index <= 0;
        end
 
        else begin
            data_ready <= 0;
 
            if(CS_flash && !data_ready) begin // collect data from slave (SPI flash) during the transaction
                data_MISO[in_index] <= MISO;
                in_index <= in_index + 1;
            end
        end
    end
end
 
endmodule