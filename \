class apb_generator;
apb_transaction blueprint;
mailbox #(apb_transaction) mbx_gd;
function new(mailbox #(apb_transaction) mbx_gd);
this.mbx_gd = mbx_gd;
blueprint = new();
endfunction
task start();
for(int i=0;i<`num_transactions;i=i+1)
begin
assert(blueprint.randomize()==1);
mbx_gd.put(blueprint.copy());
$display("GENERATOR : PWDATA=%0h PADDR=%0h PSEL=%0b PENABLE=%0b PWRITE=%0b PSTRB=%0b TIME=%0t",blueprint.PWDATA,blueprint.PADDR,blueprint.PSEL,blueprint.PENABLE,blueprint.PWRITE,blueprint.PSTRB,$time);
end
endtask
endclass
