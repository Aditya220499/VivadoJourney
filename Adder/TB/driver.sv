class driver;
    virtual adder_if vif;
    mailbox #(adder_tx) gen2drv;

    function new(virtual adder_if vif,
                 mailbox #(adder_tx) mb);
        this.vif = vif;
        this.gen2drv = mb;
    endfunction

    task run();
        forever begin
            adder_tx tx;
            gen2drv.get(tx);

            @(vif.cb);
            vif.cb.a <= tx.a;
            vif.cb.b <= tx.b;
            vif.cb.en <= 1;

            @(vif.cb);
            vif.cb.en <= 0;
        end
    endtask
endclass
