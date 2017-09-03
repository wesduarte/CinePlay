//
//  FavoriteTableViewCell.swift
//  CinePlay
//
//  Created by wesley on 02/09/17.
//  Copyright © 2017 wesley. All rights reserved.
//

import UIKit
import SwiftyJSON

class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var sinopse: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    var parentViewController: FavoriteViewController!
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
        
        for (index, favorite) in self.parentViewController.favoriteMoviesArray.enumerated() {
            if favorite["id"].int64! == self.id {
                self.parentViewController.favoriteMoviesArray.remove(at: index)
                break
            }
        }
        self.parentTableView.reloadData()
        
    }
    
    
    
}
