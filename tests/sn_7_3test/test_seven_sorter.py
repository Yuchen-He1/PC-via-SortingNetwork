import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def seven_sorter_test(dut):
    """Test for 7-output bit sorter (seven_sorter), taking 8 inputs."""
    print("🔍 Starting comprehensive test for seven_sorter")
    print("=" * 80)

    # Define input and output port names based on the seven_sorter module
    input_names = [f"in{i}" for i in range(8)]  # in0 to in7
    output_names = [f"out{i}" for i in range(7)]  # out0 to out6

    # Test some specific interesting cases first with detailed logging
    interesting_cases = [
        (0b00000000, "All zeros"),
        (0b11111111, "All ones"), 
        (0b10101010, "Alternating pattern (10101010)"),
        (0b01010101, "Alternating pattern (01010101)"),
        (0b11110000, "Half ones, half zeros"),
        (0b00001111, "Other half pattern"),
        (0b10000001, "Two ones at edges"),
        (0b01111110, "Six ones in middle"),
        (0b11000011, "Two pairs of ones"),
        (0b00010000, "Single one in middle"),
        (0b10000000, "Single one at MSB"),
        (0b00000001, "Single one at LSB"),
    ]

    print("🧪 Testing interesting cases with detailed intermediate results:")
    print("-" * 80)
    
    for case_idx, (test_val, description) in enumerate(interesting_cases):
        print(f"\n📋 Case {case_idx+1}: {description}")
        print(f"   Input: {test_val:08b} (decimal: {test_val})")
        
        # Apply inputs to DUT
        input_bits = []
        for bit_idx in range(8):
            val_to_assign = (test_val >> bit_idx) & 1
            input_bits.append(val_to_assign)
            getattr(dut, input_names[bit_idx]).value = val_to_assign

        # Show how inputs are mapped
        input_mapping = [f"in{i}={input_bits[i]}" for i in range(8)]
        print(f"   Mapped: {', '.join(input_mapping)}")

        await Timer(2, units='ns')  # Give more time for signals to settle

        # Calculate expected output
        sorted_all_input_bits = sorted(input_bits)
        expected_output_bits = sorted_all_input_bits[:7]

        # Get actual output from DUT
        actual_output_bits = []
        for bit_idx in range(7):
            actual_output_bits.append(getattr(dut, output_names[bit_idx]).value.integer)

        # Show the sorting process
        print(f"   Input bits: {input_bits}")
        print(f"   Sorted all: {sorted_all_input_bits}")
        print(f"   Expected (smallest 7): {expected_output_bits}")
        print(f"   DUT output: {actual_output_bits}")
        
        # Detailed output mapping
        output_mapping = [f"out{i}={actual_output_bits[i]}" for i in range(7)]
        print(f"   Output mapping: {', '.join(output_mapping)}")
        
        match = actual_output_bits == expected_output_bits
        print(f"   Result: {'✅ PASS' if match else '❌ FAIL'}")
        
        if not match:
            print(f"   ⚠️  MISMATCH DETAILS:")
            for i in range(7):
                status = "✓" if actual_output_bits[i] == expected_output_bits[i] else "✗"
                print(f"      out{i}: expected={expected_output_bits[i]}, got={actual_output_bits[i]} {status}")

        assert actual_output_bits == expected_output_bits, \
            f"Interesting case failed! Input: {test_val:08b}, Expected: {expected_output_bits}, Got: {actual_output_bits}"

    print("\n" + "=" * 80)
    print("🚀 Running exhaustive test on all 256 input combinations...")
    
    # Counter for tracking results
    pass_count = 0
    fail_count = 0

    # Run exhaustive test with progress updates
    for i in range(2**8):
        input_bits = []
        for bit_idx in range(8):
            val_to_assign = (i >> bit_idx) & 1
            input_bits.append(val_to_assign)
            getattr(dut, input_names[bit_idx]).value = val_to_assign

        await Timer(1, units='ns')

        # Calculate expected output
        sorted_all_input_bits = sorted(input_bits)
        expected_output_bits = sorted_all_input_bits[:7]

        actual_output_bits = []
        for bit_idx in range(7):
            actual_output_bits.append(getattr(dut, output_names[bit_idx]).value.integer)

        # Check result
        if actual_output_bits == expected_output_bits:
            pass_count += 1
        else:
            fail_count += 1
            print(f"\n❌ FAILURE at test {i+1}/256:")
            print(f"   Input: {i:08b} → {input_bits}")
            print(f"   Expected: {expected_output_bits}")
            print(f"   Got: {actual_output_bits}")

        # Show progress every 64 test cases
        if (i + 1) % 64 == 0:
            progress = (i + 1) / 256 * 100
            print(f"📊 Progress: {i+1}/256 ({progress:.1f}%) - Passes: {pass_count}, Fails: {fail_count}")

        # Assert for immediate failure on mismatch
        assert actual_output_bits == expected_output_bits, \
            f"Test failed at input {i:08b}: Expected {expected_output_bits}, Got {actual_output_bits}"

    print("\n" + "=" * 80)
    print(f"🎉 SUCCESS! All {pass_count} tests passed!")
    print(f"📈 Test Summary:")
    print(f"   Total tests: {pass_count + fail_count}")
    print(f"   Passed: {pass_count}")
    print(f"   Failed: {fail_count}")
    print("🏁 Test completed successfully!")
    print("=" * 80) 