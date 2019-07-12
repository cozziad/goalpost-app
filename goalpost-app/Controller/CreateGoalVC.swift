//
//  CreateGoalVC.swift
//  goalpost-app
//
//  Created by Anthony Cozzi on 7/12/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {

    //outlets
    @IBOutlet weak var goalTxtView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    @IBAction func nextBtnPressed(_ sender: Any) {
    }
    @IBAction func shortTermBtnPressed(_ sender: Any) {
    }
    @IBAction func longTermBtnPressed(_ sender: Any) {
    }
    

}
