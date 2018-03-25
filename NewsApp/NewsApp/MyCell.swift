//
//  CustomTableViewCell.swift
//  NewsApp
//
//  Created by MacBook on 23.03.2018.
//  Copyright © 2018 MacBook. All rights reserved.
//

import UIKit
import Cartography

class MyCell:UITableViewCell{
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    lazy var Title:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Helvetica-Bold", size: 18)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var Date:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.7729423415)
        label.font = UIFont(name: "Helvetica-Bold", size: 18)
        return label
    }()
    
    lazy var Image:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var View:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var loadind:UIActivityIndicatorView = {
        let load = UIActivityIndicatorView()
        load.translatesAutoresizingMaskIntoConstraints = false
        load.hidesWhenStopped = true
        load.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        return load
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        
        self.addViews([Image,View])
        self.View.addViews([Title,Date])
        self.Image.addSubview(loadind)
        
        constrain(Title,Date,Image,View,loadind){Title,Date,Image,View,loadind in
            Image.width == 80
            Image.height == 80
            Image.centerY == Image.superview!.centerY
            Image.leading == Image.superview!.leading + 15
            
            loadind.centerX == loadind.superview!.centerX
            loadind.centerY == loadind.superview!.centerY
            
            View.centerY == Image.centerY
            View.width == View.superview!.width - 145
            View.leading == Image.trailing + 15
            View.height == Image.height
            
            Title.top == Title.superview!.top + 4
            Title.width == Title.superview!.width
            Title.leading == Title.superview!.leading
            
            Date.bottom == Title.superview!.bottom - 4
            Date.leading == Title.superview!.leading
        }
    }
}

class MyNewsCell:UITableViewCell{
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
        
    lazy var Date:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.688542068, green: 0.6924011111, blue: 0.701913774, alpha: 1)
        label.font = UIFont(name: "Helvetica", size: 14)
        return label
    }()
    
    lazy var Title:UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var line:UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6259688735, green: 0.6260765791, blue: 0.6259546876, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var shortInfo:UILabel = {
        let label = UILabel()
        label.numberOfLines = 10
        label.font = UIFont(name: "Helvetica", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var Description:UITextView = {
        let label = UITextView()
        label.isScrollEnabled = false
        label.sizeToFit()
        label.font = UIFont(name: "Helvetica", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
       self.addViews([Title,Date,Description,shortInfo,line])
        constrain(Date,Title,Description,shortInfo,line){Title,Date,Description,shortInfo,line in
            
            Title.top == Date.superview!.top + 15
            Title.leading == Title.superview!.leading + 16
            
            Date.top == Title.bottom + 20
            Date.leading == Date.superview!.leading + 16
            Date.width == Date.superview!.width - 60
            
            shortInfo.top == Date.bottom + 20
            shortInfo.width == Description.superview!.width - 32
            shortInfo.centerX == Description.superview!.centerX
            
            line.top == shortInfo.bottom + 18
            line.width == 100
            line.centerX == line.superview!.centerX
            line.height == 1
            
            Description.top == line.bottom + 10
            Description.width == Description.superview!.width - 32
            Description.centerX == Description.superview!.centerX
            Description.bottom == Description.superview!.bottom - 120
            
        }
    }
}


extension UIView{
    func addViews(_ views:[UIView]){
        for i in views{
            self.addSubview(i)
        }
    }
}

