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
    @IBOutlet weak var favorite: UIButton!
    
    var parentTableView: UITableView!
    
    var id: Int64!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addFavorite(_ sender: UIButton) {
        
        var result = CinePlayDB.instance.addFavorite(fmovie_id: self.id)
        favorite.isEnabled = false
        favorite.isHidden = true
        self.parentTableView.reloadData()


    }
}
