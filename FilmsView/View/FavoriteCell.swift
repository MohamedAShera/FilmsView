//
//  FavoriteCell.swift
//  FilmsView
//
//  Created by apple on 4/19/19.
//  Copyright © 2019 mohamed. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    @IBOutlet weak var filmDescriptionlbl: UITextView!
    @IBOutlet weak var filmNameLbl: UILabel!
    @IBOutlet weak var filmImage: UIImageView!
    
    func setCell(favorite: Favorite) {
       filmNameLbl.text = favorite.filmName
        filmDescriptionlbl.text = favorite.filmDes
        filmImage.image = favorite.filmImage as! UIImage
    }
  

}
