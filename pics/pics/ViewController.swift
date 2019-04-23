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
}
struct Urls: Codable {
    let small: String
}
//nib

class TableViewController: UITableViewController {
    
    var imageList = [UIImage]()
    let imageCache = NSCache<NSString, UIImage>()
    var urlImage = ""
    var downloadedImage = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: "custom")
        
        let jsonUrlString = "https://api.unsplash.com/photos/?client_id=a27d182e45416d7caf0c7a616b6bc8851e008a78d3795cb4f2ac174f70514139"
        guard let url = URL(string: jsonUrlString) else
        { return }
        URLSession.shared.dataTask(with: url) {(data, response, err) in
            
            if let data = data {
                let pictures = try? JSONDecoder().decode([Pics].self, from: data)
                //downloading images
                for imageUrl in pictures! {
                    if let url = URL(string: imageUrl.urls.small) {
                        
                        URLSession.shared.dataTask(with: url, completionHandler: { (imageData, response, error) in
                            DispatchQueue.main.async {
                                if let imageData = imageData {
                                    print(imageData)
                                    if let downloadedImage = UIImage(data: imageData) {
                                        self.imageCache.setObject(downloadedImage, forKey: NSString(string: imageUrl.urls.small))
                                        self.imageList.append(downloadedImage)
                                        self.tableView.reloadData()
                                    }
                                }
                            }
                            
                        }).resume()
                    }

                }
            }
        }.resume()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "custom") as! TableViewCell
        cell.unsplashImage.image = self.imageList[indexPath.row]
        print(self.imageCache)
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imageList.count
    }

}




//                    self.urlImage = imageUrl.urls.small
//                    let urlImages = URL(string: "\(self.urlImage)")
//                    self.downloadedImage.append( UIImage(contentsOfFile: "\(imageUrl.urls.small)"))
//
////                    print(imageUrl.urls.small)
////                    self.imageData = [cellData.init(image: #imageLiteral(resourceName: <#T##String#>))]
//                }
//                DispatchQueue.main.async {
//                    //show data to nib
//                    print("____________")
//                    print(self.imageData[0].image)
//                    if let downloadedImage = UIImage(data: self.urlImage) {
//                        imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
//                        self.image = downloadedImage
//                    }
