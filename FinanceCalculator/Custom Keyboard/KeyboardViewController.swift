//
//  KeyboardView.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 23/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import UIKit

class KeyboardViewController: UIView {

    @IBOutlet var keyboardView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        Bundle.main.loadNibNamed("KeyboardView", owner: self, options: nil)
        self.addSubview(keyboardView)
    }

    
    
}
