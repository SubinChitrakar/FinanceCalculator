//
//  FirstViewController.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 22/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import UIKit


class CompoundSavingsViewController: UIViewController, KeyboardViewDelegate {

    @IBOutlet weak var txtPrincipleAmount: UITextField!
    @IBOutlet weak var txtInterestRate: UITextField!
    @IBOutlet weak var txtTimePeriod: UITextField!
    @IBOutlet weak var txtCompoundAmount: UITextField!
    
    @IBOutlet weak var viewCustomKeyboard: KeyboardViewController!
    
    var emptyField = CalculationCases.empty
    var currentTextField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewCustomKeyboard.keyboardDelegate = self
    }

    @IBAction func textfieldPressed(_ sender: UITextField) {
        currentTextField = sender
    }

    func keyboardPressed(buttonValue: Int) {
        
    }

    @IBAction func calculateValues(_ sender: UIButton) {
        var emptyFieldCounter = 0
        let result : Double
        
        let principleAmount: Double! = Double(txtPrincipleAmount.text!)
        if(principleAmount == nil){
            emptyField = CalculationCases.principleAmount
            emptyFieldCounter += 1
        }
        
        let interestRate: Double! = Double(txtInterestRate.text!)
        if(interestRate == nil)
        {
            emptyField = CalculationCases.interestRate
            emptyFieldCounter += 1
        }
        
        let timePeriod: Double! = Double(txtTimePeriod.text!)
        if(timePeriod == nil)
        {
            emptyField = CalculationCases.timePeriod
            emptyFieldCounter += 1
        }
        
        let compoundSaving: Double! = Double(txtCompoundAmount.text!)
        if(compoundSaving == nil)
        {
            emptyField = CalculationCases.futureAmount
            emptyFieldCounter += 1
        }
        
        if((emptyFieldCounter == 0 && emptyField == CalculationCases.empty) || emptyFieldCounter > 1 ){
            emptyField = CalculationCases.empty
            return
        }
        
        switch emptyField {
            
        case .futureAmount:
            result = CompoundSavings.getCompoundSavingsAmount(principleAmount: principleAmount, interestRate: interestRate, timePeriod: timePeriod)
            txtCompoundAmount.text = String(format: "%.2f", result)
        
        case .principleAmount:
            result = CompoundSavings.getPrincipleAmount(compoundSaving: compoundSaving, interestRate: interestRate, timePeriod: timePeriod)
            txtPrincipleAmount.text = String(format: "%.2f", result)
        
        case .interestRate:
            result = CompoundSavings.getInterestRate(compoundSaving: compoundSaving, principleAmount: principleAmount, timePeriod: timePeriod)
            txtInterestRate.text = String(format: "%.2f", result * 100)
        
        case .timePeriod:
            result = CompoundSavings.getTimePeriod(compoundInterest: compoundSaving, principleAmount: principleAmount, interestRate: interestRate)
            txtTimePeriod.text = String(format: "%.2f", result)
        
        default:
            return
            
        }
    }
}

