//
//  NoteViewController.swift
//  Take Notes
//
//  Created by Rana AITS on 12/17/19.
//  Copyright © 2019 Rana AITS. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NoteViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var databaseHandle:DatabaseHandle?
    var ref:DatabaseReference?
    var noteData = [String]()
    
    
    
    var text:String = ""
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        ref = Database.database().reference()
          
        databaseHandle = ref?.child("Notes").observe(.childAdded, with: { (snapshot) in
            //to execute when a child is added under notes
            //take the value from snapshot and put into notedata array
            let note = snapshot.value as? String
            print("Added: \(note!)")
            if let actualNote = note {
            self.noteData.append(actualNote)
            self.tableView.reloadData()
            }
        })
        
       // ref?.child("Notes").childByAutoId().setValue(text)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteData.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        let note = noteData[indexPath.row]
        cell.titleLabel.text = note
        return cell
      }
    
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

     func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            let alert = UIAlertController(title: "", message: "Edit item", preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (textField) in
                textField.text = self.noteData[indexPath.row]
            })
            alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (updateAction) in
                self.noteData[indexPath.row] = alert.textFields!.first!.text!
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: false)
        })

        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            self.noteData.remove(at: indexPath.row)
            tableView.reloadData()
        })

        return [deleteAction, editAction]
    }

    
      func alertWithTF() {
          //Step : 1
          let alert = UIAlertController(title: "Notes", message: "create notes", preferredStyle: UIAlertController.Style.alert )
          //Step : 2
          let save = UIAlertAction(title: "Save", style: .default) { (alertAction) in
              let textField = alert.textFields![0] as UITextField
              if textField.text != "" {
                  //Read TextFields text data
                  self.text = textField.text!
                  self.ref?.child("Notes").childByAutoId().setValue(self.text)
                  print("TF  : \(textField.text!)")
              } else {
                  print("TF is Empty...")
              }
          }
          //Step : 3
          //For first TF
          alert.addTextField { (textField) in
              textField.placeholder = "Enter your notes here"
              textField.textColor = .red
          }
          //Step : 4
          alert.addAction(save)
          //Cancel action
          let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in }
          alert.addAction(cancel)
          //OR single line action
          //alert.addAction(UIAlertAction(title: "Cancel", style: .default) { (alertAction) in })

          self.present(alert, animated:true, completion: nil)

      }
    
    @IBAction func createNew(_ sender: UIBarButtonItem) {
           
           alertWithTF()
       }
}
