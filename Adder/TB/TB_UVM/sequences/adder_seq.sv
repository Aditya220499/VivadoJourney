class adder_seq extends uvm_sequence #(adder_tx);

  `uvm_object_utils(adder_seq)

  function new(string name="adder_seq");
    super.new(name);
  endfunction

  virtual task body();
    repeat (10) begin
      adder_tx tx;
      tx = adder_tx::type_id::create("tx");
      start_item(tx);
      assert(tx.randomize());
      tx.compute();
      finish_item(tx);
    end
  endtask

endclass
