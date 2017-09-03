//
//  ImageHandler.swift
//  CinePlay
//
//  Created by wesley on 03/09/17.
//  Copyright © 2017 wesley. All rights reserved.
//

import UIKit

class ImageHandler {
    
    static func convertURLToUIImage(url: String) -> UIImage! {
        let imgURL = NSURL(string: url)
        
        let data = NSData(contentsOf: (imgURL as? URL)!)
        return UIImage(data: data as! Data)!
    }
}
