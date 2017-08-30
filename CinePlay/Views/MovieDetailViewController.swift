//
//  MovieDetailViewController.swift
//  CinePlay
//
//  Created by wesley on 30/08/17.
//  Copyright © 2017 wesley. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var sinopse: UILabel!
    
    var titleString:String!
    var thumbImage:UIImage!
    var subtitleString:String!
    var sinopseString:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTitle.text = titleString
        subtitle.text = subtitleString
        sinopse.text = sinopseString
        thumb.image = thumbImage

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
