//
//  ViewController.swift
//  Class Roster 3
//
//  Created by Alex on 7/27/14.
//  Copyright (c) 2014 Alex Rice. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var twitterField: UITextField!
    @IBOutlet weak var githubField: UITextField!
    @IBOutlet weak var pictureButton: UIButton!
    
    var masterViewController : PeopleViewController?
    var selectedPerson : Person?
    var selectedPersonIndex : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let index = selectedPersonIndex {
            selectedPerson = masterViewController!.people[index]
            firstNameField.text = selectedPerson!.firstName
            lastNameField.text = selectedPerson!.lastName
            twitterField.text = selectedPerson!.twitterHandle
            githubField.text = selectedPerson!.githubHandle
            pictureButton.setImage(selectedPerson!.pic, forState: UIControlState.Normal)
        }
        
        firstNameField.delegate = self
        lastNameField.delegate = self
        twitterField.delegate = self
        githubField.delegate = self
        
        let myBorderColor = UIColor(red: 24.0/255, green: 68.0/255, blue: 96.0/255, alpha: 1.0)
        pictureButton.imageView.layer.borderColor = myBorderColor.CGColor
        pictureButton.imageView.layer.borderWidth = 3.0
        pictureButton.imageView.layer.cornerRadius = 40.0
        pictureButton.imageView.layer.masksToBounds = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        selectedPerson!.firstName = firstNameField.text
        selectedPerson!.lastName = lastNameField.text
        selectedPerson!.twitterHandle = twitterField.text
        selectedPerson!.githubHandle = githubField.text
        masterViewController!.peopleListTableView!.reloadData()
        // reloading here instead of in the listviewcontroller's willAppear method because I want to take another pass at porting this to a split view controller for the iPad at some point.
    }
    
    func textFieldDidBeginEditing(textField: UITextField!) {
        let newY = textField.frame.origin.y - 160
        
        UIView.animateWithDuration(0.3, animations: { () -> Void
            in
            self.view.bounds = CGRect(x: self.view.bounds.origin.x, y: newY, width: self.view.bounds.width, height: self.view.bounds.height)
        })
    }

    func textFieldDidEndEditing(textField: UITextField!) {
        UIView.animateWithDuration(0.3) {
            self.view.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width, height:self.view.bounds.height)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        self.view.endEditing(true)
    }
}
