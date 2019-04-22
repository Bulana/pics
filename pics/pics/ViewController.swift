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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let jsonUrlString = "https://api.unsplash.com/photos/?client_id=a27d182e45416d7caf0c7a616b6bc8851e008a78d3795cb4f2ac174f70514139"
        print(jsonUrlString)
        guard let url = URL(string: jsonUrlString) else
        { return }
        
        URLSession.shared.dataTask(with: url) {(data, response, err) in
            if let data = data {
                let pictures = try? JSONDecoder().decode([Pics].self, from: data)
                print(pictures![0].user.name)
                print(pictures![1].user.name)
                print(pictures![2].user.name)
                print(pictures![3].user.name)
                print(pictures![4].user.name)
                print(pictures![5].user.name)
            }
//            let dataAsString = String(data: data, encoding: .utf8)
//            print(dataAsString)
//            do {
//                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//                print(json)
//            } catch let jsonErr {
//                print("Error serializing json", jsonErr)
//            }
        }.resume()
    }
}

