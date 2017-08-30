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
    
    var moviesArray = [[String:AnyObject]]()
    var titlesArray = [String]()
    var thumbsArray = [String]()
    
    func getJSON(){
        
        let URL = "https://my-json-server.typicode.com/wesleymuniz/mediaapi/db"
        
        /*Alamofire.request(URL).responseJSON { (Response) -> Void in
            
            // checking if result has value
            if let value = Response.result.value {
                
                let json = JSON(value)
                self.moviesArray = json.arrayValue as [AnyObject]
                
                debugPrint("test json")
                debugPrint(json)
                debugPrint("json value")
                debugPrint(json.arrayValue)
                debugPrint("movies array")
                debugPrint(self.moviesArray)
                let movies = self.moviesArray
                debugPrint("second movie")
                debugPrint(self.moviesArray[1])
                debugPrint(self.moviesArray[1]["title"].stringValue)

                
                
                
            }
            
        }*/
        
        Alamofire.request(URL).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["movies"].arrayObject {
                    self.moviesArray = resData as! [[String:AnyObject]]
                    debugPrint(self.moviesArray)
                    debugPrint(self.moviesArray[0])
                    let title = self.moviesArray[0]["title"]!
                    let thumb = self.moviesArray[0]["thumb"]!
                    debugPrint(title)
                    debugPrint(thumb)
                    debugPrint(self.moviesArray.count)
                    self.titlesArray.append(title as! String)
                    self.thumbsArray.append(thumb as! String)
                }
                if self.moviesArray.count > 0 {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    /*func downloadJsonWithURL() {
        let urlString = "https://my-json-server.typicode.com/wesleymuniz/mediaapi/db"
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                print(jsonObj!.value(forKey: "movies"))
                
                if let actorArray = jsonObj!.value(forKey: "movies") as? NSArray {
                    for actor in actorArray{
                        if let actorDict = actor as? NSDictionary {
                            if let title = actorDict.value(forKey: "title") {
                                print(title)
                                self.titlesArray.append(title as! String)
                            }
                            
                        }
                    }
                }
                
                OperationQueue.main.addOperation({
                    print(self.titlesArray.count)
                    print("updating")
                    self.tableView.reloadData()
                })
            }
        }).resume()
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getJSON()
        //self.downloadJsonWithURL()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moviesArray.count
    }
    
    /*func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        
        let title = self.titlesArray[indexPath.row]
        cell.title.text = title
        print("Teste")
        print(title)
        print(cell)
        
        let imgURL = NSURL(string: self.thumbsArray[indexPath.row])
        
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as? URL)!)
            cell.thumb.image = UIImage(data: data as! Data)
        }

        return cell
    }*/
    
    /*func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MovieTableViewCell
        
        let row = indexPath.row
        let movie_dict =  self.moviesArray[row]
        let title = movie_dict["title"]!
        debugPrint(title)
        cell?.title.text = "Funfou"
        
        
        return cell!
    }*/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        
        let row = indexPath.row
        let movie_dict =  self.moviesArray[row]
        let title = movie_dict["title"] as! String
        cell.title.text = title
        
        let subtitle = movie_dict["subtitle"] as! String
        cell.subtitle.text = subtitle
        
        let duration = String(format: "%@", movie_dict["duration"] as! CVarArg)
        cell.duration.text = duration
        
        let sinopse = movie_dict["sinopse"] as! String
        cell.sinopse.text = sinopse
        
        let thumb = movie_dict["thumb"] as! String
        let imgURL = NSURL(string: thumb)
        debugPrint(imgURL)
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as? URL)!)
            cell.thumb.image = UIImage(data: data as! Data)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        let movie_dict =  self.moviesArray[row]
        
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = Storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        
        let thumb = movie_dict["thumb"] as! String
        let imgURL = NSURL(string: thumb)
        debugPrint(imgURL)
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as? URL)!)
            vc.thumbImage = UIImage(data: data as! Data)
        }
        vc.titleString = movie_dict["title"] as! String
        vc.subtitleString = movie_dict["subtitle"] as! String
        vc.sinopseString = movie_dict["sinopse"] as! String
        
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
