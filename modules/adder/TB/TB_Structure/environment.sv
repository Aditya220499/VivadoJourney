 class environment;

    generator gen;
    driver drv;
    monitor mon;
    scoreboard scb;

    mailbox #(adder_tx) gen2drv = new();
    mailbox #(adder_tx) gen2scb = new();
    mailbox #(adder_tx) mon2scb = new();

    function new(virtual adder_if vif);

      gen = new(gen2drv, gen2scb);
      drv = new(vif, gen2drv);
      mon = new(vif, mon2scb);
      scb = new(gen2scb, mon2scb);

    endfunction

    task run();
      fork
        gen.run();
        drv.run();
        mon.run();
        scb.run();
      join_none
    endtask

  endclass

endpackage
