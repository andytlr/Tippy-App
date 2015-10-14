//
//  InterfaceController.swift
//  Tippy Watch Extension
//
//  Created by Andy Taylor on 10/12/15.
//  Copyright © 2015 Andy Taylor. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    var bill = "$"
    var percentDouble = 18.0
    var roundUpInIncrementsOf = 0.0
    
    @IBOutlet var valueLabel: WKInterfaceLabel!
    
    @IBOutlet var tipValueLabel: WKInterfaceLabel!
    
    @IBOutlet var totalValueLabel: WKInterfaceLabel!
    
    @IBOutlet var okButton: WKInterfaceButton!
    
    @IBOutlet var goodButton: WKInterfaceButton!
    
    @IBOutlet var greatButton: WKInterfaceButton!
    
    @IBOutlet var extraTitle: WKInterfaceLabel!
    
    @IBOutlet var extraPaidLabel: WKInterfaceLabel!
    
    @IBOutlet var roundedToLabel: WKInterfaceLabel!
    
    @IBOutlet var baseTitle: WKInterfaceLabel!
    
    @IBOutlet var basePercentLabel: WKInterfaceLabel!
    
    @IBOutlet var clearButton: WKInterfaceButton!
    
    // Function to format a double as money
    func formatMoney(cash: Double) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter.stringFromNumber(cash)!
    }
    
    func initView() {
        valueLabel.setText("Bill Amount")
        valueLabel.setTextColor(UIColor.init(white: 1.0, alpha: 0.5))
        tipValueLabel.setText("\(formatMoney(0.0))")
        totalValueLabel.setText("\(formatMoney(0.0))")
        extraPaidLabel.setText("\(formatMoney(0.0))")
        basePercentLabel.setTextColor(UIColor.init(white: 1.0, alpha: 0.5))
        extraPaidLabel.setTextColor(UIColor.init(white: 1.0, alpha: 0.5))
        extraTitle.setTextColor(UIColor.init(white: 1.0, alpha: 0.5))
        baseTitle.setTextColor(UIColor.init(white: 1.0, alpha: 0.5))
        roundedToLabel.setText("0%")
        clearButton.setBackgroundColor(UIColor.init(white: 1.0, alpha: 0.25))
    }
    
    // Round a double to one decimal place
    func roundToOneDecimalPlace(float: Double) -> Double {
        return round(float * 10) / 10
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        initView()
        tapGood()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func updateTotal() {
        let billDouble = Double(bill.stringByReplacingOccurrencesOfString("$", withString: ""))
        
        if bill == "$" {
            initView()
        } else {
            valueLabel.setTextColor(UIColor.init(white: 1.0, alpha: 1))
            let tip = (billDouble! / 100) * percentDouble
            let billTotal = billDouble! + tip
            
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
            
            let roundedBillTotal = (billTotal - (billTotal % roundUpInIncrementsOf)) + roundUpInIncrementsOf
            let roundedTipAmount = tip + (roundedBillTotal - billTotal)
            let roundedTipPercent = roundToOneDecimalPlace((roundedTipAmount / billDouble!) * 100)
            let extraPaid = roundedBillTotal - billTotal
            
            tipValueLabel.setText("\(formatMoney(roundedTipAmount))")
            totalValueLabel.setText("\(formatMoney(roundedBillTotal))")
            roundedToLabel.setText("\(roundedTipPercent)".stringByReplacingOccurrencesOfString(".0", withString: "") + "%")
            basePercentLabel.setText("\(percentDouble)".stringByReplacingOccurrencesOfString(".0", withString: "") + "%")
            extraPaidLabel.setText(formatMoney(extraPaid))
        }
    }
    
    @IBAction func seven() {
        bill = bill + "7"
        valueLabel.setText("\(bill)")
        updateTotal()
    }
    
    @IBAction func eight() {
        bill = bill + "8"
        valueLabel.setText("\(bill)")
        updateTotal()
    }
    
    @IBAction func nine() {
        bill = bill + "9"
        valueLabel.setText("\(bill)")
        updateTotal()
    }
    
    @IBAction func four() {
        bill = bill + "4"
        valueLabel.setText("\(bill)")
        updateTotal()
    }
    
    @IBAction func five() {
        bill = bill + "5"
        valueLabel.setText("\(bill)")
        updateTotal()
    }
    
    @IBAction func six() {
        bill = bill + "6"
        valueLabel.setText("\(bill)")
        updateTotal()
    }
    
    @IBAction func one() {
        bill = bill + "1"
        valueLabel.setText("\(bill)")
        updateTotal()
    }

    @IBAction func two() {
        bill = bill + "2"
        valueLabel.setText("\(bill)")
        updateTotal()
    }
    
    @IBAction func three() {
        bill = bill + "3"
        valueLabel.setText("\(bill)")
        updateTotal()
    }
    
    @IBAction func zero() {
        if bill != "$" {
            bill = bill + "0"
            valueLabel.setText("\(bill)")
            updateTotal()
        }
    }
    
    @IBAction func dot() {
        if bill != "$" && bill.containsString(".") == false {
            bill = bill + "."
            valueLabel.setText("\(bill)")
            updateTotal()
        }
    }
    
    @IBAction func clear() {
        bill = "$"
        valueLabel.setText("\(bill)")
        updateTotal()
    }
    
    @IBAction func tapOk() {
        okButton.setBackgroundColor(UIColor.init(white: 1.0, alpha: 0.25))
        goodButton.setBackgroundColor(UIColor.init(white: 1.0, alpha: 0.13))
        greatButton.setBackgroundColor(UIColor.init(white: 1.0, alpha: 0.13))
        
        percentDouble = 15.0
        basePercentLabel.setText("15%")
        
        updateTotal()
    }
    
    @IBAction func tapGood() {
        okButton.setBackgroundColor(UIColor.init(white: 1.0, alpha: 0.13))
        goodButton.setBackgroundColor(UIColor.init(white: 1.0, alpha: 0.25))
        greatButton.setBackgroundColor(UIColor.init(white: 1.0, alpha: 0.13))
        
        percentDouble = 18.0
        basePercentLabel.setText("18%")
        
        updateTotal()
    }
    
    @IBAction func tapGreat() {
        okButton.setBackgroundColor(UIColor.init(white: 1.0, alpha: 0.13))
        goodButton.setBackgroundColor(UIColor.init(white: 1.0, alpha: 0.13))
        greatButton.setBackgroundColor(UIColor.init(white: 1.0, alpha: 0.25))
        
        percentDouble = 20.0
        basePercentLabel.setText("20%")
        
        updateTotal()
    }

}
