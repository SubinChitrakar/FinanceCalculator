//
//  File.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 22/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import Foundation

/*
    class for finding missing values for Simple Compound Savings
 */
class SimpleSaving{
    
    //method to get the future amount from principle amount, interest rate and time period
    static func getCompoundSavingsAmount(principleAmount:Double, interestRate: Double, timePeriod: Double) -> Double {
        
        var compoundSaving = 1 + (interestRate / 100 / 12)
        compoundSaving = pow(compoundSaving, 12 * timePeriod)
        compoundSaving = compoundSaving * principleAmount
        
        return compoundSaving
    }
    
    //method to get the principle amount from future amount, interest rate and time period
    static func getPrincipleAmount(compoundSaving: Double, interestRate: Double, timePeriod: Double) -> Double {
        var principleAmount = 1 + (interestRate / 100 / 12)
        principleAmount = pow(principleAmount, 12 * timePeriod)
        principleAmount = compoundSaving / principleAmount
        
        return principleAmount
    }
    
    //method to get the interest rate from future amount, principle amount and time period
    static func getInterestRate(compoundSaving: Double, principleAmount: Double, timePeriod: Double) -> Double {
        var interestRate = compoundSaving / principleAmount
        interestRate = pow(interestRate, ( 1 / ( 12 * timePeriod)))
        interestRate = (interestRate - 1) * 12
        
        return interestRate
    }
    
    //method to get the time period from the future amount, principle amount and interest rate
    static func getTimePeriod(compoundInterest: Double, principleAmount: Double, interestRate: Double) -> Double {
        let topFormula = log(compoundInterest / principleAmount)
        let bottomFormula = 12 * log(1 + (interestRate / 100 / 12))
        let timePeriod: Double = topFormula / bottomFormula
        
        return timePeriod
    }
    
}
