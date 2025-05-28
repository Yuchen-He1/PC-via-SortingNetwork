import cocotb
from cocotb.triggers import Timer
import random

@cocotb.test()
async def pc_fa_7_3_test(dut):
    """Test for (7,3) FA-based parallel counter (pc_fa_7_3)"""
    dut._log.info("Starting test for pc_fa_7_3")

    for i in range(2**7):  # Iterate through all 128 possible inputs
        input_val = i
        dut.d.value = input_val

        await Timer(1, units='ns')  # Wait a short time for combinational logic to settle

        # Calculate expected count
        expected_count = bin(input_val).count('1')

        # Get actual count from DUT
        actual_count = dut.count_out.value.integer

        dut._log.info(f"Input: {input_val:07b}, Expected: {expected_count}, Got: {actual_count}")

        assert actual_count == expected_count, \
            f"Test failed! Input: {input_val:07b}, Expected count: {expected_count}, Actual count: {actual_count}"

    dut._log.info("Finished test for pc_fa_7_3") 