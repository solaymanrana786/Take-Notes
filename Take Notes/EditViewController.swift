//
//  EditViewController.swift
//  Take Notes
//
//  Created by Rana AITS on 12/19/19.
//  Copyright © 2019 Rana AITS. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EditViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var ref:DatabaseReference?
    var text:String = ""
    var key:String = ""
    
    var newtxt: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        textView.text = text
        self.ref?.child("Notes").child(key).removeValue()
    }
    
    
    func onEdit(){
        newtxt = textView.text
        if newtxt != "" {
        //Read TextFields text data
        let updateTxt = newtxt
        self.ref?.child("Notes").childByAutoId().setValue(updateTxt)
            
        } else {
            print("edit is Empty...")
        }
          self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
            onEdit()
        
//        newtxt = textView.text
//         self.ref?.child("Notes").childByAutoId().setValue(self.text)
//        //self.ref?.child("Notes").child(self.key).setValue(self.newtxt)
//       // self.ref?.child("Notes").updateChildValues()
//        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
            onEdit()
//        newtxt = textView.text
//         self.ref?.child("Notes").childByAutoId().setValue(self.text)
//        self.ref?.child("Notes").child(self.key).setValue(self.newtxt)
       // self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
 
}
