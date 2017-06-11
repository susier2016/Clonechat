//
//  MessagesViewController.swift
//  Clonechat
//
//  Created by Susie Renjith on 6/10/17.
//  Copyright © 2017 Susie Renjith. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signOutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
