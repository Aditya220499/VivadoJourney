class adder_scoreboard extends uvm_scoreboard;

  uvm_analysis_imp #(adder_tx, adder_scoreboard) imp;

  `uvm_component_utils(adder_scoreboard)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    imp = new("imp", this);
  endfunction

  virtual function void write(adder_tx tx);
    if (tx.actual_sum != tx.expected_sum)
      `uvm_error("SCB",
        $sformatf("Mismatch expected=%0d actual=%0d",
                  tx.expected_sum,
                  tx.actual_sum))
    else
      `uvm_info("SCB", "PASS", UVM_LOW);
  endfunction

endclass
