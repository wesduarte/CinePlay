//
//  MovieDetailViewController.swift
//  CinePlay
//
//  Created by wesley on 31/08/17.
//  Copyright © 2017 wesley. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var sinopseLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var thumbLabel: UIImageView!

    
    var titleText:String!
    
    var subtitleText:String!
    
    var sinopseText:String!
    
    var durationText:String!
    
    var thumbImage:UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUIContent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadUIContent() {
        self.titleLabel.text = self.titleText
        self.subtitleLabel.text = self.subtitleText
        self.sinopseLabel.text = self.sinopseText
        self.durationLabel.text = self.durationText
        self.thumbLabel.image = self.thumbImage
        
    }

}
