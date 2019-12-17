//
//  CreateNoteViewController.swift
//  Take Notes
//
//  Created by Rana AITS on 12/17/19.
//  Copyright © 2019 Rana AITS. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CreateNoteViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var ref:DatabaseReference?
    var text:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        ref = Database.database().reference()
    }
   
    @IBAction func saveButtonTapped(_ sender: Any) {
         self.text = textView.text
        ref?.child("Notes").childByAutoId().setValue(text)
    }

}
