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
        
        let leftFormulaTop = (futureAmount * (interestRate / 100 / 12)) + monthlyPaymentAmount
        let leftFormulaBottom = (principleAmount * (interestRate / 100 / 12 )) + monthlyPaymentAmount
        
        let leftFormula = log(leftFormulaTop/leftFormulaBottom)
        
        let rightForumla = 1 / (12 * log(1 + interestRate / 100 / 12))
        
        return leftFormula * rightForumla
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
    
    static func getTimePeriodForDepositAtBeginning(principleAmount : Double, interestRate : Double, monthlyPaymentAmount : Double, futureAmount : Double) -> Double{
        
        let topFormulaPartA = futureAmount + (monthlyPaymentAmount / (interestRate / 100 / 12)) + monthlyPaymentAmount
        let topFormulaPartB = principleAmount + (monthlyPaymentAmount / (interestRate / 100 / 12)) + monthlyPaymentAmount
        
        let topFormula = log(topFormulaPartA / topFormulaPartB)
        
        let bottomFormula = 12 * (log(1 + (interestRate / 100 / 12)))
        
        return topFormula / bottomFormula
    }
}
