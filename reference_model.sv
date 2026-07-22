class apb_reference_model;
apb_transaction ref_trans;
mailbox #(apb_transaction) mbx_dr;
mailbox #(apb_transaction) mbx_rs;
virtual apb_if.REF_SB vif;
bit [`DATA_WIDTH-1:0] mem[0:`MEM_DEPTH-1];
function new(mailbox #(apb_transaction) mbx_dr,mailbox #(apb_transaction) mbx_rs,virtual apb_if.REF_SB vif);
    this.mbx_dr = mbx_dr;
    this.mbx_rs = mbx_rs;
    this.vif    = vif;
endfunction
task start();
    for(int i=0;i<`num_transactions;i++)
    begin
        ref_trans = new();
        mbx_dr.get(ref_trans);
        repeat(1) @(vif.ref_cb);
        ref_trans.PREADY = 1;
        if(ref_trans.PADDR >= `MEM_DEPTH)
        begin
            ref_trans.PSLVERR = 1;
            ref_trans.PRDATA  = '0;
            $display("REFERENCE MODEL : INVALID ADDRESS=%0d",ref_trans.PADDR);
        end
        else
        begin
            ref_trans.PSLVERR = 0;
            if(ref_trans.PWRITE)
            begin
                if(ref_trans.PSTRB[0])
                    mem[ref_trans.PADDR][7:0]   = ref_trans.PWDATA[7:0];
                if(ref_trans.PSTRB[1])
                    mem[ref_trans.PADDR][15:8]  = ref_trans.PWDATA[15:8];
                if(ref_trans.PSTRB[2])
                    mem[ref_trans.PADDR][23:16] = ref_trans.PWDATA[23:16];
                if(ref_trans.PSTRB[3])
                    mem[ref_trans.PADDR][31:24] = ref_trans.PWDATA[31:24];
                ref_trans.PRDATA = '0;
                $display("REFERENCE MODEL WRITE");
                $display("ADDRESS=%0d DATA=%0h",ref_trans.PADDR,mem[ref_trans.PADDR]);
            end
            else
            begin
                ref_trans.PRDATA = mem[ref_trans.PADDR];
                $display("REFERENCE MODEL READ");
                $display("ADDRESS=%0d DATA=%0h",ref_trans.PADDR,ref_trans.PRDATA);
            end
        end
        mbx_rs.put(ref_trans);
    end
endtask
endclass
