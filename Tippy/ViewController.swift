//
//  ViewController.swift
//  Tippy
//
//  Created by Andy Taylor on 10/8/15.
//  Copyright © 2015 Andy Taylor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billAmountInput: UITextField!
    
    @IBOutlet weak var tipPercentageSegmentedController: UISegmentedControl!
    
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    @IBOutlet weak var billTotalLabel: UILabel!
    
    @IBOutlet weak var percentageLabel: UILabel!
    
    @IBOutlet weak var roundSwitch: UISwitch!
    
    func formatMoney(cash: Double) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter.stringFromNumber(cash)!
    }
    
    func roundToOneDecimalPlace(float: Double) -> Double {
        return round(float * 10) / 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipAmountLabel.text = "$0.00"
        billTotalLabel.text = "$0.00"
        percentageLabel.text = "%%%%"
        
        billAmountInput.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func billAmountInputChanged(sender: AnyObject) {
        
        var tipAmounts = [15.0, 18.0, 20.0]
        
        let tipPercentage = tipAmounts[tipPercentageSegmentedController.selectedSegmentIndex]
        
        percentageLabel.text = "\(tipPercentage)"
        
        let bill = NSString(string: billAmountInput.text!).doubleValue
        let tip = (bill / 100) * tipPercentage
        let billTotal = bill + tip
        
        var roundUpInIncrementsOf = 0.0
        
        switch bill {
        case 1...5:
            roundUpInIncrementsOf = 0.50
        case 5...50:
            roundUpInIncrementsOf = 1.0
        case 50...100:
            roundUpInIncrementsOf = 5.0
        default:
            roundUpInIncrementsOf = 10.0
        }
        
        let roundedBillTotal = (billTotal - (billTotal % roundUpInIncrementsOf)) + roundUpInIncrementsOf
        let roundedTipAmount = tip + (roundedBillTotal - billTotal)
        let roundedTipPercent = roundToOneDecimalPlace((roundedTipAmount / bill) * 100)
        let extraPaid = roundedBillTotal - billTotal
        let tipPercentInt = Int(tipPercentage)
        
        let sentence = "Tip \(formatMoney(tip)). The total is \(formatMoney(billTotal)). You're tipping \(tipPercentInt)%"
        
        let roundedSentence = "Tip \(formatMoney(roundedTipAmount)). The total is \(formatMoney(roundedBillTotal)) You're tipping \(roundedTipPercent)% by chucking in an extra \(formatMoney(extraPaid))."
        
        print(sentence)
        print(roundedSentence)
        
        if roundSwitch.on {
            tipAmountLabel.text = "\(formatMoney(roundedTipAmount))"
            billTotalLabel.text = "\(formatMoney(roundedBillTotal))"
        } else {
            tipAmountLabel.text = "\(formatMoney(tip))"
            billTotalLabel.text = "\(formatMoney(billTotal))"
        }
    
    }

    @IBAction func tapBackground(sender: AnyObject) {
        view.endEditing(true)
    }
}

