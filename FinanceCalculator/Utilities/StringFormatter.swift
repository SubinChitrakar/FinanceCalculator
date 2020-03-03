//
//  StringFormatter.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 03/03/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import Foundation
import UIKit

class StringFormatter{
    
    static func putSign(textField : UITextField, text : String)
    {
        switch textField.tag {
        case 1:
            textField.text = "£ " + text
        case 2:
            textField.text = "% " + text
        default:
            break;
        }
    }
    
}
