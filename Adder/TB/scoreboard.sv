class scoreboard;
    mailbox #(adder_tx) mon2scb;

    function new(mailbox #(adder_tx) mb);
        mon2scb = mb;
    endfunction

    task run();
        forever begin
            adder_tx tx;
            mon2scb.get(tx);

            if (tx.expected_sum !== tx.a + tx.b)
                $error("Mismatch! a=%0d b=%0d sum=%0d",
                       tx.a, tx.b, tx.expected_sum);
            else
                $display("PASS: a=%0d b=%0d sum=%0d",
                         tx.a, tx.b, tx.expected_sum);
        end
    endtask
endclass
