//
//  ViewController.swift
//  Take Notes
//
//  Created by Rana AITS on 12/17/19.
//  Copyright © 2019 Rana AITS. All rights reserved.
//

import UIKit
import FirebaseDatabase

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
//       save()
        add()
        
    }
        
    @IBAction func onBackButtonTapped(_ sender: UIBarButtonItem) {
        save()
    }

    func add(){
        let noteRef = Database.database().reference().child("notes").childByAutoId()
            
            let noteObject = [
                "text": inputTextView.text!,
                "timestamp": [".sv":"timestamp"]
                ] as [String : Any]
            
           noteRef.setValue(noteObject, withCompletionBlock: { error, ref in
                if error == nil {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    // Handle the error
                }
            })
        }
    }
    


