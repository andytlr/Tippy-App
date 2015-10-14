
//
//  ViewController.swift
//  Tippy
//
//  Created by Andy Taylor on 10/8/15.
//  Copyright © 2015 Andy Taylor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Variables for all the UI elements I need to change
    @IBOutlet weak var tipPercentageSegmentedController: UISegmentedControl!
    @IBOutlet weak var billAmountInput: UITextField!
    @IBOutlet weak var introLabel: UITextView!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var billTotalLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var resultsView: UIView!
    @IBOutlet weak var wholeResultsView: UIView!
    
    // Function to format a double as money
    func formatMoney(cash: Double) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter.stringFromNumber(cash)!
    }
    
    // Round a double to one decimal place
    func roundToOneDecimalPlace(float: Double) -> Double {
        return round(float * 10) / 10
    }
    
    // Set a NUX state
    var nuxShownTimes = 0
    var showNux = true
    
    // Tip amounts and labels
    let tipAmounts = [15.0, 18.0, 20.0]
    let tipLabels = ["Ok", "Good", "Great"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set light status bar
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        // Focus the bill amount input
        billAmountInput.becomeFirstResponder()
        
        // Set labels for segmented control
        var segIndex = 0
        while segIndex < tipAmounts.count {
            tipPercentageSegmentedController.setTitle("\(tipLabels[segIndex])", forSegmentAtIndex: segIndex)
            segIndex++
        }
        
        // Use tabular figures for results amounts
        tipAmountLabel.font = UIFont.monospacedDigitSystemFontOfSize(24, weight: UIFontWeightThin)
        billTotalLabel.font = UIFont.monospacedDigitSystemFontOfSize(24, weight: UIFontWeightThin)
        
        // Move and hide stuff
        billAmountInput.transform = CGAffineTransformMakeTranslation(0, 80)
        wholeResultsView.transform = CGAffineTransformMakeTranslation(0, 180)
        wholeResultsView.alpha = 0
        introLabel.transform = CGAffineTransformMakeTranslation(0, 290)

        // Animate in NUX after delay
        if showNux == true {
            introLabel.alpha = 1
        } else {
            introLabel.alpha = 0
        }
    }

    // ¯\_(ツ)_/¯ I didn't write this. Something about memory warnings.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Whenever the input changes. Do all the things.
    @IBAction func billAmountInputChanged(sender: AnyObject) {
        
        // Don't show the nux after 3 times (including the first).
        // Also won't be shown again if tapped.
        if nuxShownTimes >= 2 {
            showNux = false
        }
        
        // Set the tip percentage to use to the one selected in the segmented control
        let tipPercentage = tipAmounts[tipPercentageSegmentedController.selectedSegmentIndex]
        
        // Strip the dollar sign from the input text then get a double out of it
        let billWithDollarStripped = billAmountInput.text!.stringByReplacingOccurrencesOfString("$", withString: "")
        let bill = NSString(string: billWithDollarStripped).doubleValue
        
        // Calculate tip and total bill
        let tip = (bill / 100) * tipPercentage
        let billTotal = bill + tip
        
        // Initialize empty double
        var roundUpInIncrementsOf = 0.0
        
        // Set what increments to round up in depending on the total.
        switch billTotal {
        case 1...10:
            roundUpInIncrementsOf = 0.50
        case 10...250:
            roundUpInIncrementsOf = 1.0
        case 250...500:
            roundUpInIncrementsOf = 2.0
        default:
            roundUpInIncrementsOf = 5.0
        }
        
        // Get the final bill including rounding
        let roundedBillTotal = (billTotal - (billTotal % roundUpInIncrementsOf)) + roundUpInIncrementsOf
        
        // And the tip amount
        let roundedTipAmount = tip + (roundedBillTotal - billTotal)
        
        // And the percentage you'll actually pay. E.g. 19.3% instead of 18%
        let roundedTipPercent = roundToOneDecimalPlace((roundedTipAmount / bill) * 100)
        // Format it
        let roundedTipPercentStringified = String(roundedTipPercent).stringByReplacingOccurrencesOfString(".0", withString: "")
        
        // The original tip formatted nicely
        let tipPercentStringified = String(tipPercentage).stringByReplacingOccurrencesOfString(".0", withString: "")
        
        // How much extra you'll pay because of rounding
        let extraPaid = roundedBillTotal - billTotal
        
        // If the input is effectively empty
        if billAmountInput.text == "" || billAmountInput.text == "$" || billAmountInput.text == "$0" || billAmountInput.text == "$." {
            
            // Move the input bouncy style
            UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.3, options: [], animations: {
                self.billAmountInput.transform = CGAffineTransformMakeTranslation(0, 80)
            }, completion: nil)
            
            // Move the results view out of view
            UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.3, options: [], animations: {
                self.wholeResultsView.transform = CGAffineTransformMakeTranslation(0, 180)
                }, completion: nil)
            
            // Hide the results view.
            // Was strange seeing the results if you shook the phone and the keyboard dismisssed. Or behind the black transparent keyboard.
            UIView.animateWithDuration(0, delay: 0.2, options: [], animations: {
                self.wholeResultsView.alpha = 0
            }, completion: nil)
            
            // Show the NUX tip after a delay
            if showNux == true {
                UIView.animateWithDuration(0.3, delay: 0.5, options: [], animations: {
                    self.introLabel.alpha = 1
                    self.nuxShownTimes++
                }, completion: nil)
            }
            
        } else {
            
            // Bring the results view into view and move the input up.
            UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.3, options: [], animations: {
                self.billAmountInput.transform = CGAffineTransformMakeTranslation(0, 0)
                self.wholeResultsView.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: nil)
            
            // hide intro label
            self.introLabel.alpha = 0
            
            // Show results view
            wholeResultsView.alpha = 1
            
            // Set tip and bill amounts
            tipAmountLabel.text = "\(formatMoney(roundedTipAmount))"
            billTotalLabel.text = "\(formatMoney(roundedBillTotal))"
            
            // Was getting problems where the percentage was infinite when the input was empty so...
            if billAmountInput.text != "" || bill == 0 {
                
                // Don't think I need this...
                percentageLabel.hidden = false
                
                // Sentence that explains what's happening under results.
                percentageLabel.text = "Rounded to \(roundedTipPercentStringified)%, only \(formatMoney(extraPaid)) more than \(tipPercentStringified)%."
            }
        }
        
        // Make sure you can't type stupid shit in the input.
        // You can still do some stupid shit but I can't make it crash.
        // Probably need regex or something to limit the type of input the input will accept.
        if billAmountInput.text == "" || billAmountInput.text == "$0" || billAmountInput.text == "$." {
            billAmountInput.text = "$"
        }
    
    }
    
    @IBAction func tapIntroLabel(sender: AnyObject) {
        // Hide the intro label
        introLabel.alpha = 0
    }
    
    // Swipe down on the whole view...
    @IBAction func swipeView(sender: AnyObject) {
        
        // Reset the input. For some reason I need both of these.
        billAmountInput.text = "$"
        billAmountInputChanged(NSString(string: "$"))
    }
}

