//
//  MovieTableViewCell.swift
//  CinePlay
//
//  Created by wesley on 8/29/17.
//  Copyright © 2017 wesley. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var thumb: UIImageView!

    @IBOutlet weak var subtitle: UILabel!

    @IBOutlet weak var sinopse: UILabel!
    @IBOutlet weak var duration: UILabel!



    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
