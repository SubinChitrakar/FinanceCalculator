//
//  KeyboardStatus.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 25/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import Foundation
import UIKit

/*
    Class to save properties for keyboard
 */
class KeyboardStatus
{
    //property to check whether the keyboard is open or not
    static var open  = false
    //property to save location of the keyboard
    static var defaultLocation: CGFloat = -1
    //property to save height of the keyboard
    static var keyBoardHeight: CGFloat = -1
}
