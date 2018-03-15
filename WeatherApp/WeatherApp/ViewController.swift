//
//  ViewController.swift
//  WeatherApp
//
//  Created by MacBook on 15.03.2018.
//  Copyright © 2018 MacBook. All rights reserved.
//

import UIKit
import Cartography
import Alamofire

protocol WeatherInformationDelegate {
    var inormation:[Information]{get set}
}

class ViewController: UIViewController,WeatherInformationDelegate {
    
    var inormation:[Information] = Array()
    
    lazy var weatherLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "What's the weather?"
        label.textColor = #colorLiteral(red: 0.07465196401, green: 0.07467246801, blue: 0.0746492669, alpha: 1)
        label.font = UIFont(name: "Helvetica", size: 35)
        return label
    }()
    
    lazy var cityLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter your city"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6745708627)
        label.font = UIFont(name: "Helvetica", size: 20)
        
        return label
    }()
    
    lazy var searchCityTextView:UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.sublayerTransform = CATransform3DMakeTranslation(10, 2, 0)
        text.font = UIFont(name: "Helvetica", size: 17)
        text.layer.cornerRadius = 5
        text.attributedPlaceholder = NSAttributedString(string: "E.g Almaty,New York",
                                                        attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.7022803426, green: 0.6972058415, blue: 0.7061670423, alpha: 1)])
        text.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        text.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return text
    }()
    
    lazy var submit:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        button.addTarget(self, action: #selector(getData), for: .touchUpInside)
        return button
    }()
    
    lazy var toHistory:UIButton = {
        let image = UIButton()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.setImage(#imageLiteral(resourceName: "history"), for: .normal)
        image.addTarget(self, action: #selector(ButtontoHistory), for: .touchUpInside)
        return image
    }()
    
    lazy var information:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.07465196401, green: 0.07467246801, blue: 0.0746492669, alpha: 1)
        label.font = UIFont(name: "Helvetica", size: 20)
        label.numberOfLines = 6
        return label
    }()
    
    lazy var loadind:UIActivityIndicatorView = {
        let load = UIActivityIndicatorView()
        load.translatesAutoresizingMaskIntoConstraints = false
        return load
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = #colorLiteral(red: 0.6732994914, green: 1, blue: 0.7220166326, alpha: 1)
        setUpViews()
        
        loadind.hidesWhenStopped = true
        loadind.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge

        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func ButtontoHistory(){
        let vc = HistoryViewController()
        vc.delegate = self
        self.show(vc, sender: self)
    }
    
    
    @objc func setUpViews(){
        self.view.addViews([weatherLabel,cityLabel,searchCityTextView,submit,toHistory,information])
        submit.addSubview(loadind)
        
        constrain(weatherLabel,cityLabel,searchCityTextView,submit,toHistory){weatherLabel,cityLabel,searchCityTextView,submit,toHistory in
            weatherLabel.top == weatherLabel.superview!.top + 100
            weatherLabel.centerX == weatherLabel.superview!.centerX
            
            cityLabel.top == weatherLabel.bottom + 20
            cityLabel.centerX == weatherLabel.centerX
            
            searchCityTextView.width == searchCityTextView.superview!.width - 40
            searchCityTextView.height == 40
            searchCityTextView.centerX == cityLabel.centerX
            searchCityTextView.top == cityLabel.bottom + 30
            
            submit.top == searchCityTextView.bottom + 25
            submit.width == 120
            submit.height == 50
            submit.centerX == searchCityTextView.centerX
            
            toHistory.top == toHistory.superview!.top + 30
            toHistory.trailing == toHistory.superview!.trailing - 10
            toHistory.width == 35
            toHistory.height == 35
        }
        constrain(information,submit,loadind){information,submit,loadind in
            information.top == submit.bottom + 25
            information.leading == submit.superview!.leading + 40
            
            loadind.centerX == submit.centerX
            loadind.centerY == submit.centerY
        }
    }
    
    @objc func getData(){
        var label:[String] = Array()
        
        var bool:Bool = true
    
        var text:String = ""
        loadind.startAnimating()
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?q=\(searchCityTextView.text!)&appid=14f0e4f423139dbeac41fda627a2c096").responseJSON { response in
            
            if let result = response.result.value as? NSDictionary{
                if let code = result["message"] as? String{
                    if (code == "city not found" ){
                        bool = false
                        self.isError("City not found")
                    }else if((code == "Nothing to geocode" )){
                        bool = false
                        self.isError("Must not be empty")
                    }
                }else{
                    bool = true
                }
                if bool {
                    if let city = result["name"] as? String{
                        label.append(city)
                        text += "City:  \(city) \n"
                    }
                    if let main = result["main"] as? NSDictionary{
                        if let temp = main["temp"] as? Double{
                            label.append("\(temp - 273.15)")
                        }
                        if let hum = main["humidity"] as? Double{
                            label.append("\(hum)")
                            text += "Humidity:  \(hum) \n"
                        }
                    }
                    if let main = result["wind"] as? NSDictionary{
                        if let speed = main["speed"] as? Double{
                            label.append("\(speed)")
                            text += "Speed:  \(speed)\n"
                        }
                    }
                    if let sys = result["sys"] as? NSDictionary{
                        if let sunrise = sys["sunrise"] as? Double{
                            let date = NSDate(timeIntervalSince1970: sunrise)
                            
                            let dayTimePeriodFormatter =  DateFormatter()
                            dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm a"
                            
                            let dateString = dayTimePeriodFormatter.string(from: date as Date)
                            label.append(dateString)
                            text += "Sunrise:  \(dateString)\n"
                        }
                        if let sunset = sys["sunset"] as? Double{
                            let date = NSDate(timeIntervalSince1970: sunset)
                            
                            let dayTimePeriodFormatter =  DateFormatter()
                            dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm a"
                            
                            let dateString = dayTimePeriodFormatter.string(from: date as Date)
                            label.append(dateString)
                            text += "Sunset:  \(dateString)\n"
                        }
                    }
                    self.information.text = text
                    let array = Information.init(label[0], label[1], speed: label[2], sunrise: label[3], label[4],label[5])
                    self.inormation.append(array)
                }
            }
        }
        loadind.stopAnimating()
    }
    
    @objc func isError(_ error:String){
        
        let alert = UIAlertController(title: error, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
        }))
        self.present(alert, animated: true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension UIView{
    func addViews(_ view:[UIView]){
        for i in view{
            self.addSubview(i)
        }
    }
}

