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

    @IBOutlet var valueLabel: WKInterfaceLabel!
    
    @IBOutlet var serviceQualityLabel: WKInterfaceLabel!
    
    @IBOutlet var percentLabel: WKInterfaceLabel!
    
    @IBOutlet var okButton: WKInterfaceButton!
    
    @IBOutlet var goodButton: WKInterfaceButton!
    
    @IBOutlet var greatButton: WKInterfaceButton!
    
    var bill = "$"
    var percentDouble = 18.0
    
    @IBAction func seven() {
        bill = bill + "7"
        valueLabel.setText("\(bill)")
    }
    
    @IBAction func eight() {
        bill = bill + "8"
        valueLabel.setText("\(bill)")
    }
    
    @IBAction func nine() {
        bill = bill + "9"
        valueLabel.setText("\(bill)")
    }
    
    @IBAction func four() {
        bill = bill + "4"
        valueLabel.setText("\(bill)")
    }
    
    @IBAction func five() {
        bill = bill + "5"
        valueLabel.setText("\(bill)")
    }
    
    @IBAction func six() {
        bill = bill + "6"
        valueLabel.setText("\(bill)")
    }
    
    @IBAction func one() {
        bill = bill + "1"
        valueLabel.setText("\(bill)")
    }

    @IBAction func two() {
        bill = bill + "2"
        valueLabel.setText("\(bill)")
    }
    
    @IBAction func three() {
        bill = bill + "3"
        valueLabel.setText("\(bill)")
    }
    
    @IBAction func zero() {
        bill = bill + "0"
        valueLabel.setText("\(bill)")
    }
    
    @IBAction func dot() {
        bill = bill + "."
        valueLabel.setText("\(bill)")
    }
    
    @IBAction func clear() {
        bill = "$"
        valueLabel.setText("\(bill)")
    }
    
    @IBAction func tapOk() {
        percentDouble = 15.0
        serviceQualityLabel.setText("OK")
        percentLabel.setText("\(percentDouble)".stringByReplacingOccurrencesOfString(".0", withString: "") + "%")
        okButton.setBackgroundColor(UIColor.init(white: 1.0, alpha: 0.25))
        goodButton.setBackgroundColor(UIColor.init(white: 1.0, alpha: 0.13))
        greatButton.setBackgroundColor(UIColor.init(white: 1.0, alpha: 0.13))
    }
    
    @IBAction func tapGood() {
        percentDouble = 18.0
        serviceQualityLabel.setText("Good")
        percentLabel.setText("\(percentDouble)".stringByReplacingOccurrencesOfString(".0", withString: "") + "%")
        okButton.setBackgroundColor(UIColor.init(white: 1.0, alpha: 0.13))
        goodButton.setBackgroundColor(UIColor.init(white: 1.0, alpha: 0.25))
        greatButton.setBackgroundColor(UIColor.init(white: 1.0, alpha: 0.13))
    }
    
    @IBAction func tapGreat() {
        percentDouble = 20.0
        serviceQualityLabel.setText("Great")
        percentLabel.setText("\(percentDouble)".stringByReplacingOccurrencesOfString(".0", withString: "") + "%")
        okButton.setBackgroundColor(UIColor.init(white: 1.0, alpha: 0.13))
        goodButton.setBackgroundColor(UIColor.init(white: 1.0, alpha: 0.13))
        greatButton.setBackgroundColor(UIColor.init(white: 1.0, alpha: 0.25))
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
