class monitor;
    virtual adder_if vif;
    mailbox #(adder_tx) mon2scb;

    function new(virtual adder_if vif,
                 mailbox #(adder_tx) mb);
        this.vif = vif;
        this.mon2scb = mb;
    endfunction

    task run();
        forever begin
            @(vif.cb);
            if (vif.cb.en) begin
                adder_tx tx = new();
                tx.a = vif.cb.a;
                tx.b = vif.cb.b;
                @(vif.cb);
                tx.expected_sum = vif.cb.sum;
                mon2scb.put(tx);
            end
        end
    endtask
endclass
