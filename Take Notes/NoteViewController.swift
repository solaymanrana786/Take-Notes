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
            print(note!)
            if let actualNote = note {
            self.noteData.append(actualNote)
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

}
