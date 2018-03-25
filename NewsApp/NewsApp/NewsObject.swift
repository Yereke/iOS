//
//  News.swift
//  NewsApp
//
//  Created by MacBook on 23.03.2018.
//  Copyright © 2018 MacBook. All rights reserved.
//

import Foundation
import ObjectMapper

class NewsObject:Mappable{

    var image:String?
    var title:String?
    var date:String?
    var shortIngormation:String?
    var description:String?
    
    init(_ image:String,_ title:String,_ shortIngormation:String,_ date:String,_ description:String) {
        self.image = image
        self.title = title
        self.date = date
        self.shortIngormation = shortIngormation
        self.description = description
    }

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        image <- map["link"]
        title <- map["title"]
        date <- map["date"]
        shortIngormation <- map["short_info"]
        description <- map["description"]
    }
}
