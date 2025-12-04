//
//  ViewController.swift
//  GoWrapperMacApp
//
//  Created by Zeeshan Waheed on 05/12/2025.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate {

    
    @IBOutlet weak var numberTxtField: NSTextField!
    @IBOutlet weak var computeBtn: NSButton!
    @IBOutlet weak var resultLabel: NSTextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the text field delegate to detect Enter key
        numberTxtField.delegate = self
    }
    
    // MARK: - Button Action
    @IBAction func computeBtnClicked(_ sender: Any) {
        computeAndShowResult()
    }
    
    // MARK: - Detect Enter Key Press
    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if commandSelector == #selector(NSResponder.insertNewline(_:)) {
            computeAndShowResult()
            return true
        }
        return false
    }
    
    // MARK: - Compute Logic
    func computeAndShowResult() {
        let inputValue = numberTxtField.integerValue
        
        if inputValue <= 0 || inputValue > 15 {
            resultLabel.stringValue = "Enter a number > 0 or <=15"
            return
        }
        
        let result = computeFibonacci(n: inputValue)
        
        // Update UI
        resultLabel.stringValue = "Fibonacci(\(inputValue)): \(result)"
        
        // Print to console
        print("Go Fibonacci Output:", result)
    }
}

