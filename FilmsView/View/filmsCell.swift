//
//  filmsCell.swift
//  FilmsView
//
//  Created by apple on 4/17/19.
//  Copyright © 2019 mohamed. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext
class filmsCell: UITableViewCell {
    var favList: [Favorite] = []
    
    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var filmNameLbl: UILabel!
    @IBOutlet weak var filmDescribtionLbl: UITextView!
    @IBAction func addPressed(_ sender: Any) {
        fetchRequest()
        let favorite = Favorite(context: context)
        favorite.filmName = filmNameLbl.text
        favorite.filmDes = filmDescribtionLbl.text
        favorite.filmImage = filmImage.image
        do {
            try appDelegate.saveContext()
            print("saved")
        }catch{
            debugPrint("we have error: \(error)")
        }
       // FavoriteVC.inistance.fetchRequest()
    }
    func fetchRequest() {
        do {
            let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
            favList = try context.fetch(fetchRequest) as! [Favorite]
            print("fetch succ")
            print("load succ")
        }catch{
            debugPrint("we have error \(error.localizedDescription)")
        }
        if favList.count > 0 {
            for item in favList {
                if item.filmName == filmNameLbl.text {
                    context.delete(item)
                    do {
                        try context.save()
                        print("successfly remove goal")
                    }catch{
                        debugPrint("could not remove: \(error.localizedDescription)")
                    }
                }
            }
        }
       
    }
}
