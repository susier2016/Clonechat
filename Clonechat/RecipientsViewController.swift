//
//  RecipientsViewController.swift
//  Clonechat
//
//  Created by Susie Renjith on 6/10/17.
//  Copyright © 2017 Susie Renjith. All rights reserved.
//

import UIKit
import Firebase

class RecipientsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var users : [User] = []
    var imageURL = ""
    var desc = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        Database.database().reference().child("users").observe(DataEventType.childAdded, with: { (snapshot) in
            print(snapshot)
            
            let snapshotValue = snapshot.value as? [String: AnyObject?]
            let user = User()
            
            user.email = snapshotValue!["email"] as! String
            user.uid = snapshot.key
            
            self.users.append(user)
            
            self.tableView.reloadData()
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let message = ["from":user.email, "description":desc, "imageURL":imageURL]
        
        Database.database().reference().child("users").child(user.uid).child("messages").childByAutoId().setValue(message)
    }
    
}
