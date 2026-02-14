package adder_pkg;

  // ======================
  // TRANSACTION
  // ======================
  class adder_tx;
    rand bit [7:0] a;
    rand bit [7:0] b;

    bit [8:0] expected_sum;
    bit [8:0] actual_sum;

    function void compute();
      expected_sum = a + b;
    endfunction
  endclass


  // ======================
  // GENERATOR
  // ======================
  class generator;
    mailbox #(adder_tx) gen2drv;

    function new(mailbox #(adder_tx) mb);
      gen2drv = mb;
    endfunction

    task run();
      repeat (10) begin
        adder_tx tx = new();
        assert(tx.randomize());
        tx.compute();
        gen2drv.put(tx);
      end
    endtask
  endclass


  // ======================
  // DRIVER
  // ======================
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


  // ======================
  // MONITOR
  // ======================
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

          @(vif.cb);
          tx.actual_sum = vif.sum;

          mon2scb.put(tx);
        end
      end
    endtask
  endclass


  // ======================
  // SCOREBOARD
  // ======================
  class scoreboard;
    mailbox #(adder_tx) mon2scb;

    function new(mailbox #(adder_tx) mb);
      mon2scb = mb;
    endfunction

    task run();
      forever begin
        adder_tx tx;
        mon2scb.get(tx);

        if (tx.actual_sum !== (tx.a + tx.b))
          $error("FAIL: a=%0d b=%0d expected=%0d got=%0d",
                 tx.a, tx.b, (tx.a + tx.b), tx.actual_sum);
        else
          $display("PASS: a=%0d b=%0d sum=%0d",
                   tx.a, tx.b, tx.actual_sum);
      end
    endtask
  endclass


  // ======================
  // ENVIRONMENT
  // ======================
  class environment;
    generator gen;
    driver drv;
    monitor mon;
    scoreboard scb;

    mailbox #(adder_tx) gen2drv = new();
    mailbox #(adder_tx) mon2scb = new();

    function new(virtual adder_if vif);
      gen = new(gen2drv);
      drv = new(vif, gen2drv);
      mon = new(vif, mon2scb);
      scb = new(mon2scb);
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
