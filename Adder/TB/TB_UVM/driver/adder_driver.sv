class adder_driver extends uvm_driver #(adder_tx);

  virtual adder_if vif;

  `uvm_component_utils(adder_driver)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    if (!uvm_config_db#(virtual adder_if)::get(this, "", "vif", vif))
      `uvm_fatal("DRV", "Virtual interface not set")
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      adder_tx tx;
      seq_item_port.get_next_item(tx);

      @(vif.cb);
      vif.cb.a <= tx.a;
      vif.cb.b <= tx.b;
      vif.cb.en <= 1;

      @(vif.cb);
      vif.cb.en <= 0;

      seq_item_port.item_done();
    end
  endtask

endclass
