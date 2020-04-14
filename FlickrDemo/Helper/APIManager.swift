//
//  APIManager.swift
//  FlickrDemo
//
//  Created by 陳品元 on 2020/4/13.
//  Copyright © 2020 ChenPinYuan. All rights reserved.
//

import UIKit

public let API_KEY = "c6803091fc2cbc128712d991de9f2b07"

class APIManager {
   static let shared = APIManager()
    func fetchData(_ keyword:String, _ perPage:String, handler: @escaping ([Photo]?) -> ()) {
        if let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(API_KEY)&text=\(keyword)&per_page=\(perPage)&format=json&nojsoncallback=1") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let searchResult = try? JSONDecoder().decode(SearchResult.self, from: data) {
                    handler(searchResult.photos.photo)
                } else {
                    handler(nil)
                }
            }
            task.resume()
        }
    }
    
    func fetchImage(_ url:URL, handler: @escaping (UIImage?) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                handler(image)
            } else {
                handler(nil)
            }
        }
        task.resume()
    }
}
