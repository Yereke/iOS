//
//  HistoryViewController.swift
//  WeatherApp
//
//  Created by MacBook on 15.03.2018.
//  Copyright © 2018 MacBook. All rights reserved.
//

import UIKit
import Cartography

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var delegate:WeatherInformationDelegate?
    
    let tableView = UITableView()
    
    lazy var dismiss:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Dismiss", for: .normal)
        button.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        button.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
        return button
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (delegate?.inormation.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = (delegate?.inormation[indexPath.row].city)! + " | " + (delegate?.inormation[indexPath.row].temp)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = InformationViewController()
        vc.delegate = self as? WeatherInformationDelegate
        vc.array = (delegate?.inormation)!
        vc.index = (tableView.indexPathForSelectedRow?.row)!
        self.show(vc, sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            delegate?.inormation.remove(at: indexPath.row)
        }
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "History"
        self.navigationController?.isNavigationBarHidden = false
        
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        tableView.delegate = self
        tableView.dataSource = self
        setUpView()
    }
    
    @objc func popViewController(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func setUpView(){
        self.view.addSubview(tableView)
        self.view.addSubview(dismiss)
        constrain(tableView,dismiss){tableView,dismiss in
            tableView.width == tableView.superview!.width
            tableView.height == tableView.superview!.height - 70
            
            dismiss.bottom == tableView.superview!.bottom - 20
            dismiss.width == 120
            dismiss.height == 50
            dismiss.centerX == tableView.centerX
        }
    }

}
