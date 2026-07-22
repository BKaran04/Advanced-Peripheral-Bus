class apb_monitor;
apb_transaction mon_trans;
mailbox #(apb_transaction) mbx_ms;
virtual apb_if.MON vif;
covergroup mon_cg;
prdata : coverpoint mon_trans.PRDATA
{
    bins data = {[32'h0:32'hFFFFFFFF]};
}
pslverr : coverpoint mon_trans.PSLVERR
{
    bins err    = {1};
    bins no_err = {0};
}
pready : coverpoint mon_trans.PREADY
{
    bins ready = {1};
    ignore_bins not_ready = {0};
}
endgroup
function new(virtual apb_if.MON vif,mailbox #(apb_transaction) mbx_ms);
    this.vif = vif;
    this.mbx_ms = mbx_ms;
    mon_cg = new();
endfunction
task start();
    repeat(4) @(vif.mon_cb);
    for(int i=0;i<`num_transactions;i++)
    begin
        mon_trans = new();
        repeat(1) @(vif.mon_cb);
        mon_trans.PRDATA   = vif.mon_cb.PRDATA;
        mon_trans.PREADY   = vif.mon_cb.PREADY;
        mon_trans.PSLVERR  = vif.mon_cb.PSLVERR;
        mon_trans.PWRITE   = vif.mon_cb.PWRITE;
        $display("MONITOR : PRDATA=%0h PWRITE=%0b PREADY=%0b PSLVERR=%0b TIME=%0t",mon_trans.PRDATA,mon_trans.PWRITE,mon_trans.PREADY,mon_trans.PSLVERR,$time);
        mbx_ms.put(mon_trans);
        mon_cg.sample();
        $display("OUTPUT FUNCTIONAL COVERAGE = %0.2f%%",mon_cg.get_coverage());
        repeat(1) @(vif.mon_cb);
    end
endtask
endclass 




