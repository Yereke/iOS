//
//  PositiveViewController.swift
//  NewsApp
//
//  Created by MacBook on 23.03.2018.
//  Copyright © 2018 MacBook. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Cartography
import AlamofireImage
import SwiftyJSON
import ObjectMapper
import NVActivityIndicatorView
import TableFlip
import Kingfisher

protocol NewsInformationDelegate {
    var InfoArray:[NewsObject]{get set}
}

class PositiveViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,IndicatorInfoProvider,NewsInformationDelegate,NVActivityIndicatorViewable {
    
    var InfoArray: [NewsObject] = Array()
    
    lazy var animatied:NVActivityIndicatorView = {
        let animatied = NVActivityIndicatorView(frame: .init(x: self.view.frame.width/2 - self.view.frame.width/16, y: self.view.frame.height/2 - self.view.frame.width/6, width: self.view.frame.width/6, height: self.view.frame.width/6), type: .pacman, color: .blue, padding: 0)
        return animatied
    }()
    
    lazy var tableView:UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.register(MyCell.self, forCellReuseIdentifier: "myCell")
        return view
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return InfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyCell
        cell.Title.text = InfoArray[indexPath.row].title
        cell.Date.text = InfoArray[indexPath.row].date
        cell.Image.layer.masksToBounds = true
        cell.Image.layer.cornerRadius = 10
        cell.loadind.startAnimating()
        if let url = URL(string: InfoArray[indexPath.row].image!){
            let recurce = ImageResource(downloadURL: url, cacheKey: InfoArray[indexPath.row].image!)
            cell.Image.kf.setImage(with: recurce)
            cell.loadind.stopAnimating()
        }else{
            cell.Image.image = #imageLiteral(resourceName: "EmtyImages")
            cell.loadind.stopAnimating()
        }
        return cell
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Positive")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewsViewController()
        vc.index = indexPath.row
        vc.delegate = self
        self.show(vc, sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animatied.startAnimating()
        fetchPositiveNewsFromApi()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animatied.stopAnimating()
        tableView.reloadData()
        tableFlip()
        setUpViews()
        
    }
    
    
    @objc func tableFlip(){
    
        let customAnimation = TableViewAnimation.Cell.fade(duration: 0.6)
        self.tableView.animate(animation: customAnimation, completion: nil)
        
    }
    
    @objc func setUpViews(){
        self.view.addViews([tableView,animatied])
        
        constrain(tableView){tableView in
            tableView.height == self.view.frame.height - 68
            tableView.width == (tableView.superview?.width)!
        }
    }
    
    @objc func fetchPositiveNewsFromApi(){
        if let path = Bundle.main.path(forResource: "neg", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonData = try JSON(data: data)
                
                if jsonData != JSON.null {
                    let result = Mapper<NewsObject>().mapArray(JSONString: "\(jsonData)")
                    for i in result!{
                        InfoArray.append(NewsObject.init(i.image!, i.title!, i.shortIngormation!, i.date!, i.description!))
                    }
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
}


