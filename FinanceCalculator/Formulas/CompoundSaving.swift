//
//  CompoundInterest.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 24/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import Foundation

class CompoundSaving{
    static func getFutureValueForDepositAtEnd(principleAmount : Double, interestRate : Double, timePeriod : Double, monthlyPaymentAmount : Double) -> Double {
        
        let compoundInterestForPrinciple = principleAmount * pow((1 + interestRate / 100 / 12), 12 * timePeriod)
        
        let topFormula = (pow((1 + interestRate / 100 / 12), 12 * timePeriod)) - 1
        let bottomFormula = interestRate / 100 / 12
        
        let futureAmount = monthlyPaymentAmount * (topFormula / bottomFormula)
        
        return futureAmount + compoundInterestForPrinciple
    }
 
    static func getMonthlyPaymentForDepositAtEnd(principleAmount : Double, interestRate : Double, timePeriod : Double, futureAmount : Double) -> Double{
        
        let compoundInterestForPrinciple = principleAmount * pow((1 + interestRate / 100 / 12), 12 * timePeriod)
        
        let topFormula = (pow((1 + interestRate / 100 / 12), 12 * timePeriod)) - 1
        let bottomFormula = interestRate / 100 / 12
        
        return (futureAmount - compoundInterestForPrinciple) / (topFormula / bottomFormula)
    }
    
    static func getTimePeriodForDepositAtEnd(principleAmount : Double, interestRate : Double, monthlyPaymentAmount : Double, futureAmount : Double) -> Double{
        
        let topFormulaPart1 = (futureAmount * interestRate / 100) + (12 * monthlyPaymentAmount)
        let topFormuulaPart2 = 12 * monthlyPaymentAmount
        let topFormula = log(topFormulaPart1/topFormuulaPart2)
        
        let bottomFormula = 12 * log( (interestRate / 100 + 12) / 12 )
        
        return topFormula / bottomFormula
    }
    
    static func getFutureValueForDepositAtBeginning(principleAmount : Double, interestRate : Double, timePeriod : Double, monthlyPaymentAmount : Double) -> Double {
        
        let compoundInterestForPrinciple = principleAmount * pow((1 + interestRate / 100 / 12), 12 * timePeriod)
        
        let topFormula = (pow((1 + interestRate / 100 / 12), 12 * timePeriod)) - 1
        let bottomFormula = interestRate / 100 / 12
        let series = (1 + interestRate / 100 / 12)
        
        let futureAmount = monthlyPaymentAmount * (topFormula / bottomFormula) * series
        
        return futureAmount + compoundInterestForPrinciple
    }
    
    static func getMonthlyPaymentForDepositAtBeginning(principleAmount : Double, interestRate : Double, timePeriod : Double, futureAmount : Double) -> Double{
        
        let compoundInterestForPrinciple = principleAmount * pow((1 + interestRate / 100 / 12), 12 * timePeriod)
        
        let topFormula = (pow((1 + interestRate / 100 / 12), 12 * timePeriod)) - 1
        let bottomFormula = interestRate / 100 / 12
        let series = (1 + interestRate / 100 / 12)
        
        return (futureAmount - compoundInterestForPrinciple) / ((topFormula / bottomFormula) * series)
    }
    
}
