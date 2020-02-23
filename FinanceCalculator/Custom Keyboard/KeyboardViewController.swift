//
//  KeyboardView.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 23/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import UIKit

protocol KeyboardViewDelegate : class {
    func keyboardPressed(buttonValue : Int)
}

class KeyboardViewController: UIView {

    var keyboardDelegate : KeyboardViewDelegate?
    
    @IBOutlet var keyboardView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        Bundle.main.loadNibNamed("KeyboardView", owner: self, options: nil)
        self.addSubview(keyboardView)
    }

    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let buttonValue = sender.tag;
        self.keyboardDelegate?.keyboardPressed(buttonValue: buttonValue)
    }
    
}
