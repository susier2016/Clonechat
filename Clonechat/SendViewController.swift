//
//  SendViewController.swift
//  Clonechat
//
//  Created by Susie Renjith on 6/10/17.
//  Copyright © 2017 Susie Renjith. All rights reserved.
//

import UIKit
import Firebase

class SendViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
    }

    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        nextButton.isEnabled = false
        
        let imagesFolder = Storage.storage().reference().child("images")
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)! 
        
        imagesFolder.child("\(NSUUID().uuidString).jpg").putData(imageData, metadata: nil) { (metadata, error) in
            print("We tried to upload...")
            if error != nil {
                print("We had an error:\(String(describing: error))")
            } else {
                print(metadata?.downloadURL() as Any)
                self.performSegue(withIdentifier: "recipientSegue", sender: metadata?.downloadURL()!.absoluteString)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! RecipientsViewController
        nextVC.imageURL = sender as! String
        nextVC.desc = captionTextField.text!
    }

}
