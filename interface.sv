`include "defines.svh"
interface apb_if(input logic PCLK);
logic [`DATA_WIDTH-1:0] PWDATA;
logic [`ADDR_WIDTH-1:0] PADDR;
logic [`DATA_WIDTH/8-1:0] PSTRB;
logic PWRITE;
logic PENABLE;
logic PREADY;
logic [`DATA_WIDTH-1:0] PRDATA;
logic PSLVERR;
logic PSEL;
logic PRESETn;
/*property p_reset;
    @(posedge PCLK) !PRESETn |-> (PRDATA==0) && (PSLVERR==0);
endproperty
assert property(p_reset);
property p_stable_addr;
    @(posedge PCLK)  disable iff(!PRESETn) (PSEL && PENABLE) |-> $stable(PADDR);
endproperty
assert property(p_stable_addr);
property p_stable_wdata;
    @(posedge PCLK) disable iff(!PRESETn) (PSEL && PENABLE && PWRITE) |-> $stable(PWDATA);
endproperty
assert property(p_stable_wdata);
property p_stable_control;
    @(posedge PCLK) disable iff(!PRESETn) (PSEL && PENABLE) |-> $stable(PWRITE);
endproperty
assert property(p_stable_control);
property p_stable_pstrb;
    @(posedge PCLK) disable iff(!PRESETn) (PSEL && PENABLE && PWRITE) |-> $stable(PSTRB);
endproperty
assert property(p_stable_pstrb);
property p_read_data_valid;
    @(posedge PCLK) disable iff(!PRESETn) (PSEL && PENABLE && !PWRITE && PREADY) |-> !$isunknown(PRDATA);
endproperty
assert property(p_read_data_valid);
property invalid_addr;
    @(posedge PCLK) disable iff(!PRESETn) (PSEL && PENABLE && PREADY && (PADDR >= `MEM_DEPTH)) |-> PSLVERR;
endproperty
assert property(invalid_addr);
property valid_addr;
    @(posedge PCLK) disable iff(!PRESETn) (PSEL && PENABLE && PREADY && (PADDR < `MEM_DEPTH)) |-> !PSLVERR;
endproperty
assert property(valid_addr);
property pread_trans;
    @(posedge PCLK) disable iff(!PRESETn) (PSEL && PENABLE && PREADY && !PWRITE) |-> 1;
endproperty
assert property(pread_trans);
property pwrite_trans;
    @(posedge PCLK) disable iff(!PRESETn) (PSEL && PENABLE && PREADY && PWRITE) |-> 1;
endproperty
assert property(pwrite_trans);
property pready_high;
    @(posedge PCLK) disable iff(!PRESETn) PREADY == 1;
endproperty
assert property(pready_high);*/
clocking drv_cb @(posedge PCLK);
    default input #1 output #1;
    output PWDATA, PWRITE, PSEL, PENABLE, PADDR, PSTRB;
    input PRDATA, PREADY, PSLVERR;
    output PRESETn;
endclocking
clocking mon_cb @(posedge PCLK);
    default input #1 output #1;
    input PWRITE;
    input PRDATA, PREADY, PSLVERR;
endclocking
clocking ref_cb @(posedge PCLK);
    default input #1 output #1;
    input PWRITE;
    input PRDATA, PREADY, PSLVERR;
endclocking
modport DRV(clocking drv_cb);
modport MON(clocking mon_cb);
modport REF_SB(clocking ref_cb);
endinterface


















