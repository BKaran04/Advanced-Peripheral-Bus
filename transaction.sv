class apb_transaction;
rand logic [`DATA_WIDTH-1:0] PWDATA;
rand logic [`ADDR_WIDTH-1:0] PADDR;
rand logic PSEL;
rand logic PENABLE;
rand logic PWRITE;
rand logic [`DATA_WIDTH/8-1:0] PSTRB;
logic [`DATA_WIDTH-1:0] PRDATA;
logic PREADY;
logic PSLVERR;
constraint check { 
	{PSEL, PENABLE} inside {0,2,3};
}
constraint cheeku { 
	{PSEL, PENABLE} != 1;
}
constraint c_strobe { 
	(PWRITE == 0) -> (PSTRB == 0);
}
constraint c_addr { 
	PADDR dist {[0:255]:= 80,[256:511]:= 20};
}
virtual function apb_transaction copy();
copy = new();
copy.PWDATA  = this.PWDATA;
copy.PADDR   = this.PADDR;
copy.PSEL    = this.PSEL;
copy.PENABLE = this.PENABLE;
copy.PWRITE  = this.PWRITE;
copy.PSTRB   = this.PSTRB;
return copy;
endfunction
endclass

class apb_reset_transaction extends apb_transaction;
constraint c_reset
{
    PWDATA == 32'h00000000;
    PADDR  == 0;
    PSEL   == 0;
    PENABLE== 0;
    PWRITE == 0;
    PSTRB  == 4'b0000;
}
virtual function apb_transaction copy();
    apb_reset_transaction copy1;
    copy1 = new();
    copy1.PWDATA  = this.PWDATA;
    copy1.PADDR   = this.PADDR;
    copy1.PSEL    = this.PSEL;
    copy1.PENABLE = this.PENABLE;
    copy1.PWRITE  = this.PWRITE;
    copy1.PSTRB   = this.PSTRB;
    return copy1;
endfunction
endclass

class apb_mid_reset_transaction extends apb_transaction;
constraint c_mid_reset
{
    PWDATA != 32'h00000000;
    PADDR inside {[0:255]};
    PSEL == 1;
    PENABLE == 0;
    PWRITE == 1;
    PSTRB != 4'b0000;
}
virtual function apb_transaction copy();
    apb_mid_reset_transaction copy2;
    copy2 = new();
    copy2.PWDATA  = this.PWDATA;
    copy2.PADDR   = this.PADDR;
    copy2.PSEL    = this.PSEL;
    copy2.PENABLE = this.PENABLE;
    copy2.PWRITE  = this.PWRITE;
    copy2.PSTRB   = this.PSTRB;
    return copy2;
endfunction
endclass

class apb_single_wr_rd_transaction extends apb_transaction;
constraint c_wr_rd
{
    PADDR inside {[0:255]};
    PWRITE inside {[0:1]};
    PSTRB inside {4'b1111};
}
virtual function apb_transaction copy();
    apb_single_wr_rd_transaction copy3;
    copy3 = new();
    copy3.PWDATA  = this.PWDATA;
    copy3.PADDR   = this.PADDR;
    copy3.PSEL    = this.PSEL;
    copy3.PENABLE = this.PENABLE;
    copy3.PWRITE  = this.PWRITE;
    copy3.PSTRB   = this.PSTRB;
    return copy3;
endfunction
endclass

class apb_b2b_write_transaction extends apb_transaction;
constraint c_b2b_write
{
    PWRITE == 1;
    PADDR inside {[0:255]};
    PSTRB != 4'b0000;
}
virtual function apb_transaction copy();
    apb_b2b_write_transaction copy4;
    copy4 = new();
    copy4.PWDATA  = this.PWDATA;
    copy4.PADDR   = this.PADDR;
    copy4.PSEL    = this.PSEL;
    copy4.PENABLE = this.PENABLE;
    copy4.PWRITE  = this.PWRITE;
    copy4.PSTRB   = this.PSTRB;
    return copy4;
endfunction
endclass

class apb_b2b_read_transaction extends apb_transaction;

constraint c_b2b_read
{
    PWRITE == 0;
    PADDR inside {[0:255]};
    PSTRB == 4'b0000;
}

virtual function apb_transaction copy();
    apb_b2b_read_transaction copy5;
    copy5 = new();
    copy5.PWDATA  = this.PWDATA;
    copy5.PADDR   = this.PADDR;
    copy5.PSEL    = this.PSEL;
    copy5.PENABLE = this.PENABLE;
    copy5.PWRITE  = this.PWRITE;
    copy5.PSTRB   = this.PSTRB;
    return copy5;
endfunction
endclass

class apb_single_byte_transaction extends apb_transaction;
constraint c_single_byte
{
    PWRITE == 1;
    PADDR inside {[0:255]};
    PSTRB inside
    {4'b0001,4'b0010,4'b0100,4'b1000};
}
virtual function apb_transaction copy();
    apb_single_byte_transaction copy6;
    copy6 = new();
    copy6.PWDATA  = this.PWDATA;
    copy6.PADDR   = this.PADDR;
    copy6.PSEL    = this.PSEL;
    copy6.PENABLE = this.PENABLE;
    copy6.PWRITE  = this.PWRITE;
    copy6.PSTRB   = this.PSTRB;
    return copy6;
endfunction
endclass

class apb_halfword_transaction extends apb_transaction;
constraint c_halfword
{
    PWRITE == 1;
    PADDR inside {[0:255]};
    PSTRB inside {4'b0011,4'b1100};
}
virtual function apb_transaction copy();
    apb_halfword_transaction copy7;
    copy7 = new();
    copy7.PWDATA  = this.PWDATA;
    copy7.PADDR   = this.PADDR;
    copy7.PSEL    = this.PSEL;
    copy7.PENABLE = this.PENABLE;
    copy7.PWRITE  = this.PWRITE;
    copy7.PSTRB   = this.PSTRB;
    return copy7;
endfunction
endclass

class apb_sparse_strobe_transaction extends apb_transaction;
constraint c_sparse_strobe
{
    PWRITE == 1;
    PADDR inside {[0:255]};
    PSTRB inside
    {4'b0101,4'b1010,4'b1001,4'b0110};
}
virtual function apb_transaction copy();
    apb_sparse_strobe_transaction copy8;
    copy8 = new();
    copy8.PWDATA  = this.PWDATA;
    copy8.PADDR   = this.PADDR;
    copy8.PSEL    = this.PSEL;
    copy8.PENABLE = this.PENABLE;
    copy8.PWRITE  = this.PWRITE;
    copy8.PSTRB   = this.PSTRB;
    return copy8;
endfunction
endclass

class apb_fullword_transaction extends apb_transaction;
constraint c_fullword
{
    PWRITE == 1;
    PADDR inside {[0:255]};
    PSTRB == 4'b1111;
}
virtual function apb_transaction copy();
    apb_fullword_transaction copy9;
    copy9 = new();
    copy9.PWDATA  = this.PWDATA;
    copy9.PADDR   = this.PADDR;
    copy9.PSEL    = this.PSEL;
    copy9.PENABLE = this.PENABLE;
    copy9.PWRITE  = this.PWRITE;
    copy9.PSTRB   = this.PSTRB;
    return copy9;
endfunction
endclass

class apb_invalid_write_transaction extends apb_transaction;
constraint c_invalid_write
{
    PWRITE == 1;
    PADDR inside {[256:511]};
    PSTRB != 4'b0000;
}
virtual function apb_transaction copy();
    apb_invalid_write_transaction copy10;
    copy10 = new();
    copy10.PWDATA  = this.PWDATA;
    copy10.PADDR   = this.PADDR;
    copy10.PSEL    = this.PSEL;
    copy10.PENABLE = this.PENABLE;
    copy10.PWRITE  = this.PWRITE;
    copy10.PSTRB   = this.PSTRB;
    return copy10;
endfunction
endclass

class apb_invalid_read_transaction extends apb_transaction;
constraint c_invalid_read
{
    PWRITE == 0;
    PADDR inside {[256:511]};
    PSTRB == 4'b0000;
}
virtual function apb_transaction copy();
    apb_invalid_read_transaction copy11;
    copy11 = new();
    copy11.PWDATA  = this.PWDATA;
    copy11.PADDR   = this.PADDR;
    copy11.PSEL    = this.PSEL;
    copy11.PENABLE = this.PENABLE;
    copy11.PWRITE  = this.PWRITE;
    copy11.PSTRB   = this.PSTRB;
    return copy11;
endfunction
endclass

class apb_three_byte_transaction extends apb_transaction;
constraint c_three_byte
{
    PWRITE == 1;
    PADDR inside {[0:255]};
    PSTRB inside
    {4'b0111,4'b1011,4'b1101,4'b1110};
}
virtual function apb_transaction copy();
    apb_three_byte_transaction copy12;
    copy12 = new();
    copy12.PWDATA  = this.PWDATA;
    copy12.PADDR   = this.PADDR;
    copy12.PSEL    = this.PSEL;
    copy12.PENABLE = this.PENABLE;
    copy12.PWRITE  = this.PWRITE;
    copy12.PSTRB   = this.PSTRB;
    return copy12;
endfunction
endclass
