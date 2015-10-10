
//
//  ViewController.swift
//  Tippy
//
//  Created by Andy Taylor on 10/8/15.
//  Copyright © 2015 Andy Taylor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipPercentageSegmentedController: UISegmentedControl!
    
    @IBOutlet weak var billAmountInput: UITextField!
    
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    @IBOutlet weak var billTotalLabel: UILabel!
    
    @IBOutlet weak var percentageLabel: UILabel!
    
    @IBOutlet weak var roundSwitch: UISwitch!
    
    @IBOutlet weak var resultsView: UIView!
    
    @IBOutlet weak var wholeResultsView: UIView!
    
    func formatMoney(cash: Double) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter.stringFromNumber(cash)!
    }
    
    func roundToOneDecimalPlace(float: Double) -> Double {
        return round(float * 10) / 10
    }
    
    let tipAmounts = [15.0, 18.0, 20.0]
//    var tippieAmounts = ["Ok": 15.0, "Good": 18.0, "Great": 20.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        billAmountInput.becomeFirstResponder()
        
        tipPercentageSegmentedController.setTitle("~\(Int(tipAmounts[0]))% Ok", forSegmentAtIndex: 0)
        tipPercentageSegmentedController.setTitle("~\(Int(tipAmounts[1]))% Good", forSegmentAtIndex: 1)
        tipPercentageSegmentedController.setTitle("~\(Int(tipAmounts[2]))% Great", forSegmentAtIndex: 2)
        
        wholeResultsView.alpha = 0
        tipPercentageSegmentedController.alpha = 0
        billAmountInput.transform = CGAffineTransformMakeTranslation(0, 80)
        wholeResultsView.transform = CGAffineTransformMakeTranslation(0, 80)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func billAmountInputChanged(sender: AnyObject) {
        
        let tipPercentage = tipAmounts[tipPercentageSegmentedController.selectedSegmentIndex]
        
        let billWithDollarStripped = billAmountInput.text!.stringByReplacingOccurrencesOfString("$", withString: "")
        
        let bill = NSString(string: billWithDollarStripped).doubleValue
        let tip = (bill / 100) * tipPercentage
        let billTotal = bill + tip
        
        var roundUpInIncrementsOf = 0.0
        
        switch bill {
        case 1...5:
            roundUpInIncrementsOf = 0.50
        case 5...50:
            roundUpInIncrementsOf = 1.0
        case 50...100:
            roundUpInIncrementsOf = 2.0
        case 100...300:
            roundUpInIncrementsOf = 5.0
        default:
            roundUpInIncrementsOf = 10.0
        }
        
        let roundedBillTotal = (billTotal - (billTotal % roundUpInIncrementsOf)) + roundUpInIncrementsOf
        let roundedTipAmount = tip + (roundedBillTotal - billTotal)
        let roundedTipPercent = roundToOneDecimalPlace((roundedTipAmount / bill) * 100)
        let roundedTipPercentStringified = String(round(roundedTipPercent)).stringByReplacingOccurrencesOfString(".0", withString: "")
        let extraPaid = roundedBillTotal - billTotal
        
        if roundSwitch.on {
            tipAmountLabel.text = "Tip: \(formatMoney(roundedTipAmount))"
            billTotalLabel.text = "Total: \(formatMoney(roundedBillTotal))"
            if billAmountInput.text != "" || bill == 0 {
                percentageLabel.hidden = false
                percentageLabel.text = "That's \(roundedTipPercentStringified)% and an extra \(formatMoney(extraPaid))."
            }
        } else {
            tipAmountLabel.text = "Tip: \(formatMoney(tip))"
            billTotalLabel.text = "Total: \(formatMoney(billTotal))"
            percentageLabel.hidden = true
        }
        
        if billAmountInput.text == "" || billAmountInput.text == "$" || billAmountInput.text == "$0" || billAmountInput.text == "$." {
            UIView.animateWithDuration(0.2, animations: {
                self.tipPercentageSegmentedController.alpha = 0
                self.wholeResultsView.alpha = 0
                self.billAmountInput.transform = CGAffineTransformMakeTranslation(0, 80)
                self.wholeResultsView.transform = CGAffineTransformMakeTranslation(0, 80)
            })
        } else {
            UIView.animateWithDuration(0.2, animations: {
                self.tipPercentageSegmentedController.alpha = 1
                self.wholeResultsView.alpha = 1
                self.billAmountInput.transform = CGAffineTransformMakeTranslation(0, 0)
                self.wholeResultsView.transform = CGAffineTransformMakeTranslation(0, 0)
            })
        }
        
        if billAmountInput.text == "" || billAmountInput.text == "$0" || billAmountInput.text == "$." {
            billAmountInput.text = "$"
        }
        
        if roundSwitch.on {
            tipPercentageSegmentedController.setTitle("~\(Int(tipAmounts[0]))% Ok", forSegmentAtIndex: 0)
            tipPercentageSegmentedController.setTitle("~\(Int(tipAmounts[1]))% Good", forSegmentAtIndex: 1)
            tipPercentageSegmentedController.setTitle("~\(Int(tipAmounts[2]))% Great", forSegmentAtIndex: 2)
        } else {
            tipPercentageSegmentedController.setTitle("\(Int(tipAmounts[0]))% Ok", forSegmentAtIndex: 0)
            tipPercentageSegmentedController.setTitle("\(Int(tipAmounts[1]))% Good", forSegmentAtIndex: 1)
            tipPercentageSegmentedController.setTitle("\(Int(tipAmounts[2]))% Great", forSegmentAtIndex: 2)
        }
    
    }

    @IBAction func tapBackground(sender: AnyObject) {
//        view.endEditing(true)
    }
}

