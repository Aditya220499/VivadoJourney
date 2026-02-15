class adder_monitor extends uvm_monitor;

  virtual adder_if vif;
  uvm_analysis_port #(adder_tx) ap;

  `uvm_component_utils(adder_monitor)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    if (!uvm_config_db#(virtual adder_if)::get(this, "", "vif", vif))
      `uvm_fatal("MON", "Virtual interface not set")
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      @(vif.cb);

      if (vif.en) begin
        adder_tx tx;
        tx = adder_tx::type_id::create("tx");

        tx.a = vif.a;
        tx.b = vif.b;

        @(vif.cb);
        tx.actual_sum = vif.sum;

        ap.write(tx);
      end
    end
  endtask

endclass
