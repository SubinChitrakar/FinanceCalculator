//
//  MortagageAndLoans.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 22/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import Foundation

class MortgageAndLoans{
    
    static func getMonthlyPaymentAmount(principleAmount : Double, interestRate : Double, timePeriod : Double)->Double {
        
        var topFormula = pow((1 + (interestRate / 100 / 12 )), (12 * timePeriod))
        topFormula = (principleAmount * (interestRate / 100 / 12)) * topFormula
        
        let bottomFormula = (pow((1 + interestRate / 100 / 12),(12 * timePeriod))) - 1
        
        return topFormula/bottomFormula
    }
    
    static func getTimePeriod(principleAmount : Double, monthlyPaymentAmount : Double, interestRate : Double) -> Double {
        
        let topFormula = log((-12 * monthlyPaymentAmount) / ((principleAmount * interestRate / 100) - (12 * monthlyPaymentAmount)))
        let bottomFormula = 12 * log((interestRate / 100 + 12) / 12)
        
        return topFormula/bottomFormula
    }
    
    static func getPrincipleAmount(monthlyPaymentAmount : Double, interestRate : Double, timePeriod : Double) -> Double {
        
        var topFormula = pow((1 + interestRate / 100 / 12), 12 * timePeriod)
        topFormula = monthlyPaymentAmount * (topFormula - 1)
        
        var bottomFormula = pow((1 + interestRate / 100 / 12), 12 * timePeriod)
        bottomFormula = (interestRate / 100 / 12) * bottomFormula
        
        return topFormula / bottomFormula
    }
}
