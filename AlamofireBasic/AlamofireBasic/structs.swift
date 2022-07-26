//
//  structs.swift
//  AlamofireBasic
//
//  Created by 박솔미 on 2022/07/27.
//

import UIKit

struct DummyData:Codable {
    let data    : [PersonInfo]
    let total   : Int
    let page    : Int
    let limit   : Int
}

struct PersonInfo:Codable {
    let id : String
    let title : String
    let firstName : String
    let lastName : String
    let picture : URL?
}

struct PersonDetail: Codable {
    
    let id          : String
    let title       : String
    let firstName   : String
    let lastName    : String
    let picture     : URL?
    let gender      : String
    let email       : String
    let dateOfBirth : String
    let phone       : String
    let location    : Location?
    let registerDate: String
    let updateDate  : String
}

struct Location: Codable {
    
    let street      : String
    let city        : String
    let state       : String
    let country     : String
    let timezone    : String
}
