`include "package.sv"
`include "interface.sv"
import apb_pkg::*;
module top();
bit PCLK;
bit PRESETn;
initial
begin
    PCLK = 0;
    forever #10 PCLK = ~PCLK;
end
initial
begin
    PRESETn = 1;
    @(posedge PCLK);
    PRESETn = 0;
    repeat(1) @(posedge PCLK);
    PRESETn = 1;
end
apb_if intrf(PCLK);
apb_slave #(.ADDR_WIDTH(`ADDR_WIDTH),.DATA_WIDTH(`DATA_WIDTH),.MEM_DEPTH(`MEM_DEPTH))DUV(.PCLK(PCLK),.PRESETn(PRESETn),.PADDR(intrf.PADDR),.PSEL(intrf.PSEL),.PENABLE(intrf.PENABLE),.PWRITE(intrf.PWRITE),.PWDATA(intrf.PWDATA),.PSTRB(intrf.PSTRB),.PRDATA(intrf.PRDATA),.PREADY(intrf.PREADY),.PSLVERR(intrf.PSLVERR));
apb_test tb = new(intrf.DRV,intrf.MON,intrf.REF_SB);
apb_reset_test t1 = new(intrf.DRV,intrf.MON,intrf.REF_SB);
apb_mid_reset_test t2 = new(intrf.DRV,intrf.MON,intrf.REF_SB);
apb_single_wr_rd_test t3 = new(intrf.DRV,intrf.MON,intrf.REF_SB);
apb_b2b_write_test t4 = new(intrf.DRV,intrf.MON,intrf.REF_SB);
apb_b2b_read_test t5 = new(intrf.DRV,intrf.MON,intrf.REF_SB);
apb_single_byte_test t6 = new(intrf.DRV,intrf.MON,intrf.REF_SB);
apb_halfword_test t7 = new(intrf.DRV,intrf.MON,intrf.REF_SB);
apb_sparse_strobe_test t8 = new(intrf.DRV,intrf.MON,intrf.REF_SB);
apb_fullword_test t9 = new(intrf.DRV,intrf.MON,intrf.REF_SB);
apb_invalid_write_test t10 = new(intrf.DRV,intrf.MON,intrf.REF_SB);
apb_invalid_read_test t11 = new(intrf.DRV,intrf.MON,intrf.REF_SB);
apb_three_byte_test t12 = new(intrf.DRV,intrf.MON,intrf.REF_SB);
apb_regression_test reg_tb = new(intrf.DRV,intrf.MON,intrf.REF_SB);
initial
begin
    //tb.run();
    //t1.run();
    //t2.run();
    //t3.run();
    //t4.run();
    //t5.run();
    //t6.run();
    //t7.run();
    //t8.run();
    //t9.run();
    //t10.run();
    //t11.run();
    //t12.run();
    reg_tb.run();
    $finish;
end
endmodule 
