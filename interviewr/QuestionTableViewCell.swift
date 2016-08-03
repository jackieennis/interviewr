//
//  QuestionTableViewCell.swift
//  interviewr
//
//  Created by Jackie Ennis on 8/3/16.
//  Copyright © 2016 Jackie Ennis. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
