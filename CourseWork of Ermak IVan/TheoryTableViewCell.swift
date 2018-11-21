//
//  TheoryTableViewCell.swift
//  CourseWork of Ermak IVan
//
//  Created by Ivan Ermak on 11/14/18.
//  Copyright © 2018 Ivan Ermak. All rights reserved.
//

import UIKit

class TheoryTableViewCell: UITableViewCell {

    @IBOutlet weak var valueCell: UITextView!
    @IBOutlet weak var definitionCell: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
