//
//  UserModel.swift
//  PracticeURLSeassion
//
//  Created by User on 09.04.25.
//

import UIKit

struct UserModel:Decodable {
    let id:Int
    let name:String
    let username:String
    let email:String
    let address :AdressModel
    let company:CompanyModel
}
struct AdressModel:Decodable {
    let street:String
    let suite:String
    let city:String
    let zipcode:String
    let geo:GeoModel
}
struct GeoModel:Decodable {
    let lat:String
    let lng:String
}
struct CompanyModel: Decodable{
    let name:String
    let catchPhrase:String
    let bs:String
}
