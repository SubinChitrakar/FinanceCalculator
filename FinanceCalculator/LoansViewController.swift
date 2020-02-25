//
//  LoansViewController.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 24/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import UIKit

class LoansViewController: UIViewController {

    @IBOutlet weak var txtPrincipleAmount: UITextField!
    @IBOutlet weak var txtInterestRate: UITextField!
    @IBOutlet weak var txtTimePeriod: UITextField!
    @IBOutlet weak var txtMonthlyPaymentAmount: UITextField!
    
    var emptyField = CalculationCases.empty
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(self.saveData), name: UIApplication.willResignActiveNotification, object: nil)
        txtPrincipleAmount.text = defaults.string(forKey: "PrincipleAmountLoans")
        txtInterestRate.text = defaults.string(forKey: "InterestRateLoans")
        txtTimePeriod.text = defaults.string(forKey: "TimePeriodLoans")
        txtMonthlyPaymentAmount.text = defaults.string(forKey: "MonthlyPaymentAmountLoans")
    }

    @objc func saveData(){
        defaults.set(self.txtPrincipleAmount.text, forKey: "PrincipleAmountLoans")
        defaults.set(self.txtInterestRate.text, forKey: "InterestRateLoans")
        defaults.set(self.txtTimePeriod.text, forKey: "TimePeriodLoans")
        defaults.set(self.txtMonthlyPaymentAmount.text, forKey: "MonthlyPaymentAmountLoans")
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        var emptyFieldCounter = 0
        var result : Double = 0
        
        let principleAmount: Double! = Double(txtPrincipleAmount.text!)
        if principleAmount == nil {
            emptyField = CalculationCases.principleAmount
            emptyFieldCounter += 1
        }
        
        let interestRate: Double! = Double(txtInterestRate.text!)
        if interestRate == nil {
            return
        }
        
        let timePeriod: Double! = Double(txtTimePeriod.text!)
        if timePeriod == nil {
            emptyField = CalculationCases.timePeriod
            emptyFieldCounter += 1
        }
        
        
        let monthlyPayment: Double! = Double(txtMonthlyPaymentAmount.text!)
        if monthlyPayment == nil {
            emptyField = CalculationCases.monthlyPaymentAmount
            emptyFieldCounter += 1
        }
        
        if (emptyFieldCounter == 0 && emptyField == CalculationCases.empty) || emptyFieldCounter > 1 {
            emptyField = CalculationCases.empty
            return
        }
        
        
        switch emptyField {
            
        case .monthlyPaymentAmount:
            result = MortgageAndLoans.getMonthlyPaymentAmount(principleAmount: principleAmount, interestRate: interestRate, timePeriod: timePeriod/12)
            txtMonthlyPaymentAmount.text = String(format: "%.2f", result)
            
        case .timePeriod:
            result = MortgageAndLoans.getTimePeriod(principleAmount: principleAmount, monthlyPaymentAmount: monthlyPayment, interestRate: interestRate)
            txtTimePeriod.text = String(format: "%.2f", result * 12)
            
        case .principleAmount:
            result = MortgageAndLoans.getPrincipleAmount(monthlyPaymentAmount: monthlyPayment, interestRate: interestRate, timePeriod: timePeriod/12)
            txtPrincipleAmount.text = String(format: "%.2f", result)
            
        default:
            return
            
        }
    }
    
}
