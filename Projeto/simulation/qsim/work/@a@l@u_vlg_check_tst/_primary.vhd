library verilog;
use verilog.vl_types.all;
entity ALU_vlg_check_tst is
    port(
        AC              : in     vl_logic_vector(39 downto 0);
        MBR             : in     vl_logic_vector(39 downto 0);
        MQ              : in     vl_logic_vector(39 downto 0);
        sampler_rx      : in     vl_logic
    );
end ALU_vlg_check_tst;
