//
//  InterfaceController.swift
//  Calculator WatchKit Extension
//
//  Created by appacmp on 25/07/15.
//  Copyright (c) 2015 appcamp. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    var display = "0"
    var operand1 = "0"
    var operation = "="
    var isUserInTheMiddleOfTyping = false
    
    let initialDigits = ["1","2","3","4","5","6","7","8","9","0"]
    let initialOperators = ["+","-","*","/","="]

    @IBOutlet weak var displayLabel: WKInterfaceLabel!
    @IBAction func pushOperation() {
        presentTextInputControllerWithSuggestions(initialOperators, allowedInputMode: .Plain) { (selectedOperation) -> Void in
            if let operation = selectedOperation[0] as? String {
                switch operation{
                    case "+": self.processOperation("+")
                    case "-": self.processOperation("-")
                    case "*": self.processOperation("*")
                    case "/": self.processOperation("/")
                    case "=": self.processEquals()
                default: self.display = "0"
                }
                self.isUserInTheMiddleOfTyping = false


                
            }
        }
    }
    func processOperation(op: String){
        operation = op
        operand1 = display
        displayLabel.setText(op)
    }
    @IBAction func pushDigit() {
        presentTextInputControllerWithSuggestions(initialDigits, allowedInputMode: .Plain, completion: { (selectedDigit) -> Void in
            if let digit = selectedDigit[0] as? String {
                if self.isUserInTheMiddleOfTyping{
                    self.display = self.display + digit
                } else{
                    self.display = digit
                    self.isUserInTheMiddleOfTyping = true
                }
            }
            self.displayLabel.setText(self.display)
        })

    }
    
    func processEquals(){
        let infoDictionary = ["operand1": operand1, "operand2": display, "operation": operation]
        WKInterfaceController.openParentApplication(infoDictionary){
                (replyDictionary, error) -> Void in
            if let castedResponseDictionary = replyDictionary as? [String:Double],
                responseMessage = castedResponseDictionary["result"]{
                    self.displayLabel.setText("\(responseMessage)")
            }
            else{
                self.displayLabel.setText("\(error)")
            }
        }
    }
}
