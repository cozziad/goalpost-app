//
//  CreateGoalVC.swift
//  goalpost-app
//
//  Created by Anthony Cozzi on 7/12/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController, UITextViewDelegate {

    //outlets
    @IBOutlet weak var goalTxtView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var goalType: GoalType = .shortTerm
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalTxtView.delegate = self
        nextBtn.bindToKeyboard()
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func backBtnPressed(_ sender: Any) {dismissDetail()
        
    }
    @IBAction func nextBtnPressed(_ sender: Any) {
        if goalTxtView.text != ""{
        guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC else{return}
            
        finishGoalVC.initData(description: goalTxtView.text!, type: goalType)
        self.presentDetail(finishGoalVC)
        
        }
    }
    @IBAction func shortTermBtnPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }
    @IBAction func longTermBtnPressed(_ sender: Any) {
        goalType = .longTerm
        shortTermBtn.setDeselectedColor()
        longTermBtn.setSelectedColor()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTxtView.text = ""
        goalTxtView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    

}
