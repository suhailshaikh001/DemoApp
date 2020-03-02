//
//  AuthorModel.swift
//  DemoApp
//
//  Created by Suhail Shaikh on 02/03/20.
//  Copyright © 2020 Demo.com. All rights reserved.
//

import Foundation

enum cellName : String{
    case authorCell
}

struct AuthorElement: Decodable {
    let format: Format
    let width, height: Int
    let filename: String
    let id: Int
    let author: String
    let authorURL, postURL: String
    
    enum CodingKeys: String, CodingKey {
        case format, width, height, filename, id, author
        case authorURL = "author_url"
        case postURL = "post_url"
    }
}

enum Format: String, Decodable {
    case jpeg = "jpeg"
}

typealias Author = [AuthorElement]




