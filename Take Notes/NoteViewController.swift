//
//  NoteViewController.swift
//  Take Notes
//
//  Created by Rana AITS on 12/17/19.
//  Copyright © 2019 Rana AITS. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 10
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        return cell
      }

}
