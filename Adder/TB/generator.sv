class generator;

    mailbox #(adder_tx) gen2drv;
    mailbox #(adder_tx) gen2scb;

    function new(mailbox #(adder_tx) drv_mb,
                 mailbox #(adder_tx) scb_mb);
      gen2drv = drv_mb;
      gen2scb = scb_mb;
    endfunction

    task run();
      repeat (10) begin
        adder_tx tx = new();
        assert(tx.randomize());
        tx.compute();

        gen2drv.put(tx);   // send to driver
        gen2scb.put(tx);   // send expected to scoreboard
      end
    endtask

  endclass
