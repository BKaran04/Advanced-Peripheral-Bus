class apb_scoreboard;
apb_transaction ref2sb_trans;
apb_transaction mon2sb_trans;
mailbox #(apb_transaction) mbx_rs;
mailbox #(apb_transaction) mbx_ms;
int MATCH;
int MISMATCH;
function new(mailbox #(apb_transaction) mbx_rs,mailbox #(apb_transaction) mbx_ms);
    this.mbx_rs = mbx_rs;
    this.mbx_ms = mbx_ms;
endfunction
task start();
    for(int i=0;i<`num_transactions;i++)
    begin
        ref2sb_trans = new();
        mon2sb_trans = new();
        fork
        begin
            mbx_rs.get(ref2sb_trans);
            $display("SCOREBOARD REF : PRDATA=%0h PWRITE=%0b PREADY=%0b PSLVERR=%0b",ref2sb_trans.PRDATA,ref2sb_trans.PWRITE,ref2sb_trans.PREADY,ref2sb_trans.PSLVERR);
        end
        begin
            mbx_ms.get(mon2sb_trans);
            $display("SCOREBOARD MON : PRDATA=%0h PWRITE=%0b PREADY=%0b PSLVERR=%0b",mon2sb_trans.PRDATA,mon2sb_trans.PWRITE,mon2sb_trans.PREADY,mon2sb_trans.PSLVERR);
        end
        join
        compare_report();
    end
endtask
task compare_report();
    if(ref2sb_trans.PWRITE)
    begin
        if((ref2sb_trans.PREADY  == mon2sb_trans.PREADY) && (ref2sb_trans.PSLVERR == mon2sb_trans.PSLVERR))
        begin
            ++MATCH;
            $display("WRITE MATCH");
            $display("PREADY=%0b PSLVERR=%0b",mon2sb_trans.PREADY,mon2sb_trans.PSLVERR);
            $display("MATCH=%0d",MATCH);
        end
        else
        begin
            ++MISMATCH;
            $display("WRITE MISMATCH");
            $display("EXPECTED PREADY=%0b ACTUAL=%0b",ref2sb_trans.PREADY,mon2sb_trans.PREADY);
            $display("EXPECTED PSLVERR=%0b ACTUAL=%0b",ref2sb_trans.PSLVERR,mon2sb_trans.PSLVERR);
            $display("MISMATCH=%0d",MISMATCH);
        end
    end
    else
    begin
        if((ref2sb_trans.PRDATA  == mon2sb_trans.PRDATA) && (ref2sb_trans.PREADY  == mon2sb_trans.PREADY) && (ref2sb_trans.PSLVERR == mon2sb_trans.PSLVERR))
        begin
            MATCH++;
            $display("READ MATCH");
            $display("PRDATA=%0h",mon2sb_trans.PRDATA);
            $display("MATCH=%0d",MATCH);
        end
        else
        begin
            MISMATCH++;
            $display("READ MISMATCH");
            $display("EXPECTED PRDATA=%0h ACTUAL=%0h",ref2sb_trans.PRDATA,mon2sb_trans.PRDATA);
            $display("EXPECTED PREADY=%0b ACTUAL=%0b",ref2sb_trans.PREADY,mon2sb_trans.PREADY);
            $display("EXPECTED PSLVERR=%0b ACTUAL=%0b",ref2sb_trans.PSLVERR,mon2sb_trans.PSLVERR);
            $display("MISMATCH=%0d",MISMATCH);
        end
    end
endtask
endclass
