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
    @IBOutlet weak var undoView: UIView!
    var deletedGoal = modelGoal(description: "", goalType: .shortTerm, progess: 0, num: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        undoView.isHidden = true
    }
    
    func fetchCoreDataObjects(){
        self.fetch { (success) in
            if success{
                if goals.count >= 1{tableView.isHidden = false}
                else{tableView.isHidden = true}
            }
        }
        tableView.reloadData()
    }
    
    @IBAction func addGoalPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "AddGoalVC")
            else {return}
        self.presentDetail(createGoalVC)
    }
    @IBAction func undoPressed(_ sender: Any) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        let goal = Goal(context: managedContext)
        
        goal.goalDesc = deletedGoal.description
        goal.goalType = deletedGoal.goalType.rawValue
        goal.goalNum = deletedGoal.num
        goal.goalProgress = deletedGoal.progess
        
        do{try managedContext.save()}
        catch {debugPrint("Could not undo: \(error.localizedDescription)")}
        fetchCoreDataObjects()
        undoView.isHidden = true
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {return true}
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {return .none}
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style:.destructive , title: "Delete") { (rowAction, indexPath) in
            //tableView.deleteRows(at: [indexPath], with: .automatic)
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
        }
        
        let addAction = UITableViewRowAction(style: .normal, title: "Add One!") { (rowAction, indexPath) in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.4922357202, green: 0.7721707225, blue: 0.4591873884, alpha: 1)
        return [deleteAction,addAction]
    }
    
    func saveContext(context: NSManagedObjectContext)
    {
        do{try context.save()}
        catch {debugPrint("Could Not Save: \(error.localizedDescription)")}
    }
}

extension GoalsVC {
    func setProgress(atIndexPath indexPath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let chosenGoal = goals[indexPath.row]
        if chosenGoal.goalProgress < chosenGoal.goalNum {chosenGoal.goalProgress += 1}
        else {return}
        saveContext(context: managedContext)
    }
    
    func fetch(completion: (_ complete:Bool)->()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {completion (false); return}
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        do{try goals = (managedContext.fetch(fetchRequest) as? [Goal])!; completion(true)}
        catch {debugPrint("Could Not Save: \(error.localizedDescription)"); completion(false)}
    }
    
    func removeGoal(atIndexPath indexPath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        deletedGoal.updateGoal(uDescription: goals[indexPath.row].goalDesc!, uGoalType: GoalType(rawValue: goals[indexPath.row].goalType!)!, uProgress: goals[indexPath.row].goalProgress, uNum: goals[indexPath.row].goalNum)
        
        managedContext.delete(goals[indexPath.row])
        saveContext(context: managedContext)
        
        undoView.isHidden = false
    }
}
