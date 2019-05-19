//
//  FavoriteVC.swift
//  FilmsView
//
//  Created by apple on 4/19/19.
//  Copyright © 2019 mohamed. All rights reserved.
//

import UIKit
import CoreData

class FavoriteVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var favList = [Favorite]()
    static let instance = FavoriteVC()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchRequest()

    }
    override func viewWillAppear(_ animated: Bool) {
        fetchRequest()
        //tableView.reloadData()
    }
    func removeGoal(atIndexPath indexPath: IndexPath) {
        context.delete(favList[indexPath.row])
        do {
            try context.save()
            tableView.reloadData()
            print("successfly remove goal")
        }catch{
            debugPrint("could not remove: \(error.localizedDescription)")
        }
    }
     func fetchRequest() {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        
        do {
            favList = try context.fetch(fetchRequest)
            print("fetch succ")
            tableView.reloadData()
             print("load succ")
        }catch{
            debugPrint("we have error \(error.localizedDescription)")
        }
    }
}

extension FavoriteVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FavoriteCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteCell
        cell.setCell(favorite: favList[indexPath.row]) // to put data into cell
        return cell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchRequest()
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        return [deleteAction]
    }
    
}
