//
//  favorite.swift
//  CinePlay
//
//  Created by wesley on 8/31/17.
//  Copyright © 2017 wesley. All rights reserved.
//

import UIKit

class Favorite {
    var id: Int64?
    var movie_id: Int64
    
    init(movie_id: Int64) {
        self.movie_id = movie_id
        
    }
    
    init(id: Int64, movie_id: Int64) {
        self.id = id
        self.movie_id = movie_id

    }
}
