import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def test_pc_fa_15_4_exhaustive(dut):
    """Test pc_fa_15_4 with all possible 15-bit input combinations"""
    
    total_tests = 2**15  # 32,768 test cases
    passed_tests = 0
    failed_tests = 0
    
    print(f"\n{'='*60}")
    print(f"Starting exhaustive test of pc_fa_15_4")
    print(f"Testing all {total_tests} possible 15-bit input combinations")
    print(f"{'='*60}")
    
    for i in range(total_tests):
        # Set the input
        dut.d.value = i
        
        # Wait for combinational logic to settle
        await Timer(10, units="ns")
        
        # Calculate expected output (count of 1's in binary representation)
        expected_count = bin(i).count('1')
        actual_count = int(dut.count_out.value)
        
        if actual_count == expected_count:
            passed_tests += 1
            status = "PASS"
        else:
            failed_tests += 1
            status = "FAIL"
        
        print(f"Test {i+1:5d}/32768: Input={i:015b} (dec:{i:5d}) Expected={expected_count:2d} Got={actual_count:2d} {status}")
        
        # Print progress every 4096 tests
        if (i + 1) % 4096 == 0:
            progress = ((i + 1) / total_tests) * 100
            print(f"Progress: {progress:5.1f}% - Tested {i + 1:5d}/{total_tests} cases, "
                  f"Passed: {passed_tests:5d}, Failed: {failed_tests:5d}")
    
    print(f"\n{'='*60}")
    print(f"EXHAUSTIVE TEST RESULTS:")
    print(f"Total tests:  {total_tests:5d}")
    print(f"Passed tests: {passed_tests:5d}")
    print(f"Failed tests: {failed_tests:5d}")
    print(f"Success rate: {(passed_tests/total_tests)*100:6.2f}%")
    print(f"{'='*60}\n")
    
    # Assert that all tests passed
    assert failed_tests == 0, f"Failed {failed_tests} out of {total_tests} tests" 