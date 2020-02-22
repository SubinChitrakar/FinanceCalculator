//
//  FirstViewController.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 22/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import UIKit

enum CalculationCases {
    case Empty
    case PrincipleAmount
    case InterestRate
    case TimePeriod
    case CompoundAmount
}

class CompoundSavingsViewController: UIViewController {

    @IBOutlet weak var TxtPrincipleAmount: UITextField!
    @IBOutlet weak var TxtInterestRate: UITextField!
    @IBOutlet weak var TxtTimePeriod: UITextField!
    @IBOutlet weak var TxtCompoundAmount: UITextField!
    
    var emptyField = CalculationCases.Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func CalculateValues(_ sender: UIButton) {
        var emptyFieldCounter = 0
        var result : Double = 0
        
        let principleAmount: Double! = Double(TxtPrincipleAmount.text!)
        if(principleAmount == nil){
            emptyField = CalculationCases.PrincipleAmount
            emptyFieldCounter += 1
        }
        
        let interestRate: Double! = Double(TxtInterestRate.text!)
        if(interestRate == nil)
        {
            emptyField = CalculationCases.InterestRate
            emptyFieldCounter += 1
        }
        
        let timePeriod: Double! = Double(TxtTimePeriod.text!)
        if(timePeriod == nil)
        {
            emptyField = CalculationCases.TimePeriod
            emptyFieldCounter += 1
        }
        
        let compoundSaving: Double! = Double(TxtCompoundAmount.text!)
        if(compoundSaving == nil)
        {
            emptyField = CalculationCases.CompoundAmount
            emptyFieldCounter += 1
        }
        
        if((emptyFieldCounter == 0 && emptyField == CalculationCases.Empty) || emptyFieldCounter > 1 ){
            emptyField = CalculationCases.Empty
            return
        }
        
        switch emptyField {
        
        case .CompoundAmount:
            result = CompoundSavings.GetCompoundSavingsAmount(principleAmount: principleAmount, interestRate: interestRate, timePeriod: timePeriod)
            TxtCompoundAmount.text = String(format: "%.2f", result)
        
        case .PrincipleAmount:
            result = CompoundSavings.GetPrincipleAmount(compoundSaving: compoundSaving, interestRate: interestRate, timePeriod: timePeriod)
            TxtPrincipleAmount.text = String(format: "%.2f", result)
            
        case .InterestRate:
            result = CompoundSavings.GetInterestRate(compoundSaving: compoundSaving, principleAmount: principleAmount, timePeriod: timePeriod)
            TxtInterestRate.text = String(format: "%.2f", result * 100)
            
        case .TimePeriod:
            result = CompoundSavings.GetTimePeriod(compoundInterest: compoundSaving, principleAmount: principleAmount, interestRate: interestRate)
            TxtTimePeriod.text = String(format: "%.2f", result)
            
        default:
            return
        }
    }
}

