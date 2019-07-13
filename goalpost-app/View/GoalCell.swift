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
    
    func configureCell(goal: Goal)
    {
        goalDesc.text = goal.goalDesc
        goalTerm.text = goal.goalType
        goalProgressLbl.text = String(goal.goalProgress)
    }
}
