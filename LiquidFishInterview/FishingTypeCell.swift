//
//  FishingTypeCell.swift
//  LiquidFishInterview
//
//  Created by Garrett Votaw on 3/13/19.
//  Copyright © 2019 Garrett Votaw. All rights reserved.
//

import UIKit

class FishingTypeCell: UITableViewCell {

    @IBOutlet weak var fishName: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
