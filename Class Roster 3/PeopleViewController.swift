//
//  ViewController.swift
//  Class Roster 3
//
//  Created by Alex on 7/26/14.
//  Copyright (c) 2014 Alex Rice. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var peopleListTableView: UITableView!
    
    var people = [Person]()
    
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        people = Person.loadPeopleFromPlist()
        peopleListTableView.dataSource = self
        peopleListTableView.delegate = self
        let plusButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addPerson")
        self.navigationItem.rightBarButtonItem = plusButton
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        var detailView = self.storyboard.instantiateViewControllerWithIdentifier("personDetailController") as PersonViewController
        detailView.selectedPersonIndex = indexPath.row
        detailView.masterViewController = self
        navigationController.pushViewController(detailView, animated: true)
    }
    
    func addPerson(){
        var editView = self.storyboard.instantiateViewControllerWithIdentifier("personDetailController") as PersonViewController
        editView.masterViewController = self
        editView.selectedPersonIndex = people.count //current length should equal index of person we're about to add
        people.append(Person(fn:"", ln:""))
        navigationController.pushViewController(editView, animated: true)
    }
    
    //UITableViewDataSource Protocol

    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("personCell") as UITableViewCell
        
        cell.textLabel.text = people[indexPath.row].fullName()
        return cell
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.people.count
    }
    

}

