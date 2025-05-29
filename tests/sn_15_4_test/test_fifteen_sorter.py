import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def fifteen_sorter_test(dut):
    """Test for 15-output bit sorter (fifteen_sorter), taking 15 inputs."""
    print("🔍 Starting comprehensive test for fifteen_sorter")
    print("=" * 80)

    # Define input and output port names based on the fifteen_sorter module
    input_names = [f"in{i}" for i in range(1, 16)]  # in1 to in15
    output_names = [f"out{i}" for i in range(1, 16)]  # out1 to out15

    # Test some specific interesting cases first with detailed logging
    interesting_cases = [
        (0b000000000000000, "All zeros"),
        (0b111111111111111, "All ones"), 
        (0b101010101010101, "Alternating pattern (101010101010101)"),
        (0b010101010101010, "Alternating pattern (010101010101010)"),
        (0b111111110000000, "Half ones, half zeros"),
        (0b000000001111111, "Other half pattern"),
        (0b100000000000001, "Two ones at edges"),
        (0b011111111111110, "Thirteen ones in middle"),
        (0b110000000000011, "Two pairs of ones"),
        (0b000000100000000, "Single one in middle"),
        (0b100000000000000, "Single one at MSB"),
        (0b000000000000001, "Single one at LSB"),
        (0b111000000000111, "Three ones at each end"),
        (0b000111111111000, "Nine ones in middle"),
        (0b101101101101101, "Complex pattern"),
        (0b001001001001001, "Sparse pattern"),
    ]

    print("🧪 Testing interesting cases with detailed intermediate results:")
    print("-" * 80)
    
    for case_idx, (test_val, description) in enumerate(interesting_cases):
        print(f"\n📋 Case {case_idx+1}: {description}")
        print(f"   Input: {test_val:015b} (decimal: {test_val})")
        
        # Apply inputs to DUT
        input_bits = []
        for bit_idx in range(15):
            val_to_assign = (test_val >> bit_idx) & 1
            input_bits.append(val_to_assign)
            getattr(dut, input_names[bit_idx]).value = val_to_assign

        # Show how inputs are mapped
        input_mapping = [f"in{i+1}={input_bits[i]}" for i in range(15)]
        print(f"   Mapped: {', '.join(input_mapping[:8])}...")  # Show first 8 for brevity

        await Timer(5, units='ns')  # Give more time for signals to settle

        # Calculate expected output
        sorted_all_input_bits = sorted(input_bits)
        expected_output_bits = sorted_all_input_bits

        # Get actual output from DUT
        actual_output_bits = []
        for bit_idx in range(15):
            actual_output_bits.append(getattr(dut, output_names[bit_idx]).value.integer)

        # Show the sorting process
        print(f"   Input bits: {input_bits}")
        print(f"   Sorted: {sorted_all_input_bits}")
        print(f"   Expected: {expected_output_bits}")
        print(f"   DUT output: {actual_output_bits}")
        
        match = actual_output_bits == expected_output_bits
        print(f"   Result: {'✅ PASS' if match else '❌ FAIL'}")
        
        if not match:
            print(f"   ⚠️  MISMATCH DETAILS:")
            for i in range(15):
                status = "✓" if actual_output_bits[i] == expected_output_bits[i] else "✗"
                print(f"      out{i+1}: expected={expected_output_bits[i]}, got={actual_output_bits[i]} {status}")

        assert actual_output_bits == expected_output_bits, \
            f"Interesting case failed! Input: {test_val:015b}, Expected: {expected_output_bits}, Got: {actual_output_bits}"

    print("\n" + "=" * 80)
    print("🚀 Running exhaustive test on all 32768 input combinations...")
    
    # Counter for tracking results
    pass_count = 0
    fail_count = 0

    # Run exhaustive test with progress updates
    for i in range(2**15):
        input_bits = []
        for bit_idx in range(15):
            val_to_assign = (i >> bit_idx) & 1
            input_bits.append(val_to_assign)
            getattr(dut, input_names[bit_idx]).value = val_to_assign

        await Timer(1, units='ns')

        # Calculate expected output
        sorted_all_input_bits = sorted(input_bits)
        expected_output_bits = sorted_all_input_bits

        actual_output_bits = []
        for bit_idx in range(15):
            actual_output_bits.append(getattr(dut, output_names[bit_idx]).value.integer)

        # Check result
        if actual_output_bits == expected_output_bits:
            pass_count += 1
        else:
            fail_count += 1
            print(f"\n❌ FAILURE at test {i+1}/32768:")
            print(f"   Input: {i:015b} → {input_bits}")
            print(f"   Expected: {expected_output_bits}")
            print(f"   Got: {actual_output_bits}")

        # Show progress every 4096 test cases
        if (i + 1) % 4096 == 0:
            progress = (i + 1) / 32768 * 100
            print(f"📊 Progress: {i+1}/32768 ({progress:.1f}%) - Passes: {pass_count}, Fails: {fail_count}")

        # Assert for immediate failure on mismatch
        assert actual_output_bits == expected_output_bits, \
            f"Test failed at input {i:015b}: Expected {expected_output_bits}, Got {actual_output_bits}"

    print("\n" + "=" * 80)
    print(f"🎉 SUCCESS! All {pass_count} tests passed!")
    print(f"📈 Test Summary:")
    print(f"   Total tests: {pass_count + fail_count}")
    print(f"   Passed: {pass_count}")
    print(f"   Failed: {fail_count}")
    print("🏁 Test completed successfully!")
    print("=" * 80) 