//
//  ViewController.swift
//  pics
//
//  Created by Bulana on 2019/04/22.
//  Copyright © 2019 Bulana. All rights reserved.
//

import UIKit

//modal object
struct Pics: Codable {
    let id: String
    let urls: Urls
    let user: User
}
struct User: Codable {
    let name: String
    var bio: String?
}
struct Urls: Codable {
    let small: String
}

class TableViewController: UITableViewController {
    var imageList = [UIImage]()
    let imageCache = NSCache<NSString, UIImage>()
    var downloadedImage = [UIImage]()
    var unsplashDataModel = [Pics]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "custom")
        let jsonUrlString = "https://api.unsplash.com/photos/?client_id=a27d182e45416d7caf0c7a616b6bc8851e008a78d3795cb4f2ac174f70514139&per_page=100"
        guard let url = URL(string: jsonUrlString) else
        { return }
        
        URLSession.shared.dataTask(with: url) {(data, response, err) in
            if let data = data {
                if let dataModel = try? JSONDecoder().decode([Pics].self, from: data) {
                    DispatchQueue.main.async {
                        self.unsplashDataModel = dataModel
                        self.tableView.reloadData()
                    }
                }
            }}.resume()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "custom") as! TableViewCell
        cell.user.text = self.unsplashDataModel[indexPath.row].user.name
        if let bioData = self.unsplashDataModel[indexPath.row].user.bio {
            cell.biography.text = bioData
        }
        let imageUrl = self.unsplashDataModel[indexPath.row].urls.small
        if let imageFromCache = imageCache.object(forKey: NSString(string: imageUrl)) {
            cell.unsplashImage.image = imageFromCache
        }else {
            if let url = URL(string: imageUrl) {
                URLSession.shared.dataTask(with: url, completionHandler: { [imageCache] (imageData, response, error) in
                    if let imageData = imageData {
                        if let downloadedImage = UIImage(data: imageData) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: imageUrl))
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
                    }
                }).resume()
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.unsplashDataModel.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let currentImage = self.imageCache.object(forKey: NSString(string: unsplashDataModel[indexPath.row].urls.small)) {
            let cropImage = currentImage.getCropRatio()
            return 250*cropImage
        }
        return 80.0
    }
}

extension UIImage {
    func getCropRatio() -> CGFloat {
        let widthRatio = CGFloat(self.size.height/self.size.width)
        return widthRatio
    }

}
