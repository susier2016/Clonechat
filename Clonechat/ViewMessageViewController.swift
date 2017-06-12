//
//  ViewMessageViewController.swift
//  Clonechat
//
//  Created by Susie Renjith on 6/11/17.
//  Copyright © 2017 Susie Renjith. All rights reserved.
//

import UIKit

class ViewMessageViewController: UIViewController {

    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var message = Message()

    override func viewDidLoad() {
        super.viewDidLoad()

        caption.text = message.desc
    }

}
