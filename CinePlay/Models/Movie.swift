//
//  Movie.swift
//  CinePlay
//
//  Created by wesley on 8/29/17.
//  Copyright © 2017 wesley. All rights reserved.
//

import UIKit

class Movie {
    var title: String
    var subtitle: String
    var duration: Int
    var sinopse: String
    var thumb: UIImage
    
    init(title: String, subtitle: String, duration: Int, sinopse: String, thumb: UIImage) {
        self.title = title
        self.subtitle = subtitle
        self.duration = duration
        self.sinopse = sinopse
        self.thumb = thumb
    }
}
