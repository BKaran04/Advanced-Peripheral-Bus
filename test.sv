class apb_test;
virtual apb_if.DRV drv_vif;
virtual apb_if.MON mon_vif;
virtual apb_if.REF_SB ref_vif;
apb_environment env;
function new(virtual apb_if.DRV drv_vif,virtual apb_if.MON mon_vif,virtual apb_if.REF_SB ref_vif);
    this.drv_vif = drv_vif;
    this.mon_vif = mon_vif;
    this.ref_vif = ref_vif;
endfunction
task run();
    env = new(drv_vif,mon_vif,ref_vif);
    env.build();
    env.start();
endtask
endclass

class apb_reset_test extends apb_test;
apb_reset_transaction trans_reset;
function new(virtual apb_if.DRV drv_vif, virtual apb_if.MON mon_vif,virtual apb_if.REF_SB ref_vif);
    super.new(drv_vif,mon_vif,ref_vif);
endfunction
task run();
    env = new(drv_vif,mon_vif,ref_vif);
    env.build();
    trans_reset = new();
    env.gen.blueprint = trans_reset;
    fork
        env.start();
        begin
            drv_vif.drv_cb.PRESETn <= 0;
            repeat(2) @(drv_vif.drv_cb);
            drv_vif.drv_cb.PRESETn <= 1;
        end
    join
endtask
endclass

class apb_mid_reset_test extends apb_test;
apb_mid_reset_transaction trans_mid;
function new(virtual apb_if.DRV drv_vif,virtual apb_if.MON mon_vif,virtual apb_if.REF_SB ref_vif);
    super.new(drv_vif,mon_vif,ref_vif);
endfunction
task run();
    env = new(drv_vif,mon_vif,ref_vif);
    env.build();
    trans_mid = new();
    env.gen.blueprint = trans_mid;
    fork
        env.start();
        begin
            drv_vif.drv_cb.PRESETn <= 1;
            repeat(5) @(drv_vif.drv_cb);
            drv_vif.drv_cb.PRESETn <= 0;
            repeat(2) @(drv_vif.drv_cb);
            drv_vif.drv_cb.PRESETn <= 1;
        end
    join
endtask
endclass

class apb_single_wr_rd_test extends apb_test;
apb_single_wr_rd_transaction trans_wr_rd;
function new(virtual apb_if.DRV drv_vif,virtual apb_if.MON mon_vif,virtual apb_if.REF_SB ref_vif);
    super.new(drv_vif,mon_vif,ref_vif);
endfunction
task run();
    env = new(drv_vif,mon_vif,ref_vif);
    env.build();
    trans_wr_rd = new();
    env.gen.blueprint = trans_wr_rd;
    env.start();
endtask
endclass

class apb_b2b_write_test extends apb_test;
apb_b2b_write_transaction trans_write;
function new(virtual apb_if.DRV drv_vif,virtual apb_if.MON mon_vif,virtual apb_if.REF_SB ref_vif);
    super.new(drv_vif,mon_vif,ref_vif);
endfunction
task run();
    env = new(drv_vif,mon_vif,ref_vif);
    env.build();
    trans_write = new();
    env.gen.blueprint = trans_write;
    env.start();
endtask
endclass

class apb_b2b_read_test extends apb_test;
apb_b2b_read_transaction trans_read;
function new(virtual apb_if.DRV drv_vif,virtual apb_if.MON mon_vif,virtual apb_if.REF_SB ref_vif);
    super.new(drv_vif,mon_vif,ref_vif);
endfunction
task run();
    env = new(drv_vif,mon_vif,ref_vif);
    env.build();
    trans_read = new();
    env.gen.blueprint = trans_read;
    env.start();
endtask
endclass

class apb_single_byte_test extends apb_test;
apb_single_byte_transaction trans_byte;
function new(virtual apb_if.DRV drv_vif,virtual apb_if.MON mon_vif,virtual apb_if.REF_SB ref_vif);
    super.new(drv_vif,mon_vif,ref_vif);
endfunction
task run();
    env = new(drv_vif,mon_vif,ref_vif);
    env.build();
    trans_byte = new();
    env.gen.blueprint = trans_byte;
    env.start();
endtask
endclass

class apb_halfword_test extends apb_test;
apb_halfword_transaction trans_halfword;
function new(virtual apb_if.DRV drv_vif,virtual apb_if.MON mon_vif,virtual apb_if.REF_SB ref_vif);
    super.new(drv_vif,mon_vif,ref_vif);
endfunction
task run();
    env = new(drv_vif,mon_vif,ref_vif);
    env.build();
    trans_halfword = new();
    env.gen.blueprint = trans_halfword;
    env.start();
endtask
endclass

class apb_sparse_strobe_test extends apb_test;
apb_sparse_strobe_transaction trans_sparse;
function new(virtual apb_if.DRV drv_vif,virtual apb_if.MON mon_vif,virtual apb_if.REF_SB ref_vif);
    super.new(drv_vif,mon_vif,ref_vif);
endfunction
task run();
    env = new(drv_vif,mon_vif,ref_vif);
    env.build();
    trans_sparse = new();
    env.gen.blueprint = trans_sparse;
    env.start();
endtask
endclass

class apb_fullword_test extends apb_test;
apb_fullword_transaction trans_fullword;
function new(virtual apb_if.DRV drv_vif,virtual apb_if.MON mon_vif,virtual apb_if.REF_SB ref_vif);
    super.new(drv_vif,mon_vif,ref_vif);
endfunction
task run();
    env = new(drv_vif,mon_vif,ref_vif);
    env.build();
    trans_fullword = new();
    env.gen.blueprint = trans_fullword;
    env.start();
endtask
endclass

class apb_invalid_write_test extends apb_test;
apb_invalid_write_transaction trans_invalid_write;
function new(virtual apb_if.DRV drv_vif,virtual apb_if.MON mon_vif,virtual apb_if.REF_SB ref_vif);
    super.new(drv_vif,mon_vif,ref_vif);
endfunction
task run();
    env = new(drv_vif,mon_vif,ref_vif);
    env.build();
    trans_invalid_write = new();
    env.gen.blueprint = trans_invalid_write;
    env.start();
endtask
endclass

class apb_invalid_read_test extends apb_test;
apb_invalid_read_transaction trans_invalid_read;
function new(virtual apb_if.DRV drv_vif,virtual apb_if.MON mon_vif,virtual apb_if.REF_SB ref_vif);
    super.new(drv_vif,mon_vif,ref_vif);
endfunction
task run();
    env = new(drv_vif,mon_vif,ref_vif);
    env.build();
    trans_invalid_read = new();
    env.gen.blueprint = trans_invalid_read;
    env.start();
endtask
endclass

class apb_three_byte_test extends apb_test;
apb_three_byte_transaction trans_three_byte;
function new(virtual apb_if.DRV drv_vif,virtual apb_if.MON mon_vif,virtual apb_if.REF_SB ref_vif);
    super.new(drv_vif,mon_vif,ref_vif);
endfunction
task run();
    env = new(drv_vif,mon_vif,ref_vif);
    env.build();
    trans_three_byte = new();
    env.gen.blueprint = trans_three_byte;
    env.start();
endtask
endclass

class apb_regression_test extends apb_test;
apb_reset_transaction tc01;
apb_mid_reset_transaction tc02;
apb_single_wr_rd_transaction tc03;
apb_b2b_write_transaction tc04;
apb_b2b_read_transaction tc05;
apb_single_byte_transaction tc06;
apb_halfword_transaction tc07;
apb_sparse_strobe_transaction tc08;
apb_fullword_transaction tc09;
apb_invalid_write_transaction tc10;
apb_invalid_read_transaction tc11;
apb_three_byte_transaction tc12;
function new(virtual apb_if.DRV drv_vif,virtual apb_if.MON mon_vif,virtual apb_if.REF_SB ref_vif);
    super.new(drv_vif,mon_vif,ref_vif);
endfunction
task run();
    env = new(drv_vif,mon_vif,ref_vif);
    env.build();
    
    tc01 = new();
    env.gen.blueprint = tc01;
    env.start();
    
    tc02 = new();
    env.gen.blueprint = tc02;
    env.start();
    
    tc03 = new();
    env.gen.blueprint = tc03;
    env.start();
    
    tc04 = new();
    env.gen.blueprint = tc04;
    env.start();
    
    tc05 = new();
    env.gen.blueprint = tc05;
    env.start();
    
    tc06 = new();
    env.gen.blueprint = tc06;
    env.start();
    
    tc07 = new();
    env.gen.blueprint = tc07;
    env.start();
    
    tc08 = new();
    env.gen.blueprint = tc08;
    env.start();
    
    tc09 = new();
    env.gen.blueprint = tc09;
    env.start();
    
    tc10 = new();
    env.gen.blueprint = tc10;
    env.start();
    
    tc11 = new();
    env.gen.blueprint = tc11;
    env.start();
    
    tc12 = new();
    env.gen.blueprint = tc12;
    env.start();
endtask
endclass
