//
//  MortgageAndLoansViewController.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 22/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import UIKit

class MortgageViewController: UIViewController {

    @IBOutlet weak var txtPrincipleAmount: UITextField!
    @IBOutlet weak var txtInterestRate: UITextField!
    @IBOutlet weak var txtTimePeriod: UITextField!
    @IBOutlet weak var txtMonthlyPaymentAmount: UITextField!
    
    var emptyField = CalculationCases.empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func calculateValues(_ sender: UIButton) {
        var emptyFieldCounter = 0
        var result : Double = 0
        
        let principleAmount: Double! = Double(txtPrincipleAmount.text!)
        if(principleAmount == nil){
            emptyField = CalculationCases.principleAmount
            emptyFieldCounter += 1
        }
        
        let interestRate: Double! = Double(txtInterestRate.text!)
        if(interestRate == nil)
        {
            return
        }
        
        let timePeriod: Double! = Double(txtTimePeriod.text!)
        if(timePeriod == nil)
        {
            emptyField = CalculationCases.timePeriod
            emptyFieldCounter += 1
        }
        
        let monthlyPayment: Double! = Double(txtMonthlyPaymentAmount.text!)
        if(monthlyPayment == nil)
        {
            emptyField = CalculationCases.monthlyPaymentAmount
            emptyFieldCounter += 1
        }
        
        if((emptyFieldCounter == 0 && emptyField == CalculationCases.empty) || emptyFieldCounter > 1 ){
            emptyField = CalculationCases.empty
            return
        }
        
        
        switch emptyField {
            
        case .monthlyPaymentAmount:
            result = MortgageAndLoans.getMonthlyPaymentAmount(principleAmount: principleAmount, interestRate: interestRate, timePeriod: timePeriod)
            txtMonthlyPaymentAmount.text = String(format: "%.2f", result)
            
        case .timePeriod:
            result = MortgageAndLoans.getTimePeriod(principleAmount: principleAmount, monthlyPaymentAmount: monthlyPayment, interestRate: interestRate)
            txtTimePeriod.text = String(format: "%.2f", result)
            
        case .principleAmount:
            result = MortgageAndLoans.getPrincipleAmount(monthlyPaymentAmount: monthlyPayment, interestRate: interestRate, timePeriod: timePeriod)
            txtPrincipleAmount.text = String(format: "%.2f", result)
            
        default:
            return
            
        }
    }
}
