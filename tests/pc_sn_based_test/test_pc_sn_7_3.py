import cocotb
from cocotb.triggers import Timer
import random

@cocotb.test()
async def pc_sn_7_3_test(dut):
    """Test for (7,3) SN-based parallel counter (pc_sn_7_3)"""
    dut._log.info("Starting test for pc_sn_7_3")

    # Test some specific cases first with clear output
    debug_cases = [
        0b0000000,  # All zeros
        0b1111111,  # All ones
        0b0000001,  # Single one
        0b0000011,  # Two ones
        0b0000111,  # Three ones
        0b0001111,  # Four ones
        0b0011111,  # Five ones
        0b0111111,  # Six ones
        0b1010101,  # Alternating pattern
    ]

    print("🔍 Testing specific cases:")
    print("=" * 60)

    for case_idx, input_val in enumerate(debug_cases):
        print(f"\n📋 Case {case_idx+1}: Input = {input_val:07b} (decimal: {input_val})")
        
        getattr(dut, 'in').value = input_val
        await Timer(2, units='ns')  # Give time for signals to settle

        # Calculate expected count
        expected_count = bin(input_val).count('1')

        # Get actual count from DUT
        actual_count = dut.out.value.integer

        print(f"   Expected count: {expected_count}")
        print(f"   Actual count: {actual_count}")
        print(f"   Output bits: out[2:0] = {dut.out.value.integer:03b}")

        match = actual_count == expected_count
        print(f"   Result: {'✅ PASS' if match else '❌ FAIL'}")

        if not match:
            print(f"   ⚠️ MISMATCH: Expected {expected_count}, got {actual_count}")

        assert actual_count == expected_count, \
            f"Test case failed! Input: {input_val:07b}, Expected: {expected_count}, Got: {actual_count}"

    print("\n" + "=" * 60)
    print("🚀 Running exhaustive test on all 128 input combinations...")

    pass_count = 0
    fail_count = 0

    # Run the full test
    for i in range(2**7):  # Iterate through all 128 possible inputs
        input_val = i
        getattr(dut, 'in').value = input_val

        await Timer(1, units='ns')  # Wait for combinational logic to settle

        # Calculate expected count
        expected_count = bin(input_val).count('1')

        # Get actual count from DUT
        actual_count = dut.out.value.integer

        # Track results
        if actual_count == expected_count:
            pass_count += 1
        else:
            fail_count += 1
            print(f"\n❌ FAILURE at input {input_val:07b}:")
            print(f"   Expected count: {expected_count}")
            print(f"   Actual count: {actual_count}")

        # Show progress every 32 test cases
        if (i + 1) % 32 == 0:
            progress = (i + 1) / 128 * 100
            print(f"📊 Progress: {i+1}/128 ({progress:.1f}%) - Passes: {pass_count}, Fails: {fail_count}")

        assert actual_count == expected_count, \
            f"Test failed! Input: {input_val:07b}, Expected count: {expected_count}, Actual count: {actual_count}"

    print(f"\n🎉 SUCCESS! All {pass_count} tests passed!")
    print(f"📈 Final Summary:")
    print(f"   Total tests: {pass_count + fail_count}")
    print(f"   Passed: {pass_count}")
    print(f"   Failed: {fail_count}")
    dut._log.info("Finished test for pc_sn_7_3") 