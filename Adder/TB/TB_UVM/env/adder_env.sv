class adder_env extends uvm_env;

  adder_driver     drv;
  adder_monitor    mon;
  adder_scoreboard scb;

  `uvm_component_utils(adder_env)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    drv = adder_driver::type_id::create("drv", this);
    mon = adder_monitor::type_id::create("mon", this);
    scb = adder_scoreboard::type_id::create("scb", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    mon.ap.connect(scb.imp);
  endfunction

endclass
