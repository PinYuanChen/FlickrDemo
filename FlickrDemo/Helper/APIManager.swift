//
//  APIManager.swift
//  FlickrDemo
//
//  Created by 陳品元 on 2020/4/13.
//  Copyright © 2020 ChenPinYuan. All rights reserved.
//

import UIKit

public let API_KEY = "429acbd3cc7bce7a29a25aa8d57bd05b"

class APIManager {
   static let shared = APIManager()
    
    func generateURL(_ keyword:String, _ perPage:String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.flickr.com"
        components.path = "/services/rest/"
        components.queryItems = [
            URLQueryItem(name: "method", value: "flickr.photos.search"),
            URLQueryItem(name: "text", value: keyword),
            URLQueryItem(name: "per_page", value: perPage),
            URLQueryItem(name: "api_key", value: API_KEY),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1")
        ]
        return components.url
    }
    
    func fetchData(_ keyword:String, _ perPage:String, handler: @escaping ([Photo]?) -> ()) {
        if let url = self.generateURL(keyword, perPage)
        {
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
