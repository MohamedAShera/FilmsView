//
//  descriptionVC.swift
//  FilmsView
//
//  Created by apple on 4/17/19.
//  Copyright © 2019 mohamed. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class descriptionVC: UIViewController {
    var mvtitle : String?
    var photo : String?
    var overview : String?
    var rate: String?
    var photoBasUrl = "https://image.tmdb.org/t/p/w500/"
    
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var imageFilmDes: UIImageView!
    @IBOutlet weak var filmNameDes: UILabel!
    @IBOutlet weak var descriptionFilmDes: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filmNameDes.text = mvtitle!
        self.imageFilmDes.kf.setImage(with:URL(string: photo!))
        self.descriptionFilmDes.text = overview!
        self.rateLbl.text = rate ?? "nil"
        
}
}
