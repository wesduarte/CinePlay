//
//  MovieListViewController.swift
//  CinePlay
//
//  Created by wesley on 29/08/17.
//  Copyright © 2017 wesley. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MovieListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    final let API_URL = "https://my-json-server.typicode.com/wesleymuniz/mediaapi/db"

    @IBOutlet weak var tableView: UITableView!
    
    var moviesArray = [[String:AnyObject]]()
    
    func getMoviesJSON(){
        
        Alamofire.request(self.API_URL).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["movies"].arrayObject {
                    self.moviesArray = resData as! [[String:AnyObject]]
                }
                if self.moviesArray.count > 0 {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getMoviesJSON()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moviesArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        
        let row = indexPath.row
        let movie_dict =  self.moviesArray[row]
        let title = movie_dict["title"] as! String
        cell.title.text = title
        
        let subtitle = movie_dict["subtitle"] as! String
        cell.subtitle.text = subtitle
        
        let duration = String(format: "%@", movie_dict["duration"] as! CVarArg)
        cell.duration.text = "\(duration)min"
        
        let sinopse = movie_dict["sinopse"] as! String
        cell.sinopse.text = sinopse
        
        let thumb = movie_dict["thumb"] as! String
        let imgURL = NSURL(string: thumb)
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as? URL)!)
            cell.thumb.image = UIImage(data: data as! Data)
        }
        
        cell.id = movie_dict["id"] as! Int64
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentMovieCell = tableView.cellForRow(at: indexPath)! as! MovieTableViewCell
        
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let movieDetailView = Storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        
        movieDetailView.titleText = currentMovieCell.title?.text
        movieDetailView.subtitleText = currentMovieCell.subtitle?.text
        movieDetailView.sinopseText = currentMovieCell.sinopse?.text
        movieDetailView.thumbImage = currentMovieCell.thumb?.image
        
        
        self.navigationController?.pushViewController(movieDetailView, animated: true)
    }
    

}
