import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def pc_sn_15_4_test(dut):
    """Test for 15-input parallel counter (pc_sn_15_4), producing 4-bit count output."""
    print("🔍 Starting exhaustive test for pc_sn_15_4")
    print("=" * 80)
    print("🚀 Running exhaustive test on all 32768 input combinations...")
    print("Showing result for each iteration:")
    print("-" * 80)
    
    # Counter for tracking results
    pass_count = 0
    fail_count = 0

    # Run exhaustive test with detailed output for each iteration
    for i in range(2**15):
        # Apply input to DUT (using getattr since 'in' is a reserved keyword)
        getattr(dut, 'in').value = i

        await Timer(1, units='ns')

        # Calculate expected count by counting 1s in binary representation
        expected_count = bin(i).count('1')

        # Get actual output from DUT
        actual_count = dut.out.value.integer

        # Check result
        if actual_count == expected_count:
            pass_count += 1
            status = "✅ PASS"
        else:
            fail_count += 1
            status = "❌ FAIL"
            
        # Show result for each iteration
        print(f"Test {i+1:5d}/32768: Input={i:015b} (dec:{i:5d}) Expected={expected_count:2d} Got={actual_count:2d} {status}")
        
        if actual_count != expected_count:
            print(f"   ⚠️  DETAILED FAILURE:")
            print(f"      Input binary: {i:015b}")
            print(f"      Expected count: {expected_count}")
            print(f"      Actual count: {actual_count}")
            print(f"      Difference: {actual_count - expected_count}")

        # Show progress summary every 1000 test cases
        if (i + 1) % 1000 == 0:
            progress = (i + 1) / 32768 * 100
            print(f"📊 Progress Summary: {i+1}/32768 ({progress:.1f}%) - Passes: {pass_count}, Fails: {fail_count}")
            print("-" * 40)

        # Assert for immediate failure on mismatch
        assert actual_count == expected_count, \
            f"Test failed at input {i:015b}: Expected count {expected_count}, Got {actual_count}"

    print("\n" + "=" * 80)
    print(f"🎉 SUCCESS! All {pass_count} tests passed!")
    print(f"📈 Test Summary:")
    print(f"   Total tests: {pass_count + fail_count}")
    print(f"   Passed: {pass_count}")
    print(f"   Failed: {fail_count}")
    print("🏁 Test completed successfully!")
    print("=" * 80) 