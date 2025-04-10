//
//  PostModel.swift
//  PracticeURLSeassion
//
//  Created by User on 09.04.25.
//

import UIKit

struct PostListModel:Decodable {
    let posts:[PostModel]
}
struct PostModel:Decodable {
    let id:Int
    let title:String
    let body:String
    let tags:[String]
    let views:Int
    let userId:Int
}
