class apb_driver;
apb_transaction drv_trans;
mailbox #(apb_transaction) mbx_gd;
mailbox #(apb_transaction) mbx_dr;
virtual apb_if.DRV vif;
covergroup drv_cg;
pwdata : coverpoint drv_trans.PWDATA
{
    bins data = {[32'h0:32'hFFFFFFFF]};
}
paddr : coverpoint drv_trans.PADDR
{
    bins valid   = {[0:255]};
    bins invalid = {[256:511]};
}
psel : coverpoint drv_trans.PSEL
{
    bins sel[] = {0,1};
}
pwrite : coverpoint drv_trans.PWRITE
{
    bins read  = {0};
    bins write = {1};
}
pstrb : coverpoint drv_trans.PSTRB
{
    bins value[] = {[0:15]};
}
penable : coverpoint drv_trans.PENABLE
{
    bins en[] = {0,1};
}
cross pwrite,paddr;
cross pwrite,pwdata;
cross paddr,pstrb;
cross psel,penable {
	ignore_bins rest = binsof(psel) intersect {0} && binsof(penable) intersect {1};
}
endgroup
function new(mailbox #(apb_transaction) mbx_gd,mailbox #(apb_transaction) mbx_dr,virtual apb_if.DRV vif);
this.mbx_gd = mbx_gd;
this.mbx_dr = mbx_dr;
this.vif = vif;
drv_cg = new();
endfunction
task start(); 
repeat(3) @(vif.drv_cb); 
for(int i=0;i<`num_transactions;i=i+1) 
begin drv_trans = new(); 
mbx_gd.get(drv_trans); 
if(vif.drv_cb.PRESETn==0) 
begin 
repeat(1) @(vif.drv_cb); 
vif.drv_cb.PWDATA <= 0; 
vif.drv_cb.PADDR <= 0; 
vif.drv_cb.PSEL <= 0; 
vif.drv_cb.PENABLE <= 0; 
vif.drv_cb.PWRITE <= 0; 
vif.drv_cb.PSTRB <= 0; 
repeat(1)@(vif.drv_cb); 
$display("DRIVER RESET : PWDATA=%0h PADDR=%0h PSEL=%0b PENABLE=%0b PWRITE=%0b PSTRB=%0b TIME=%0t",vif.drv_cb.PWDATA,vif.drv_cb.PADDR,vif.drv_cb.PSEL,vif.drv_cb.PENABLE,vif.drv_cb.PWRITE,vif.drv_cb.PSTRB,$time); 
end 
else begin 
repeat(1) @(vif.drv_cb); 
vif.drv_cb.PWDATA <= drv_trans.PWDATA; 
vif.drv_cb.PADDR <= drv_trans.PADDR; 
vif.drv_cb.PSEL <= drv_trans.PSEL; 
vif.drv_cb.PENABLE <= drv_trans.PENABLE; 
vif.drv_cb.PWRITE <= drv_trans.PWRITE; 
vif.drv_cb.PSTRB <= drv_trans.PSTRB; 
repeat(1)@(vif.drv_cb); 
$display("DRIVER : PWDATA=%0h PADDR=%0h PSEL=%0b PENABLE=%0b PWRITE=%0b PSTRB=%0b TIME=%0t",drv_trans.PWDATA,drv_trans.PADDR,drv_trans.PSEL,drv_trans.PENABLE,drv_trans.PWRITE,drv_trans.PSTRB,$time); 
vif.drv_cb.PWRITE <= 0;
vif.drv_cb.PSEL<=0;
vif.drv_cb.PENABLE<=0;	
mbx_dr.put(drv_trans); 
drv_cg.sample(); 
$display("INPUT FUNCTIONAL COVERAGE = %0.2f%%",drv_cg.get_coverage()); 
end 
end 
endtask 
endclass
