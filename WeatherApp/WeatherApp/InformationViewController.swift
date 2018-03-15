//
//  InformationViewController.swift
//  WeatherApp
//
//  Created by MacBook on 15.03.2018.
//  Copyright © 2018 MacBook. All rights reserved.
//

import UIKit
import Cartography

class InformationViewController: UIViewController {
    
    var delegate:WeatherInformationDelegate?
    
    var array:[Information] = Array()
    var index:Int?
    
    lazy var Label1:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "City"
        return label
    }()
    
    lazy var Label2:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 20)
        return label
    }()
    
    lazy var Label3:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "Temperature"
        return label
    }()
    
    lazy var Label4:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 20)
        return label
    }()
    
    lazy var Label5:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "Humidity"
        return label
    }()
    
    lazy var Label6:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 20)
        return label
    }()
    
    lazy var Label7:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "Wind Speed"
        return label
    }()
    
    lazy var Label8:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 20)
        return label
    }()
    
    lazy var Label9:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "Sunsire"
        return label
    }()
    
    lazy var Label10:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 20)
        return label
    }()
    
    lazy var Label11:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "Sunset"
        return label
    }()
    
    lazy var Label12:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 20)
        return label
    }()
    
    var information: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Label2.text = array[index!].city
        Label4.text = array[index!].sunrise
        Label6.text = array[index!].hum
        Label8.text = array[index!].speed
        Label10.text = array[index!].temp
        Label12.text = array[index!].sunset
        
        self.view.backgroundColor = #colorLiteral(red: 0.6732994914, green: 1, blue: 0.7220166326, alpha: 1)
        setUpViews()
    }
    
    @objc func setUpViews(){
        
        self.view.addViews([Label1,Label2,Label3,Label4,Label5,Label6,Label7,Label8,Label9,Label10,Label11,Label12])
        
        constrain(Label1,Label2,Label3,Label4,Label5){Label1,Label2,Label3,Label4,Label5 in
            Label1.top == Label1.superview!.top + 78
            Label1.leading == Label1.superview!.leading + 10
            
            Label2.top == Label1.top
            Label2.trailing == Label1.superview!.trailing - 10
            
            Label3.top == Label1.bottom + 10
            Label3.leading == Label1.leading
            
            Label4.top == Label3.top
            Label4.trailing == Label2.trailing
            
            Label5.top == Label3.bottom + 10
            Label5.leading == Label3.leading
        }
        
        constrain(Label6,Label7,Label8,Label9,Label5){Label6,Label7,Label8,Label9,Label5 in
            Label6.top == Label5.top
            Label6.trailing == Label5.superview!.trailing - 10
            
            Label7.top == Label5.bottom + 10
            Label7.leading == Label5.leading
            
            Label8.top == Label7.top
            Label8.trailing == Label6.trailing
            
            Label9.top == Label7.bottom + 10
            Label9.leading == Label5.leading
        }
        
        constrain(Label9,Label10,Label11,Label12){Label9,Label10,Label11,Label12 in
            Label10.top == Label9.top
            Label10.trailing == Label9.superview!.trailing - 10
            
            Label11.top == Label9.bottom + 10
            Label11.leading == Label9.leading
            
            Label12.top == Label11.top
            Label12.trailing == Label11.superview!.trailing - 10
            
        }
    }
}
