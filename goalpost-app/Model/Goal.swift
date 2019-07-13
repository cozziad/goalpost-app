//
//  Goal.swift
//  goalpost-app
//
//  Created by Anthony Cozzi on 7/13/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import Foundation

struct modelGoal{
    public private (set) var description: String
    public private (set) var goalType: GoalType
    public private (set) var progess: Int32
    public private (set) var num: Int32
    
    mutating func updateGoal(uDescription: String,uGoalType: GoalType, uProgress: Int32, uNum:Int32){
        description = uDescription
        goalType = uGoalType
        progess = uProgress
        num = uNum
    }
}
