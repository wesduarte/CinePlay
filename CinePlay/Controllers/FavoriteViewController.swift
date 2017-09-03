//
//  FavoriteViewController.swift
//  CinePlay
//
//  Created by wesley on 30/08/17.
//  Copyright © 2017 wesley. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FavoriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var favoriteMoviesArray = [JSON]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
    }
    
    func loadMovies() {
        
        let favorites = CinePlayDB.instance.getFavorites();
        
        for favorite in favorites {
            MoviesAPI.getMovieJSON(id: favorite.movie_id) { (success, result) in
                self.favoriteMoviesArray.append(result!)
                self.tableView.reloadData()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoriteMoviesArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteTableViewCell
        
        setValuesToFavoriteTableViewCell(cell: cell, movie_dict: self.favoriteMoviesArray[indexPath.row])
                
        return cell
    }
    
    func setValuesToFavoriteTableViewCell(cell: FavoriteTableViewCell, movie_dict: JSON) {
        
        let title = movie_dict["title"].string!
        let subtitle = movie_dict["subtitle"].string!
        let duration = movie_dict["duration"].int!
        let sinopse = movie_dict["sinopse"].string!
        let thumb = movie_dict["thumb"].string!
        
        cell.title.text = title
        cell.subtitle.text = subtitle
        cell.duration.text = "\(duration)min"
        cell.sinopse.text = sinopse
        cell.thumb.image = ImageHandler.convertURLToUIImage(url: thumb)
        
        
        cell.parentViewController = self
        cell.parentTableView = self.tableView
        
        cell.id = movie_dict["id"].int64!
    }

}
