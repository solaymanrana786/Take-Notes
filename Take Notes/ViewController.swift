//
//  ViewController.swift
//  Take Notes
//
//  Created by Rana AITS on 12/17/19.
//  Copyright © 2019 Rana AITS. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAnalytics


class ViewController: UIViewController {

    @IBOutlet weak var inputTextView: UITextView!
    var ref:DatabaseReference?
    var text:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
      
    }
    func save(){
        if inputTextView.text != ""{
               //Read TextFields text data
               self.text = inputTextView.text
               self.ref?.child("Notes").childByAutoId().setValue(self.text)
                   
               } else {
                   print("TV is Empty...")
               }
        
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func onSaveButtonTapped(_ sender: UIBarButtonItem) {
        Analytics.logEvent("Save Button Pressed", parameters: nil)
       save()
    }
        
    @IBAction func onBackButtonTapped(_ sender: UIBarButtonItem) {
        Analytics.logEvent("Back Button Pressed", parameters: nil)
        save()
    }

}

