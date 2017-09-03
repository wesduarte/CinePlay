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
    
    final let MOVIES_URL = "https://my-json-server.typicode.com/wesleymuniz/mediaapi/db"
    final let MOVIE_URL = "https://my-json-server.typicode.com/wesleymuniz/mediaapi/movies/"
    
    var favoriteMoviesArray = [JSON]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getMoviesJSON()
    }
    
    func getMoviesJSON(){
        
        let favorites = CinePlayDB.instance.getFavorites();
        
        for favorite in favorites {
            let MOVIE_URL_ID = "\(self.MOVIE_URL)\(favorite.movie_id)"
            Alamofire.request(MOVIE_URL_ID).responseJSON { (responseData) -> Void in
                if((responseData.result.value) != nil) {
                    let resData = JSON(responseData.result.value!)
                    self.favoriteMoviesArray.append(resData)
                }

                if self.favoriteMoviesArray.count > 0 {
                    self.tableView.reloadData()
                }
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
        
        let row = indexPath.row
        let movie_dict =  self.favoriteMoviesArray[row]
        let title = movie_dict["title"].string!
        cell.title.text = title
        
        let subtitle = movie_dict["subtitle"].string!
        cell.subtitle.text = subtitle
        
        let duration = movie_dict["duration"].int!
        cell.duration.text = "\(duration)min"
        
        let sinopse = movie_dict["sinopse"].string!
        cell.sinopse.text = sinopse
        
        let thumb = movie_dict["thumb"].string!
        let imgURL = NSURL(string: thumb)
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as? URL)!)
            cell.thumb.image = UIImage(data: data as! Data)
        }
        
        cell.parentViewController = self
        cell.parentTableView = self.tableView
        
        cell.id = movie_dict["id"].int64!
                
        return cell
    }

}
