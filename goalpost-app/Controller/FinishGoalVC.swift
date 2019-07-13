//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by Anthony Cozzi on 7/12/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class FinishGoalVC: UIViewController,UITextFieldDelegate {

    //outlets
    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointsTxtField: UITextField!
    
    var goalDescription: String!
    var goalType: GoalType!
    
    func initData(description: String, type: GoalType){
        self.goalDescription = description
        self.goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
        pointsTxtField.delegate = self
    }
    
    func save(completion:(_ finished: Bool)-> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        let goal = Goal(context: managedContext)
        
        goal.goalDesc = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalNum = Int32(pointsTxtField.text!)!
        goal.goalProgress = Int32(0)
        
        do{try managedContext.save(); completion(true)}
        catch {debugPrint("Could Not Save: \(error.localizedDescription)"); completion(false)}
        
    }

    @IBAction func createGoalBtnPressed(_ sender: Any) {
        if pointsTxtField.text! == "" {return}
        self.save { (success) in
            if success{dismiss(animated: true, completion: nil)}
            else {print("not saved")}
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {dismissDetail()}
    
}
