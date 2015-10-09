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
    
    @IBOutlet weak var extraTitle: UILabel!
    
    @IBOutlet weak var extraLabel: UILabel!
    
    @IBOutlet weak var roundSwitch: UISwitch!
    
    @IBOutlet weak var resultsView: UIView!
    
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
        percentageLabel.text = "18%"
        extraLabel.text = "$0.00"
        
        billAmountInput.becomeFirstResponder()
        
        if billAmountInput.text == "" {
            resultsView.hidden = true
        } else {
            resultsView.hidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func billAmountInputChanged(sender: AnyObject) {
        
        var tipAmounts = [15.0, 18.0, 20.0]
        
        let tipPercentage = tipAmounts[tipPercentageSegmentedController.selectedSegmentIndex]
        
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
        
        if roundSwitch.on {
            tipAmountLabel.text = "Tip: \(formatMoney(roundedTipAmount))"
            billTotalLabel.text = "Total: \(formatMoney(roundedBillTotal))"
            percentageLabel.text = "That's \(roundedTipPercent)"
            extraLabel.text = "An extra \(formatMoney(extraPaid))"
            extraLabel.hidden = false
        } else {
            tipAmountLabel.text = "Tip: \(formatMoney(tip))"
            billTotalLabel.text = "Total: \(formatMoney(billTotal))"
            percentageLabel.text = "That's \(tipPercentage)"
            extraLabel.hidden = true
        }
        
        if billAmountInput.text == "" {
            resultsView.hidden = true
        } else {
            resultsView.hidden = false
        }
    
    }

    @IBAction func tapBackground(sender: AnyObject) {
        view.endEditing(true)
    }
}

