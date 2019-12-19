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
    
    var key = [String]()
    
    var text:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad()")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        // ref?.child("Notes").childByAutoId().setValue(text)
    }
    
    func fetchData() {
        ref = Database.database().reference()
             self.noteData.removeAll()
            databaseHandle = ref?.child("Notes").observe(.childAdded, with: { (snapshot) in
                //to execute when a child is added under notes
                //take the value from snapshot and put into notedata array
                let note = snapshot.value as? String
                let key = snapshot.key
                print("Key  : ",key)
                
                print("Added: \(note!)")
               
                if let actualNote = note {
                    self.noteData.insert(actualNote, at: 0)
                    self.key.append(key)
                    self.tableView.reloadData()
                }
            })
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
        let data = noteData[indexPath.row]
        let keyy = key[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        vc1.text = data
        vc1.key = keyy
        vc1.modalPresentationStyle = .fullScreen

        //vc1.modalPresentationStyle = .fullScreen
        self.present(vc1, animated: true)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear()")
        fetchData()
        
    }
//    override func viewWillDisappear(_ animated: Bool) {
//        print("viewWillDisappear()")
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        print("viewDidAppear()")
//    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
//            let alert = UIAlertController(title: "", message: "Edit item", preferredStyle: .alert)
//            alert.addTextField(configurationHandler: { (textField) in
//                textField.text = self.noteData[indexPath.row]
//            })
//            alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (updateAction) in
//                self.noteData[indexPath.row] = alert.textFields!.first!.text!
//
//                let txt = self.noteData[indexPath.row]
////                self.ref?.child("Notes").childByAutoId().setValue(txt)
//                let keyid = self.key[indexPath.row]
//                self.ref?.child("Notes").child(keyid).setValue(txt)
//                self.tableView.reloadRows(at: [indexPath], with: .fade)
//
//            }))
//            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//            self.present(alert, animated: false)
//        })
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            //self.noteData.remove(at: indexPath.row)
            let keyid = self.key[indexPath.row]
           
            self.ref?.child("Notes").child(keyid).removeValue()
            print("delete:",keyid)
            tableView.reloadData()
        })
        
        return [deleteAction]
    }
    
    
    
    @IBAction func createNew(_ sender: UIBarButtonItem) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
}
