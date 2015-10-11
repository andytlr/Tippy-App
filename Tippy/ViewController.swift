
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
    
    @IBOutlet weak var introLabel: UITextView!
    
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    @IBOutlet weak var billTotalLabel: UILabel!
    
    @IBOutlet weak var percentageLabel: UILabel!
    
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
        
        tipPercentageSegmentedController.setTitle(">\(Int(tipAmounts[0]))% Ok", forSegmentAtIndex: 0)
        tipPercentageSegmentedController.setTitle(">\(Int(tipAmounts[1]))% Good", forSegmentAtIndex: 1)
        tipPercentageSegmentedController.setTitle(">\(Int(tipAmounts[2]))% Great", forSegmentAtIndex: 2)
        
        tipAmountLabel.font = UIFont.monospacedDigitSystemFontOfSize(24, weight: UIFontWeightLight)
        billTotalLabel.font = UIFont.monospacedDigitSystemFontOfSize(24, weight: UIFontWeightLight)
        
        billAmountInput.transform = CGAffineTransformMakeTranslation(0, 80)
        wholeResultsView.transform = CGAffineTransformMakeTranslation(0, 180)
        wholeResultsView.alpha = 0
        
        introLabel.alpha = 0
        introLabel.transform = CGAffineTransformMakeTranslation(0, 290)

        UIView.animateWithDuration(0.15, delay: 5.0, options: [], animations: {
            self.introLabel.alpha = 1
        }, completion: nil)
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
        
        switch billTotal {
        case 1...10:
            roundUpInIncrementsOf = 0.50
        case 10...50:
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
        let roundedTipPercentStringified = String(roundedTipPercent).stringByReplacingOccurrencesOfString(".0", withString: "")
        let tipPercentStringified = String(tipPercentage).stringByReplacingOccurrencesOfString(".0", withString: "")
        let extraPaid = roundedBillTotal - billTotal
        
        if billAmountInput.text == "" || billAmountInput.text == "$" || billAmountInput.text == "$0" || billAmountInput.text == "$." {
            UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.3, options: [], animations: {
                self.billAmountInput.transform = CGAffineTransformMakeTranslation(0, 80)
            }, completion: nil)
            UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.3, options: [], animations: {
                self.wholeResultsView.transform = CGAffineTransformMakeTranslation(0, 180)
                }, completion: nil)
            UIView.animateWithDuration(0.15, delay: 5.0, options: [], animations: {
                self.introLabel.alpha = 1
            }, completion: nil)
            UIView.animateWithDuration(0, delay: 0.2, options: [], animations: {
                self.wholeResultsView.alpha = 0
            }, completion: nil)
        } else {
            UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.3, options: [], animations: {
                self.billAmountInput.transform = CGAffineTransformMakeTranslation(0, 0)
                self.wholeResultsView.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: nil)
            self.introLabel.alpha = 0
            wholeResultsView.alpha = 1
            tipAmountLabel.text = "\(formatMoney(roundedTipAmount))"
            billTotalLabel.text = "\(formatMoney(roundedBillTotal))"
            if billAmountInput.text != "" || bill == 0 {
                percentageLabel.hidden = false
                percentageLabel.text = "That's \(roundedTipPercentStringified)%, only \(formatMoney(extraPaid)) extra than \(tipPercentStringified)%."
            }
        }
        
        if billAmountInput.text == "" || billAmountInput.text == "$0" || billAmountInput.text == "$." {
            billAmountInput.text = "$"
        }
    
    }
    
    @IBAction func swipeView(sender: AnyObject) {
        billAmountInput.text = "$"
        billAmountInputChanged(NSString(string: "$"))
    }

    @IBAction func tapBackground(sender: AnyObject) {
//        view.endEditing(true)
    }
}

