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

        if (vif.en) begin
          adder_tx tx = new();

          tx.a = vif.a;
          tx.b = vif.b;

          // wait 1 cycle for DUT output
          @(vif.cb);
          tx.actual_sum = vif.sum;

          mon2scb.put(tx);
        end
      end
    endtask

  endclass
