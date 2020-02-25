//
//  SecondViewController.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 22/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import UIKit

class CompoundSavingsViewController: UIViewController {

    @IBOutlet weak var txtPrincipleAmount: UITextField!
    @IBOutlet weak var txtInterestRate: UITextField!
    @IBOutlet weak var txtTimePeriod: UITextField!
    @IBOutlet weak var txtMonthlyPaymentAmount: UITextField!
    @IBOutlet weak var txtFutureAmount: UITextField!
    
    @IBOutlet weak var switchPaymentAtBeginning: UISwitch!
    
    var emptyField = CalculationCases.empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func calculateValues(_ sender: UIButton) {
        var emptyFieldCounter = 0
        var result : Double = 0
        
        let principleAmount: Double! = Double(txtPrincipleAmount.text!)
        if principleAmount == nil {
            emptyField = CalculationCases.principleAmount
            emptyFieldCounter += 1
        }
        
        let timePeriod: Double! = Double(txtTimePeriod.text!)
        if timePeriod == nil {
            emptyField = CalculationCases.timePeriod
            emptyFieldCounter += 1
        }
        
        let monthlyPayment: Double! = Double(txtMonthlyPaymentAmount.text!)
        if monthlyPayment == nil{
            emptyField = CalculationCases.monthlyPaymentAmount
            emptyFieldCounter += 1
        }
        
        let futureAmount: Double! = Double(txtFutureAmount.text!)
        if futureAmount == nil{
            emptyField = CalculationCases.futureAmount
            emptyFieldCounter += 1
        }
        
        if (emptyFieldCounter == 0 && emptyField == CalculationCases.empty) || emptyFieldCounter > 1 {
            emptyField = CalculationCases.empty
            return
        }
        
        let interestRate: Double! = Double(txtInterestRate.text!)
        if interestRate == nil{
            return
        }
        
        switch emptyField {
            
        case .futureAmount:
            if switchPaymentAtBeginning.isOn {
                result = CompoundSaving.getFutureValueForDepositAtBeginning(principleAmount: principleAmount, interestRate: interestRate, timePeriod: timePeriod, monthlyPaymentAmount: monthlyPayment)
            }
            else{
                result = CompoundSaving.getFutureValueForDepositAtEnd(principleAmount: principleAmount, interestRate: interestRate, timePeriod: timePeriod, monthlyPaymentAmount: monthlyPayment)
            }
            
            txtFutureAmount.text = String(format: "%.2f", result)
        
        case .monthlyPaymentAmount:
            if switchPaymentAtBeginning.isOn {
                result = CompoundSaving.getMonthlyPaymentForDepositAtBeginning(principleAmount: principleAmount, interestRate: interestRate, timePeriod: timePeriod, futureAmount: futureAmount)
            }
            else{
                result = CompoundSaving.getMonthlyPaymentForDepositAtEnd(principleAmount: principleAmount, interestRate: interestRate, timePeriod: timePeriod, futureAmount: futureAmount)
            }
            
            txtMonthlyPaymentAmount.text = String(format: "%.2f", result)
            
        case .timePeriod:
            if switchPaymentAtBeginning.isOn {
                result = CompoundSaving.getTimePeriodForDepositAtBeginning(principleAmount: principleAmount, interestRate: interestRate, monthlyPaymentAmount: monthlyPayment, futureAmount: futureAmount)
            }
            else{
                result = CompoundSaving.getTimePeriodForDepositAtEnd(principleAmount: principleAmount, interestRate: interestRate, monthlyPaymentAmount: monthlyPayment, futureAmount: futureAmount)
            }
            
            txtTimePeriod.text = String(format: "%.2f", result)
            
        default:
            return
        }
        
    }
}

