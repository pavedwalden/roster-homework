//
//  Person.swift
//  Roster Reloaded
//
//  Created by Alex on 7/24/14.
//  Copyright (c) 2014 Alex Rice. All rights reserved.
//

import UIKit

class Person {
    
    var firstName : String
    var lastName : String
    var twitterHandle : String
    var githubHandle : String
    var pic : UIImage
    
    init(fn: String, ln: String, twitter : String = "", github: String = ""){
        //for some reason the optional parameters aren't optional unless I give them an additional name
        self.firstName = fn
        self.lastName = ln
        self.twitterHandle = twitter
        self.githubHandle = github
        self.pic = UIImage(named: "person-icon.png")
    }
    
    func fullName() -> String {
        return self.firstName + " " + self.lastName
    }
    
    class func loadPeopleFromPlist() -> Array<Person> {
        var people = [Person]()
        let path = NSBundle.mainBundle().pathForResource("people", ofType: "plist")
        let peopleArray = NSArray(contentsOfFile: path)
        
        for person in peopleArray {
            if let thePerson = person as? Dictionary<String, String> {
                let firstName = thePerson["firstName"]
                let lastName = thePerson["lastName"]
                let newPerson = Person(fn: firstName!, ln: lastName!)
                if let picName = thePerson["pic"]{
                    newPerson.pic = UIImage(named: picName)
                }
                if let twitter = thePerson["twitter"] {
                    newPerson.twitterHandle = twitter
                }
                if let github = thePerson["github"] {
                    newPerson.githubHandle = github
                }
                
                people += newPerson
            }
        }
        return people
    }
   
}
