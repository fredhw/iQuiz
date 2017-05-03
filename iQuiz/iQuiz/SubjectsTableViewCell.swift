//
//  SubjectsTableViewCell.swift
//  iQuiz
//
//  Created by iGuest on 5/3/17.
//  Copyright © 2017 fredhw. All rights reserved.
//

import UIKit

class SubjectsTableViewCell: UITableViewCell {

    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
