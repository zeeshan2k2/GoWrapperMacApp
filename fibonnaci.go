package main

/*
#include <stdlib.h>
*/
import "C" // Importing the C package to use C code features
import (
	"fmt" // Importing the unsafe package to work with memory pointers
	"unsafe"
)

// Importing fmt for printing

// Fibonacci is a C-exported function that calculates the Fibonacci sequence
// up to n terms and returns a pointer to an array of integers.
//
//export Fibonacci
func Fibonacci(n C.int) *C.int {
	// Allocate memory for the result array in C
	// The size of the memory allocated is n * size of int
	result := C.malloc(C.size_t(n) * C.size_t(unsafe.Sizeof(C.int(0))))

	// Typecast the result pointer to a Go slice to populate it
	// This allows us to treat the allocated memory as an array of C.int
	resultSlice := (*[1 << 30]C.int)(result)[:n:n]

	// Initialize the Fibonacci sequence
	if n > 0 {
		resultSlice[0] = 0 // The first Fibonacci number is 0
	}
	if n > 1 {
		resultSlice[1] = 1 // The second Fibonacci number is 1
	}

	// Calculate the Fibonacci sequence for the remaining terms
	for i := 2; i < int(n); i++ {
		resultSlice[i] = resultSlice[i-1] + resultSlice[i-2] // Each number is the sum of the two preceding ones
	}

	// Return a pointer to the C array
	return (*C.int)(result) // The caller is responsible for freeing this memory
}

func main() {
	// Define the number of Fibonacci terms you want
	n := 10

	// Call the Fibonacci function
	result := Fibonacci(C.int(n))

	// Typecast the result pointer back to a Go slice for printing
	resultSlice := (*[1 << 30]C.int)(unsafe.Pointer(result))[:n:n]

	// Print "This is the Fibonacci sequence"
	fmt.Println("This is the Fibonacci sequence:")

	// Print the Fibonacci sequence
	for _, value := range resultSlice {
		fmt.Println(value)
	}

	// Free the allocated C memory
	C.free(unsafe.Pointer(result))
}
