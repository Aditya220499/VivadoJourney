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
