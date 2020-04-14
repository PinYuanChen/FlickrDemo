//
//  PhotoResultModel.swift
//  FlickrDemo
//
//  Created by 陳品元 on 2020/4/14.
//  Copyright © 2020 ChenPinYuan. All rights reserved.
//

import Foundation

struct Photo: Decodable {
    let farm: Int
    let secret: String
    let id: String
    let server: String
    let title: String
    var imageUrl: URL {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg")!
    }
}

struct Photos: Decodable {
    let photo: [Photo]
}

struct SearchResult: Decodable {
    let photos: Photos
}
