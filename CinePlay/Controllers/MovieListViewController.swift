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

    @IBOutlet weak var tableView: UITableView!
    
    var moviesArray = [JSON]()
    
    func loadMoviesFromAPI(){
        
        MoviesAPI.getMoviesJSON() { (success, result) in
            self.moviesArray = result!
            self.tableView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadMoviesFromAPI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //self.tableView.reloadData()
        return self.moviesArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        setValuesToMovieTableViewCell(cell: cell, movie_dict: self.moviesArray[indexPath.row])
        
        return cell
    }
    
    func setValuesToMovieTableViewCell(cell: MovieTableViewCell, movie_dict: JSON) {
        
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
        
        
        cell.parentTableView = self.tableView
        cell.id = movie_dict["id"].int64!
        
        if CinePlayDB.instance.getFavorite(fmovie_id: cell.id) != nil {
            cell.favorite.isEnabled = false
            cell.favorite.isHidden = true
        }
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
