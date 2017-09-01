//
//  FavoriteViewController.swift
//  CinePlay
//
//  Created by wesley on 30/08/17.
//  Copyright © 2017 wesley. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var favoriteMoviesArray = [[String:AnyObject]]()

    override func viewDidLoad() {
        super.viewDidLoad()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        
        let row = indexPath.row
        let movie_dict =  self.favoriteMoviesArray[row]
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
