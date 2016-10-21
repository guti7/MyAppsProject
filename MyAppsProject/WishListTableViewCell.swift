//
//  WishListTableViewCell.swift
//  MyAppsProject
//
//  Created by Guti on 10/19/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit

class WishListTableViewCell: UITableViewCell {
    

    @IBOutlet weak var wishListNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
