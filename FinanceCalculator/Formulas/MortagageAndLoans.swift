//
//  MortagageAndLoans.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 22/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import Foundation

/*
    class for finding missing values for Mortgage or Loans
 */
class MortgageAndLoans{
    
    //method to get the monthly payment amount of mortage/loan from principle amount, interest rate and time period
    static func getMonthlyPaymentAmount(principleAmount : Double, interestRate : Double, timePeriod : Double)->Double {
        
        var topFormula = pow((1 + (interestRate / 100 / 12 )), (12 * timePeriod))
        topFormula = (principleAmount * (interestRate / 100 / 12)) * topFormula
        
        let bottomFormula = (pow((1 + interestRate / 100 / 12),(12 * timePeriod))) - 1
        
        return topFormula/bottomFormula
    }
    
    //method to calculate the time period of the loan/mortgage from principle amount, monthly payment and interest rate
    static func getTimePeriod(principleAmount : Double, monthlyPaymentAmount : Double, interestRate : Double) -> Double {
        
        let topFormula = log((-12 * monthlyPaymentAmount) / ((principleAmount * interestRate / 100) - (12 * monthlyPaymentAmount)))
        
        let bottomFormula = 12 * log((interestRate / 100 + 12) / 12)
        
        return topFormula/bottomFormula
    }
    
    //method to calculate the principle amount of the loan/mortgage from montly payment, interest rate and time period
    static func getPrincipleAmount(monthlyPaymentAmount : Double, interestRate : Double, timePeriod : Double) -> Double {
        
        var topFormula = pow((1 + interestRate / 100 / 12), 12 * timePeriod)
        topFormula = monthlyPaymentAmount * (topFormula - 1)
        
        var bottomFormula = pow((1 + interestRate / 100 / 12), 12 * timePeriod)
        bottomFormula = (interestRate / 100 / 12) * bottomFormula
        
        return topFormula / bottomFormula
    }
}
