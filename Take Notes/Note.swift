//
//  posts.swift
//  Take Notes
//
//  Created by Rana AITS on 12/22/19.
//  Copyright © 2019 Rana AITS. All rights reserved.
//

import Foundation

class Note {
    var text:String
    var timestamp:Double
    
    init(text:String,timestamp:Double) {
        self.text = text
        self.timestamp = timestamp
    }
}
