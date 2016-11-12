//
//  TableViewCell.swift
//  Test157
//
//  Created by Andrey on 07.11.16.
//  Copyright © 2016 Kozhurin Andrey. All rights reserved.
//

import UIKit

class SegmentTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var segment: UISegmentedControl!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
