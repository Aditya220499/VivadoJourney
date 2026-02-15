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