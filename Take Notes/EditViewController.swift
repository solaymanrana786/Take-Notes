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
        
       
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        newtxt = textView.text
        self.ref?.child("Notes").child(self.key).setValue(self.newtxt)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
 

}
