package adder_pkg;

  // ======================
  // TRANSACTION
  // ======================
  class adder_tx;

    rand bit [7:0] a;
    rand bit [7:0] b;

    constraint overflow_case {
       a > 200;
       b > 200;
    }

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

          // wait 1 cycle for DUT output
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

    mailbox #(adder_tx) exp_mb;
    mailbox #(adder_tx) act_mb;

    function new(mailbox #(adder_tx) exp,
                 mailbox #(adder_tx) act);
      exp_mb = exp;
      act_mb = act;
    endfunction

    task run();
      forever begin
        adder_tx exp_tx;
        adder_tx act_tx;

        exp_mb.get(exp_tx);
        act_mb.get(act_tx);

        if (exp_tx.expected_sum != act_tx.actual_sum) begin
          $error("Mismatch: expected=%0d actual=%0d",
                  exp_tx.expected_sum,
                  act_tx.actual_sum);
        end
        else begin
          $display("PASS: a=%0d b=%0d sum=%0d",
                    act_tx.a,
                    act_tx.b,
                    act_tx.actual_sum);
        end
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
