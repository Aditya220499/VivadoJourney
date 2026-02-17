class adder_test extends uvm_test;

  adder_env env;

  `uvm_component_utils(adder_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    env = adder_env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    adder_seq seq;
    phase.raise_objection(this);

    seq = adder_seq::type_id::create("seq");
    seq.start(env.drv);

    phase.drop_objection(this);
  endtask

endclass
