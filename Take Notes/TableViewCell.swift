//
//  TableViewCell.swift
//  Take Notes
//
//  Created by Rana AITS on 12/18/19.
//  Copyright © 2019 Rana AITS. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func convertTimestamp(serverTimestamp: Double) -> String {
        let x = serverTimestamp / 1000
        let date = NSDate(timeIntervalSince1970: x)
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
       

        return formatter.string(from: date as Date)
    }
    
    func set(note:Note) {
        titleLabel.text = note.text
        dateLabel.text = convertTimestamp(serverTimestamp: note.timestamp)
        
        
        print( convertTimestamp(serverTimestamp: note.timestamp))
        }
        
       

}
