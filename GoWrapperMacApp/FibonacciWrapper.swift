//
//  FibonacciWrapper.swift
//  GoWrapperMacApp
//
//  Created by Zeeshan Waheed on 05/12/2025.
//

import Foundation

func computeFibonacci(n: Int) -> [Int] {
    let ptr = Fibonacci(Int32(n))  // direct call into Go
    
    var arr: [Int] = []
    for i in 0..<n {
        arr.append(Int(ptr![i]))
    }
    
    free(ptr) // free C memory allocated by Go
    return arr
}
