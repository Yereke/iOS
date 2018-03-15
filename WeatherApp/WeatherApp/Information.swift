//
//  File.swift
//  WeatherApp
//
//  Created by MacBook on 15.03.2018.
//  Copyright © 2018 MacBook. All rights reserved.
//

import Foundation

class Information{
    var city:String?
    var hum:String?
    var temp:String?
    var speed:String?
    var sunrise:String?
    var sunset:String?
    
    init(_ city:String,_ hum:String,speed:String,sunrise:String,_ sunset:String,_ temp:String) {
        
        self.city = city
        self.hum = hum
        self.speed = speed
        self.sunrise = sunrise
        self.sunset = sunset
        self.temp = temp
        
    }
    
}
