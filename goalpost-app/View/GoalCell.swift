//
//  GoalCell.swift
//  goalpost-app
//
//  Created by Anthony Cozzi on 7/12/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    //outlet
    
    @IBOutlet weak var goalDesc: UILabel!
    @IBOutlet weak var goalTerm: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    
    func configureCell(desc:String,type:String,progress:Int)
    {
        goalDesc.text = desc
        goalTerm.text = type
        goalProgressLbl.text = String(progress)
    }
}
