//
//  UIButtonExt.swift
//  goalpost-app
//
//  Created by Anthony Cozzi on 7/12/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import UIKit

extension UIButton{
    
    func setSelectedColor(){
        self.backgroundColor = #colorLiteral(red: 0.4922357202, green: 0.7721707225, blue: 0.4591873884, alpha: 1)
    }
    
    func setDeselectedColor(){
        self.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    }
}
