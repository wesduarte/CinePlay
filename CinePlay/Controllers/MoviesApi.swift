//
//  MoviesApi.swift
//  CinePlay
//
//  Created by wesley on 02/09/17.
//  Copyright © 2017 wesley. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MoviesAPI {
    
    static let MOVIES_URL = "https://my-json-server.typicode.com/wesleymuniz/mediaapi/db"
    static let MOVIE_URL = "https://my-json-server.typicode.com/wesleymuniz/mediaapi/movies/"
    
    static func getMoviesJSON(completion:((_ success: Bool, _ result: [JSON]?)->Void)?) {
        
        var moviesArray = [JSON]()
    
        Alamofire.request(MoviesAPI.MOVIES_URL).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                moviesArray = swiftyJsonVar["movies"].arrayValue
                completion?(responseData.result.isSuccess, moviesArray)
            }
        }
    }
    
    static func getMovieJSON(id: Int64, completion:((_ success: Bool, _ result: JSON?)->Void)?) {
        let MOVIE_URL_ID = "\(MoviesAPI.MOVIE_URL)\(id)"
        Alamofire.request(MOVIE_URL_ID).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let movie = JSON(responseData.result.value!)
                completion?(responseData.result.isSuccess, movie)
            }
        }
    }
    
    
}
