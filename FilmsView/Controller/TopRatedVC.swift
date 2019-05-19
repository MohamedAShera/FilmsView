//
//  TopRatedVCViewController.swift
//  FilmsView
//
//  Created by apple on 4/19/19.
//  Copyright © 2019 mohamed. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class TopRatedVC: UIViewController {
    var titles = [String]()
    var photos = [String]()
    var overview = [String]()
    var photoBasUrl = "https://image.tmdb.org/t/p/w500/"
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        readJson()
        
    }

}

extension TopRatedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "description") as! descriptionVC
        vc.mvtitle = titles[indexPath.row]
        vc.overview = overview[indexPath.row]
        vc.photo = photos[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ratedCell") as! TopRatedCell
        cell.filmName.text = titles[indexPath.row]
        cell.filmDes.text = overview[indexPath.row]
        let url = URL(string: photos[indexPath.row])
        cell.filmImage.kf.setImage(with: url)
        cell.selectionStyle = .default
        return cell
        
    }
    
    func readJson() {
        Alamofire.request("https://api.themoviedb.org/3/movie/top_rated?api_key=c63b807fa4ece444d23a94e2ba3a7c5e").responseJSON { (response) in
            if response.result.value != nil
            {
                let JsonData = try! JSON(data: response.data!)
                print(JsonData)
                
                let data = JsonData["results"].array
                
                for i in data!
                {
                    self.titles.append(i["original_title"].string!)
                    self.overview.append(i["overview"].string! )
                    self.photos.append(self.photoBasUrl+i["poster_path"].string!)
                }
                self.tableView.reloadData()
            }
            
        }
    }
    
    
}

extension TopRatedVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchjson()
    }
    func searchjson() {
        Alamofire.request("https://api.themoviedb.org/3/search/movie?api_key=c63b807fa4ece444d23a94e2ba3a7c5e&query=" + searchBar.text!).responseJSON { (response)in
            if response.result.value != nil {
                let JsonData = try! JSON(data: response.data!)
                print(JsonData)
                
                let data = JsonData["results"].array
                self.titles.removeAll()
                self.photos.removeAll()
                self.overview.removeAll()
                for i in data! {
                    self.titles.append(i["original_title"].string!)
                    self.overview.append(i["overview"].string!)
                    if i["poster_path"].string != nil {
                        self.photos.append(self.photoBasUrl+i["poster_path"].string!)
                    }else{
                        debugPrint("No Photo")
                    }
                    
                }
                self.tableView.reloadData()
                self.view.endEditing(true)
            }
        }
    }
}
