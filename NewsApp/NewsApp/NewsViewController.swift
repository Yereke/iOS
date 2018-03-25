//
//  NewsViewController.swift
//  NewsApp
//
//  Created by MacBook on 23.03.2018.
//  Copyright © 2018 MacBook. All rights reserved.
//

import UIKit
import Cartography
import BulletinBoard
import AlamofireImage
import ParallaxHeader

class NewsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var delegate:NewsInformationDelegate?
    var index:Int?
    
    lazy var tableView:UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.register(MyNewsCell.self, forCellReuseIdentifier: "myCell")
        return view
    }()
    
    lazy var headerImageView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var imageView:UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        if let url = URL(string: (delegate?.InfoArray[index!].image!)!){
            view.af_setImage(withURL: url)
        }else{
            view.image = #imageLiteral(resourceName: "EmtyImages")
        }
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var reportError:UIButton = {
        let button = UIButton()
        button.setTitle("Report an error", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        button.addTarget(self, action: #selector(report), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var bulletinManager: BulletinManager = {
        
        let page1 = PageBulletinItem(title: "Report an error")
        page1.image = UIImage(named: "female")
        page1.descriptionText = "If a news misclassified you can send a report"
        page1.actionButtonTitle = "Send"
        page1.alternativeButtonTitle = "Cancel"
        
        let page2 = PageBulletinItem(title: "Report sent")
        page2.image = UIImage(named: "ok")
        page2.descriptionText = "Report successfully sent"
        page2.actionButtonTitle = "Dismiss"
        
        page1.actionHandler = { (item: PageBulletinItem) in
            item.manager?.displayActivityIndicator()
            item.manager?.push(item: page2)
            item.displayNextItem()
        }
        
        page1.alternativeHandler = { (item: PageBulletinItem) in
            item.manager?.dismissBulletin(animated:true)
        }
        
        page2.actionHandler = { (item: PageBulletinItem) in
            item.manager?.dismissBulletin(animated:true)
        }
        
        return BulletinManager(rootItem: page1)
        
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyNewsCell
        
        cell.Date.text = delegate?.InfoArray[index!].date
        cell.Description.text = delegate?.InfoArray[index!].description
        cell.Title.text = delegate?.InfoArray[index!].title
        cell.shortInfo.text = delegate?.InfoArray[index!].shortIngormation
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        setUpViews()
        setupParallaxHeader()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "News"
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    @objc func report(){
        bulletinManager.backgroundViewStyle = .blurredDark
        bulletinManager.prepare()
        bulletinManager.presentBulletin(above: self)
    }
    
    @objc func setUpViews(){
        self.view.addViews([tableView,headerImageView,reportError])
        constrain(tableView,headerImageView,reportError){tableView,headerImageView,reportError in
            tableView.height == tableView.superview!.height
            tableView.width == tableView.superview!.width
            tableView.top == tableView.superview!.top + 64
            
            reportError.bottom == reportError.superview!.bottom
            reportError.height == 50
            reportError.width == reportError.superview!.width
        }
    }
    
    @objc private func setupParallaxHeader() {

        headerImageView = imageView
        
        tableView.parallaxHeader.view = imageView
        tableView.parallaxHeader.height = 200
        tableView.parallaxHeader.minimumHeight = 0
        tableView.parallaxHeader.mode = .topFill
        
    }
    
}
