//
//  FavoriteTableViewCell.swift
//  CinePlay
//
//  Created by wesley on 02/09/17.
//  Copyright © 2017 wesley. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var thumb: UIImageView!
    
    @IBOutlet weak var subtitle: UILabel!
    
    @IBOutlet weak var sinopse: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    var parentTableView: UITableView!
    
    var id: Int64!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
    @IBAction func deleteFavorite(_ sender: UIButton) {
        var delete = CinePlayDB.instance.deletefavorite(fmovie_id: self.id)
        self.parentTableView.reloadData()

    }
    
}
