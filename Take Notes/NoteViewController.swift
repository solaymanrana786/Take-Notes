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
    var notes = [Note]()
    
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
//                    self.noteData.append(actualNote)
//                    self.key.append(key)
                    self.noteData.insert(actualNote, at: 0)
                    self.key.insert(key, at: 0)
                    self.tableView.reloadData()
                }
            })
        
            
      
    }
    
    func observePosts() {
           let notesRef = Database.database().reference().child("notes")
           
           notesRef.observe(.value, with: { snapshot in
               
               var tempNotes = [Note]()
               for child in snapshot.children {
                   if let childSnapshot = child as? DataSnapshot,
                       let dict = childSnapshot.value as? [String:Any],
                       let text = dict["text"] as? String,
                       let timestamp = dict["timestamp"] as? Double {
                       
                       let note = Note( text: text, timestamp:timestamp)
                       tempNotes.append(note)
                   }
               }
               
               self.notes = tempNotes
               self.tableView.reloadData()
               
           })
       }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
        //return noteData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.set(note: notes[indexPath.row])
//        let note = noteData[indexPath.row]
//        cell.titleLabel.text = note
        return cell
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let note =  notes[indexPath.row]
        
        let data = noteData[indexPath.row]
        let keyy = key[indexPath.row]
        self.noteData.remove(at: indexPath.row)
        self.key.remove(at: indexPath.row)
        //self.ref?.child("notes").child(note).removeValue()


//        let temp = noteData[0]
//        noteData[0] = data
//        noteData[indexPath.row] = temp
//
//        let tempKey = key[0]
//        key[0] = keyy
//        key[indexPath.row] = tempKey
//
//
//         noteData.remove(at: indexPath.row)
//        noteData.insert(data, at: 0)
//         key.remove(at: indexPath.row)
//        key.insert(keyy, at: 0)
       // self.tableView.reloadData()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        vc1.text = data
        vc1.key = keyy
//        self.ref?.child("Notes").child(keyy).removeValue()
//        vc1.modalPresentationStyle = .fullScreen

        //vc1.modalPresentationStyle = .fullScreen
        self.present(vc1, animated: true)


    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear()")
//        fetchData()
        observePosts()
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            self.noteData.remove(at: indexPath.row)
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
