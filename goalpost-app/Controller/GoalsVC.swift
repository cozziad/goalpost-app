//
//  ViewController.swift
//  goalpost-app
//
//  Created by Anthony Cozzi on 7/12/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import UIKit
import CoreData

class GoalsVC: UIViewController {

    //outlets
    @IBOutlet weak var tableView: UITableView!
    var goals : [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetch { (success) in
            if success{
                if goals.count > 1{
                    tableView.isHidden = false
                }
            }else{tableView.isHidden = true}
        }
        tableView.reloadData()
    }

    @IBAction func addGoalPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "AddGoalVC")
            else {return}
        self.presentDetail(createGoalVC)
    }
    
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {return 1}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return goals.count}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell
            else {return UITableViewCell()}
        let goal = goals[indexPath.row]
        cell.configureCell(goal: goal)
        return cell
    }
}

extension GoalsVC {
    func fetch(completion: (_ complete:Bool)->()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {completion (false); return}
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        do{try goals = (managedContext.fetch(fetchRequest) as? [Goal])!; completion(true)}
        catch {debugPrint("Could Not Save: \(error.localizedDescription)"); completion(false)}
        
    }
}
