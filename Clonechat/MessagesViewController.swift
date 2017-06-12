//
//  MessagesViewController.swift
//  Clonechat
//
//  Created by Susie Renjith on 6/10/17.
//  Copyright © 2017 Susie Renjith. All rights reserved.
//

import UIKit
import Firebase

class MessagesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var messages : [Message] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("messages").observe(DataEventType.childAdded, with: { (snapshot) in
            print(snapshot)
            
            let snapshotValue = snapshot.value as? [String: AnyObject?]
            let message = Message()
            
            message.imageURL = snapshotValue!["imageURL"] as! String
            message.from = snapshotValue!["from"] as! String
            message.desc = snapshotValue!["description"] as! String
            
            self.messages.append(message)
            
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let message = messages[indexPath.row]
        
        cell.textLabel?.text = message.from
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = messages[indexPath.row]
        
        performSegue(withIdentifier: "viewMessageSegue", sender: message)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewMessageSegue" {
            let nextVC = segue.destination as! ViewMessageViewController
            nextVC.message = sender as! Message
        }
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
